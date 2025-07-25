import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/cubit/theme/theme_cubit.dart';
import '../../../auth/logic/auth/auth_cubit.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../auth/data/models/app_user.dart';
import '../../../auth/data/repo/firebase_auth_repo.dart';
import 'custom_sliver_appbar.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<ProfileWidget> {
  bool _biometricsEnabled = false;

  AppUser? currentUser;

  Future<void> loadUser() async {
    final firebaseRepo = getIt<FirebaseRepo>();
    currentUser = await firebaseRepo.getCurrentUser();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  // final List<String> _languages = LanguageNames.supported;
  // final List<String> _languagesFlags = LanguageFlags.supported;

  @override
  Widget build(BuildContext context) {
    bool darkModeEnabled = context.watch<ThemeCubit>().state == ThemeMode.dark;
    // String language = localeNamesMap[context.locale.toString()] ??
    // LanguageNames.defaultLocale;
    return SafeArea(
      child: CustomScrollView(
        slivers: <Widget>[
          customAnimationAppbar(
            context: context,
            image: currentUser?.photoUrl ?? '',
            title: currentUser?.displayName ?? 'Guest',
            descripton: currentUser?.email ?? '',
            isActions: true,
          ),
          SliverPadding(
            padding: EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader('Account'),
                  _buildSettingsCard([
                    _buildSettingsTile(
                      icon: Icons.security,
                      title: 'Privacy & Security',
                      subtitle: 'Control your privacy settings',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PrivacyScreen()),
                        );
                      },
                    ),
                  ]),

                  const SizedBox(height: 24),

                  // Preferences Section
                  _buildSectionHeader('Preferences'),
                  _buildSettingsCard([
                    _buildSwitchTile(
                      icon: Icons.notifications_outlined,
                      title: 'Notifications',
                      subtitle: 'Enable Push Notifications',
                      // value: context.watch<AppCubit>().isNotificationEnabled,
                      value: true,
                      onChanged: (value) {
                        // context.read<AppCubit>().toggleNotifications();
                      },
                    ),
                    _buildSwitchTile(
                      icon: Icons.dark_mode_outlined,
                      title: 'Dark Mode',
                      subtitle: 'Enable dark mode',
                      value: darkModeEnabled,
                      onChanged: (value) {
                        context.read<ThemeCubit>().toggleTheme();
                      },
                    ),
                    _buildSwitchTile(
                      icon: Icons.fingerprint,
                      title: 'Biometric Authentication',
                      subtitle: 'Use Face ID or Fingerprint for quick access',
                      value: _biometricsEnabled,
                      onChanged: (value) {
                        setState(() {
                          _biometricsEnabled = value;
                        });
                      },
                    ),
                  ]),
                  const SizedBox(height: 24),
                  // Display Section
                  _buildSectionHeader('Display & Accessibility'),
                  _buildSettingsCard(
                    [
                      _buildDropdownTile(
                        icon: Icons.language,
                        title: 'language',
                        value: 'language',
                        items: [],
                        // items: _languages,
                        isFlagShow: true,
                        onChanged: (value) {
                          // if (value == null ||
                          //     context.locale == Locale(languageNamesMap[value]!)) {
                          //   return;
                          // }
                          // setState(() {
                          //   language = value;
                          //   context.setLocale(Locale(languageNamesMap[value]!));
                          // });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Support Section
                  _buildSectionHeader('Support & About'),
                  _buildSettingsCard([
                    _buildSettingsTile(
                      icon: Icons.help_outline,
                      title: 'Help & Support',
                      subtitle: 'Get help and support for any issues',
                      onTap: () {
                        // Navigate to help
                      },
                    ),
                    _buildSettingsTile(
                      icon: Icons.feedback_outlined,
                      title: 'Send Feedback',
                      subtitle: 'Help us improve the app',
                      onTap: () {},
                    ),
                    _buildSettingsTile(
                      icon: Icons.info_outline,
                      title: 'About',
                      subtitle: 'App Version and information',
                      onTap: () {
                        _showAboutDialog();
                      },
                    ),
                    _buildSettingsTile(
                      icon: Icons.logout,
                      title: 'Sign Out',
                      subtitle: 'Log out of your account',
                      onTap: () async {
                        await context.read<AuthCubit>().logout();
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('logout')),
                          );
                        }
                      },
                      textColor: Colors.red,
                    ),
                  ]),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 4),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildSettingsCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(10),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? textColor,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: (textColor ?? Colors.blue).withAlpha(10),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: textColor ?? Colors.blue,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
      subtitle: Text(subtitle),
      trailing:
          Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blue.withAlpha(10),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: Colors.blue,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(subtitle),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.blue,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
    );
  }

  Widget _buildDropdownTile({
    required IconData icon,
    required String title,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    bool isFlagShow = false,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blue.withAlpha(10),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: Colors.blue,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      trailing: DropdownButton<String>(
        value: value,
        items: List.generate(
          items.length,
          (index) {
            final item = items[index];
            return DropdownMenuItem<String>(
              value: item,
              child: Row(
                children: [
                  // Text(isFlagShow && _languagesFlags.length > index
                  //     ? _languagesFlags[index].toFlag
                  //     : ''),
                  const SizedBox(width: 8),
                  Text(item),
                ],
              ),
            );
          },
        ),
        onChanged: onChanged,
        underline: Container(),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('about_app'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('App Version: 1.0.0'),
              SizedBox(height: 8),
              Text('Build: 100'),
              SizedBox(height: 8),
              Text('© 2024 Your Company'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('cancel'),
            ),
          ],
        );
      },
    );
  }
}

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('privacy'),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSectionHeader('account_privacy'),
          _buildPrivacyTile(
            icon: Icons.visibility_off,
            title: 'profile_visibility',
            subtitle: 'profile_visibility_description',
            onTap: () => _showPrivacyOptions(context, 'profile_visibility'),
          ),
          const SizedBox(height: 12),
          _buildSectionHeader('legal'),
          _buildPrivacyTile(
            icon: Icons.description,
            title: 'privacy_policy',
            subtitle: 'privacy_policy_description',
            onTap: () => _showPrivacyPolicy(context),
          ),
          _buildPrivacyTile(
            icon: Icons.gavel,
            title: 'terms_of_service',
            subtitle: 'terms_of_service_description',
            onTap: () => _showTermsOfService(context),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red.withAlpha(10),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.red.withAlpha(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.warning, color: Colors.red[700], size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'danger_zone',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red[700],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => _showDeleteAccountDialog(context),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red[700],
                    padding: EdgeInsets.zero,
                  ),
                  child: Text('delete_account'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildPrivacyTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 1,
      child: ListTile(
        leading: Icon(icon, color: Colors.blue[600]),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  void _showPrivacyOptions(BuildContext context, String title) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.public),
                title: Text('everyone'),
                trailing: Radio(value: 0, groupValue: 1, onChanged: (value) {}),
              ),
              ListTile(
                leading: const Icon(Icons.people),
                title: Text('friends_only'),
                trailing: Radio(value: 1, groupValue: 1, onChanged: (value) {}),
              ),
              ListTile(
                leading: const Icon(Icons.lock),
                title: Text('only_me'),
                trailing: Radio(value: 2, groupValue: 1, onChanged: (value) {}),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    onPressed: () {},
                    child: Text('save_settings'),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showPrivacyPolicy(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('privacy_policy'),
          content: const SingleChildScrollView(
            child: Text(
              'This is where your privacy policy content would go. It should include information about data collection, usage, storage, and user rights.',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('close'),
            ),
          ],
        );
      },
    );
  }

  void _showTermsOfService(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('terms_of_service'),
          content: const SingleChildScrollView(
            child: Text(
              'This is where your terms of service content would go. It should include user agreements, prohibited uses, and service limitations.',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('close'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('delete_account'),
          content: Text(
            'delete_account_description',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _showSnackBar(context, 'delete_account_requested');
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: Text('delete_account'),
            ),
          ],
        );
      },
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
