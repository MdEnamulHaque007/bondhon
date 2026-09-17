import 'package:bondhon/app/router/app_router.dart';
import 'package:bondhon/app/theme/app_colors.dart';
import 'package:bondhon/app/theme/app_spacing.dart';
import 'package:bondhon/core/localization/app_localizations.dart';
import 'package:bondhon/features/profile/data/profile_storage.dart';
import 'package:bondhon/features/profile/domain/entities/user_profile.dart';
import 'package:bondhon/shared/widgets/bondhon_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, this.storage});

  final ProfileStorage? storage;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _countryController = TextEditingController();
  final _bioController = TextEditingController();
  late final ProfileStorage _storage;
  String _gender = UserProfile.guest.gender;
  bool _loading = true;
  bool _saving = false;
  bool _editing = false;

  @override
  void initState() {
    super.initState();
    _storage = widget.storage ?? ProfileStorage();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final profile = await _storage.read();
    if (!mounted) return;
    setState(() {
      _nameController.text = profile.displayName;
      _usernameController.text = profile.username;
      _countryController.text = profile.country;
      _bioController.text = profile.bio;
      _gender = profile.gender;
      _loading = false;
    });
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final profile = UserProfile(
      displayName: _nameController.text.trim(),
      username: _usernameController.text.trim().toLowerCase(),
      gender: _gender,
      country: _countryController.text.trim(),
      bio: _bioController.text.trim(),
    );
    await _storage.write(profile);
    if (!mounted) return;
    setState(() {
      _saving = false;
      _editing = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context).profileSaved)),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _countryController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 760),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _ProfileHeader(
                      name: _nameController.text,
                      username: _usernameController.text,
                      guestLabel: strings.guestAccount,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    strings.personalInformation,
                                    style: Theme.of(context).textTheme.titleLarge,
                                  ),
                                ),
                                TextButton.icon(
                                  onPressed: _saving
                                      ? null
                                      : () => setState(() => _editing = !_editing),
                                  icon: Icon(_editing ? Icons.close : Icons.edit_outlined),
                                  label: Text(_editing ? strings.cancel : strings.editProfile),
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.md),
                            BondhonTextField(
                              label: strings.fullName,
                              controller: _nameController,
                              prefixIcon: Icons.badge_outlined,
                              enabled: _editing,
                              validator: (value) => value == null || value.trim().isEmpty
                                  ? strings.requiredField
                                  : null,
                            ),
                            const SizedBox(height: AppSpacing.md),
                            BondhonTextField(
                              label: strings.username,
                              controller: _usernameController,
                              prefixIcon: Icons.alternate_email_rounded,
                              enabled: _editing,
                              validator: (value) {
                                final username = value?.trim() ?? '';
                                if (username.isEmpty) return strings.requiredField;
                                if (!RegExp(r'^[a-zA-Z0-9_]{3,20}$').hasMatch(username)) {
                                  return strings.usernameHelp;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: AppSpacing.md),
                            DropdownButtonFormField<String>(
                              initialValue: _gender,
                              decoration: InputDecoration(
                                labelText: strings.gender,
                                prefixIcon: const Icon(Icons.people_outline_rounded),
                              ),
                              items: [
                                DropdownMenuItem(value: 'male', child: Text(strings.male)),
                                DropdownMenuItem(value: 'female', child: Text(strings.female)),
                                DropdownMenuItem(
                                  value: 'preferNotToSay',
                                  child: Text(strings.preferNotToSay),
                                ),
                              ],
                              onChanged: _editing
                                  ? (value) => setState(() => _gender = value!)
                                  : null,
                            ),
                            const SizedBox(height: AppSpacing.md),
                            BondhonTextField(
                              label: strings.country,
                              controller: _countryController,
                              prefixIcon: Icons.public_rounded,
                              enabled: _editing,
                              validator: (value) => value == null || value.trim().isEmpty
                                  ? strings.requiredField
                                  : null,
                            ),
                            const SizedBox(height: AppSpacing.md),
                            TextFormField(
                              controller: _bioController,
                              enabled: _editing,
                              maxLength: 160,
                              maxLines: 4,
                              decoration: InputDecoration(
                                labelText: strings.bio,
                                prefixIcon: const Icon(Icons.notes_rounded),
                                alignLabelWithHint: true,
                              ),
                            ),
                            if (_editing) ...[
                              const SizedBox(height: AppSpacing.sm),
                              FilledButton.icon(
                                onPressed: _saving ? null : _saveProfile,
                                icon: _saving
                                    ? const SizedBox.square(
                                        dimension: 18,
                                        child: CircularProgressIndicator(strokeWidth: 2),
                                      )
                                    : const Icon(Icons.save_outlined),
                                label: Text(strings.saveChanges),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Card(
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.language_rounded),
                            title: Text(strings.language),
                            subtitle: Text(strings.languageSettingsInfo),
                          ),
                          const Divider(height: 1),
                          ListTile(
                            leading: const Icon(Icons.block_rounded),
                            title: Text(strings.blockedUsers),
                            subtitle: Text(strings.blockedUsersInfo),
                            onTap: () => context.go(AppRoutes.blockedUsers),
                          ),
                          const Divider(height: 1),
                          ListTile(
                            leading: const Icon(Icons.logout_rounded),
                            title: Text(strings.exitGuestMode),
                            subtitle: Text(strings.exitGuestModeInfo),
                            onTap: () => context.go(AppRoutes.welcome),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({
    required this.name,
    required this.username,
    required this.guestLabel,
  });

  final String name;
  final String username;
  final String guestLabel;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.bondhonGreenSoft,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 38,
              backgroundColor: AppColors.bondhonGreen,
              child: Icon(Icons.person_rounded, size: 42, color: Colors.white),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: AppSpacing.xxs),
                  Text('@$username'),
                  const SizedBox(height: AppSpacing.xs),
                  Chip(
                    avatar: const Icon(Icons.person_outline_rounded, size: 18),
                    label: Text(guestLabel),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
