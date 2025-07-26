import 'package:final_project/core/helpers/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/cubit/theme/theme_cubit.dart';
import '../../../../core/widgets/toast.dart';
import '../../../auth/logic/auth/auth_cubit.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../auth/data/models/app_user.dart';
import '../../../auth/data/repo/firebase_auth_repo.dart';
import '../../logic/notifications/notification_cubit.dart';
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

  final List<String> _languages = LanguageNames.supported;
  final List<String> _languagesFlags = LanguageFlags.supported;

  @override
  Widget build(BuildContext context) {
    bool darkModeEnabled = context.watch<ThemeCubit>().state == ThemeMode.dark;
    // String language = localeNamesMap[context.locale.toString()] ??
    // LanguageNames.defaultLocale;
    String language = LanguageNames.defaultLocale;
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
                      value: context
                          .watch<NotificationCubit>()
                          .isNotificationEnabled,
                      onChanged: (value) {
                        getIt<NotificationCubit>().toggleNotifications();
                      },
                    ),
                    _buildSwitchTile(
                      icon: Icons.dark_mode_outlined,
                      title: 'Dark Mode',
                      subtitle: 'Enable dark mode',
                      value: darkModeEnabled,
                      onChanged: (value) {
                        getIt<ThemeCubit>().toggleTheme();
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
                        value: language,
                        items: _languages,
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
                      onTap: () => context.push(HelpSupportScreen()),
                    ),
                    _buildSettingsTile(
                      icon: Icons.feedback_outlined,
                      title: 'Send Feedback',
                      subtitle: 'Help us improve the app',
                      onTap: () => context.push(SendFeedbackScreen()),
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
                          showSuccessToast(
                              context: context, message: "Logout successfully");
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
                  Text(isFlagShow && _languagesFlags.length > index
                      ? _languagesFlags[index].toFlag
                      : ''),
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
          title: Text('About App'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('App Version: 1.0.0'),
              SizedBox(height: 8),
              Text('Build: 100'),
              SizedBox(height: 8),
              Text('© 2024 Shopify'),
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
          _buildSectionHeader('Legal'),
          _buildPrivacyTile(
            icon: Icons.description,
            title: 'Privacy Policy',
            subtitle: 'Read our privacy policy',
            onTap: () => _showPrivacyPolicy(context),
          ),
          _buildPrivacyTile(
            icon: Icons.gavel,
            title: 'Terms of Service',
            subtitle: 'View terms and conditions',
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
                      'Danger Zone',
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
                  child: Text('Delete Account'),
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

  void _showPrivacyPolicy(BuildContext context) {
    context.push(PrivacyPolicyScreen());
  }

  void _showTermsOfService(BuildContext context) {
    context.push(TermsOfServiceScreen());
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Account'),
          content: Text(
            'This will permanently delete your account and all associated data. This action cannot be undone',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: Text('Delete Account'),
            ),
          ],
        );
      },
    );
  }
}

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            pinned: true,
            title: const Text("Help & Support"),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Text(
                  "We're here to help you with any issues or questions.",
                  style: textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                _buildSection(
                  title: "💡 Frequently Asked Questions",
                  items: [
                    "Q: How do I track my order?\nA: Go to My Orders > select your order > Track Order.",
                    "Q: I forgot my password. What should I do?\nA: Tap 'Forgot Password' on the login screen.",
                    "Q: How do I request a refund?\nA: Open the order > tap 'Request Refund'.",
                    "Q: I didn’t receive my item. What now?\nA: Contact support with your order number.",
                  ],
                  textTheme: textTheme,
                ),
                _buildSection(
                  title: "📬 Contact Support",
                  items: [
                    "Email: support@yourdomain.com",
                    "Phone: +1-234-567-890",
                    "Live Chat: Available in-app",
                    "Working Hours: 9 AM – 6 PM (GMT+3), Sun–Thu",
                  ],
                  textTheme: textTheme,
                ),
                _buildSection(
                  title: "🔧 Report a Problem",
                  items: [
                    "1. Go to the Support tab.",
                    "2. Tap 'Report a Problem'.",
                    "3. Fill out the form with details and screenshots.",
                  ],
                  textTheme: textTheme,
                ),
                const SizedBox(height: 32),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<String> items,
    required TextTheme textTheme,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(item, style: textTheme.bodyMedium),
            ),
          ),
        ],
      ),
    );
  }
}

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            title: Text("Privacy Policy"),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 2,
            shadowColor: Colors.black.withAlpha(10),
            surfaceTintColor: Colors.transparent,
            pinned: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Text(
                  "Effective Date: July 25, 2025",
                  style: textTheme.labelMedium?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 16),
                Text(
                  "Welcome to Shopify",
                  style: textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  "This Privacy Policy explains how we collect, use, and protect your personal information when you use the Shopify mobile app.",
                  style: textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                _buildSection(
                  title: "1. Information We Collect",
                  content: [
                    "• Name, email, phone number, and address",
                    "• Payment details (via third-party processors)",
                    "• Device and usage information",
                    "• Cookies and tracking technologies",
                  ],
                  textTheme: textTheme,
                ),
                _buildSection(
                  title: "2. How We Use Your Information",
                  content: [
                    "• Process orders and deliver products",
                    "• Provide customer support",
                    "• Improve the app experience",
                    "• Send updates and promotions",
                  ],
                  textTheme: textTheme,
                ),
                _buildSection(
                  title: "3. Sharing Your Information",
                  content: [
                    "We do not sell your data.",
                    "We may share your info with service providers, analytics tools, or legal authorities if necessary.",
                  ],
                  textTheme: textTheme,
                ),
                _buildSection(
                  title: "4. Data Security",
                  content: [
                    "We use technical and administrative safeguards to protect your data.",
                  ],
                  textTheme: textTheme,
                ),
                _buildSection(
                  title: "5. Your Privacy Rights",
                  content: [
                    "• Access, edit, or delete your data",
                    "• Opt-out of promotional emails",
                  ],
                  textTheme: textTheme,
                ),
                _buildSection(
                  title: "6. Children’s Privacy",
                  content: [
                    "Shopify does not knowingly collect data from children under 13.",
                  ],
                  textTheme: textTheme,
                ),
                _buildSection(
                  title: "7. Changes to This Policy",
                  content: [
                    "We may update this policy. Continued use of the app means acceptance of changes.",
                  ],
                  textTheme: textTheme,
                ),
                _buildSection(
                  title: "8. Contact Us",
                  content: [
                    "Email: support@yourdomain.com",
                    "Phone: +1-234-567-890",
                  ],
                  textTheme: textTheme,
                ),
                const SizedBox(height: 32),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<String> content,
    required TextTheme textTheme,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...content.map(
            (line) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(line, style: textTheme.bodyMedium),
            ),
          ),
        ],
      ),
    );
  }
}

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            title: Text("Terms of Service"),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 2,
            shadowColor: Colors.black.withAlpha(10),
            surfaceTintColor: Colors.transparent,
            pinned: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Text(
                  "Effective Date: July 25, 2025",
                  style: textTheme.labelMedium?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 16),
                Text(
                  "Welcome to Shopify",
                  style: textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  "These Terms of Service govern your use of our mobile app and services. Please read them carefully.",
                  style: textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                _buildSection(
                  title: "1. Use of the App",
                  content: [
                    "• You must be at least 13 years old.",
                    "• Provide accurate and complete registration information.",
                    "• Keep your login credentials secure.",
                  ],
                  textTheme: textTheme,
                ),
                _buildSection(
                  title: "2. Orders and Payments",
                  content: [
                    "• Orders are subject to availability and price confirmation.",
                    "• Payments are handled securely by third-party providers.",
                    "• We may cancel suspicious or invalid orders.",
                  ],
                  textTheme: textTheme,
                ),
                _buildSection(
                  title: "3. Shipping and Delivery",
                  content: [
                    "• Delivery times are estimated.",
                    "• We are not liable for third-party shipping delays.",
                  ],
                  textTheme: textTheme,
                ),
                _buildSection(
                  title: "4. Returns and Refunds",
                  content: [
                    "• You can request returns within [X] days.",
                    "• Products must be unused and returned in original condition.",
                  ],
                  textTheme: textTheme,
                ),
                _buildSection(
                  title: "5. User Conduct",
                  content: [
                    "• Do not use the app for illegal purposes.",
                    "• Do not upload harmful or malicious content.",
                    "• Do not attempt to hack or disrupt the service.",
                  ],
                  textTheme: textTheme,
                ),
                _buildSection(
                  title: "6. Intellectual Property",
                  content: [
                    "• All app content is owned by Shopify or its licensors.",
                    "• You may not copy or reuse any materials without permission.",
                  ],
                  textTheme: textTheme,
                ),
                _buildSection(
                  title: "7. Limitation of Liability",
                  content: [
                    "• We are not responsible for indirect damages or data loss.",
                    "• Use of the app is at your own risk.",
                  ],
                  textTheme: textTheme,
                ),
                _buildSection(
                  title: "8. Changes to Terms",
                  content: [
                    "• We may update these Terms at any time.",
                    "• Continued use of the app confirms your acceptance of changes.",
                  ],
                  textTheme: textTheme,
                ),
                _buildSection(
                  title: "9. Contact Us",
                  content: [
                    "Email: support@yourdomain.com",
                    "Phone: +1-234-567-890",
                  ],
                  textTheme: textTheme,
                ),
                const SizedBox(height: 32),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<String> content,
    required TextTheme textTheme,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...content.map(
            (line) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(line, style: textTheme.bodyMedium),
            ),
          ),
        ],
      ),
    );
  }
}

class SendFeedbackScreen extends StatefulWidget {
  const SendFeedbackScreen({super.key});

  @override
  State<SendFeedbackScreen> createState() => _SendFeedbackScreenState();
}

class _SendFeedbackScreenState extends State<SendFeedbackScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  bool _isSubmitting = false;

  void _submitFeedback() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSubmitting = true);
      Future.delayed(const Duration(seconds: 2), () {
        setState(() => _isSubmitting = false);
        if (mounted) {
          showSuccessToast(
              context: context, message: 'Thank you for your feedback!');
        }
        _formKey.currentState?.reset();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            pinned: true,
            title: const Text("Send Feedback"),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "We'd love to hear your thoughts, suggestions, or report any issues.",
                      style: textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter your name'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _messageController,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        labelText: 'Message',
                        border: OutlineInputBorder(),
                        alignLabelWithHint: true,
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter a message'
                          : null,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isSubmitting ? null : _submitFeedback,
                        child: _isSubmitting
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text('Submit'),
                      ),
                    ),
                    const SizedBox(height: 24),
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
