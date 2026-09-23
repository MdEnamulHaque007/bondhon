import 'package:bondhon/app/router/app_router.dart';
import 'package:bondhon/app/theme/app_spacing.dart';
import 'package:bondhon/app/theme/theme_controller.dart';
import 'package:bondhon/core/localization/app_localizations.dart';
import 'package:bondhon/features/profile/data/profile_storage.dart';
import 'package:bondhon/features/profile/domain/entities/user_profile.dart';
import 'package:bondhon/shared/widgets/bondhon_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, this.storage, this.themeController});

  final ProfileStorage? storage;
  final ThemeController? themeController;

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
  late final ThemeController _themeController;
  late final bool _ownsThemeController;
  String _gender = UserProfile.guest.gender;
  bool _loading = true;
  bool _saving = false;
  bool _editing = false;

  @override
  void initState() {
    super.initState();
    _storage = widget.storage ?? ProfileStorage();
    _ownsThemeController = widget.themeController != null;
    _themeController = widget.themeController ?? ThemeController.instance;
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
    if (_ownsThemeController) _themeController.dispose();
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
                            leading: const Icon(Icons.palette_outlined),
                            title: const Text('Theme'),
                            subtitle: const Text('Customize Bondhon appearance'),
                            trailing: const Icon(Icons.chevron_right_rounded),
                            onTap: () => _openThemeSettings(context),
                          ),
                          const Divider(height: 1),
                          ListTile(
                            leading: const Icon(Icons.language_rounded),
                            title: Text(strings.language),
                            subtitle: Text(strings.languageSettingsInfo),
                          ),
                          const Divider(height: 1),
                          ListTile(
                            leading: const Icon(Icons.privacy_tip_outlined),
                            title: Text(strings.privacySettings),
                            subtitle: Text(strings.privacyLocalOnlyInfo),
                            onTap: () => context.go(AppRoutes.privacySettings),
                          ),
                          const Divider(height: 1),
                          ListTile(
                            leading: const Icon(Icons.admin_panel_settings_outlined),
                            title: Text(strings.adminDemo),
                            subtitle: Text(strings.adminDemoInfo),
                            onTap: () => context.go(AppRoutes.admin),
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

  Future<void> _openThemeSettings(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) => _ThemeSettingsSheet(controller: _themeController),
    );
    if (mounted) setState(() {});
  }
}

class _ThemeSettingsSheet extends StatelessWidget {
  const _ThemeSettingsSheet({required this.controller});

  final ThemeController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Theme Settings', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Choose a look for the entire Bondhon app.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.md),
              ...AppThemeVariant.values.map(
                (variant) => _ThemeOption(
                  variant: variant,
                  selected: controller.variant == variant,
                  onTap: () => controller.setVariant(variant),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ThemeOption extends StatelessWidget {
  const _ThemeOption({required this.variant, required this.selected, required this.onTap});

  final AppThemeVariant variant;
  final bool selected;
  final VoidCallback onTap;

  String get title => switch (variant) {
        AppThemeVariant.bondhon => 'Bondhon',
        AppThemeVariant.blue => 'Blue',
        AppThemeVariant.orange => 'Orange',
        AppThemeVariant.dark => 'Dark',
        AppThemeVariant.multicolor => 'Multicolor',
      };

  IconData get icon => switch (variant) {
        AppThemeVariant.bondhon => Icons.favorite_rounded,
        AppThemeVariant.blue => Icons.water_drop_rounded,
        AppThemeVariant.orange => Icons.wb_sunny_rounded,
        AppThemeVariant.dark => Icons.dark_mode_rounded,
        AppThemeVariant.multicolor => Icons.color_lens_rounded,
      };

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(child: Icon(icon)),
      title: Text(title),
      trailing: selected ? const Icon(Icons.check_circle_rounded) : null,
      selected: selected,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      onTap: onTap,
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
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Row(
          children: [
            CircleAvatar(
              radius: 38,
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              child: const Icon(Icons.person_rounded, size: 42),
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
