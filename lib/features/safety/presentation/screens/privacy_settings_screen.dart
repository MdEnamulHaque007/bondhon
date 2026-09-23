import 'package:bondhon/app/router/app_router.dart';
import 'package:bondhon/app/theme/app_spacing.dart';
import 'package:bondhon/core/localization/app_localizations.dart';
import 'package:bondhon/features/safety/data/privacy_storage.dart';
import 'package:bondhon/features/safety/domain/entities/privacy_settings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PrivacySettingsScreen extends StatefulWidget {
  const PrivacySettingsScreen({super.key, this.storage});

  final PrivacyStorage? storage;

  @override
  State<PrivacySettingsScreen> createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  late final PrivacyStorage _storage;
  PrivacySettings _settings = const PrivacySettings();
  bool _loading = true;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _storage = widget.storage ?? PrivacyStorage();
    _load();
  }

  Future<void> _load() async {
    final settings = await _storage.read();
    if (!mounted) return;
    setState(() {
      _settings = settings;
      _loading = false;
    });
  }

  Future<void> _setValue(PrivacySettings settings) async {
    setState(() {
      _settings = settings;
      _saving = true;
    });
    await _storage.write(settings);
    if (mounted) setState(() => _saving = false);
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    if (_loading) return const Center(child: CircularProgressIndicator());

    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              Row(
                children: [
                  IconButton(
                    tooltip: strings.back,
                    onPressed: () => context.go(AppRoutes.profile),
                    icon: const Icon(Icons.arrow_back_rounded),
                  ),
                  Expanded(
                    child: Text(
                      strings.privacySettings,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  if (_saving)
                    const SizedBox.square(
                      dimension: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Card(
                child: Column(
                  children: [
                    _PrivacySwitch(
                      icon: Icons.visibility_outlined,
                      title: strings.lastSeenVisibility,
                      subtitle: strings.lastSeenVisibilityInfo,
                      value: _settings.lastSeenVisible,
                      onChanged: (value) => _setValue(
                        _settings.copyWith(lastSeenVisible: value),
                      ),
                    ),
                    const Divider(height: 1),
                    _PrivacySwitch(
                      icon: Icons.photo_outlined,
                      title: strings.profilePhotoVisibility,
                      subtitle: strings.profilePhotoVisibilityInfo,
                      value: _settings.profilePhotoVisible,
                      onChanged: (value) => _setValue(
                        _settings.copyWith(profilePhotoVisible: value),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Card(
                child: Column(
                  children: [
                    _PrivacySwitch(
                      icon: Icons.chat_bubble_outline_rounded,
                      title: strings.whoCanMessage,
                      subtitle: strings.whoCanMessageInfo,
                      value: _settings.allowMessages,
                      onChanged: (value) => _setValue(
                        _settings.copyWith(allowMessages: value),
                      ),
                    ),
                    const Divider(height: 1),
                    _PrivacySwitch(
                      icon: Icons.group_add_outlined,
                      title: strings.whoCanAddToGroup,
                      subtitle: strings.whoCanAddToGroupInfo,
                      value: _settings.allowGroupAdds,
                      onChanged: (value) => _setValue(
                        _settings.copyWith(allowGroupAdds: value),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.block_rounded),
                  title: Text(strings.blockedUsers),
                  subtitle: Text(strings.blockedUsersInfo),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () => context.go(AppRoutes.blockedUsers),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                strings.privacyLocalOnlyInfo,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PrivacySwitch extends StatelessWidget {
  const _PrivacySwitch({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile.adaptive(
      secondary: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
    );
  }
}
