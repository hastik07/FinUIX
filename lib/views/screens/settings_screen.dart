import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';
import '../../providers/user_provider.dart';
import '../../utils/theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  void _showEditNameDialog(BuildContext context, UserProvider userProvider) {
    final TextEditingController controller =
        TextEditingController(text: userProvider.userName);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).dialogBackgroundColor,
        title: Text('Edit Name',
            style: TextStyle(
                color: Theme.of(context).textTheme.titleLarge?.color)),
        content: TextField(
          controller: controller,
          style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
          decoration: InputDecoration(
            hintText: 'Enter your name',
            hintStyle: TextStyle(color: Theme.of(context).hintColor),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.3)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.primary),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel',
                style: TextStyle(
                    color: Theme.of(context).textTheme.labelLarge?.color)),
          ),
          TextButton(
            onPressed: () {
              userProvider.updateUserName(controller.text);
              Navigator.pop(context);
            },
            child: Text('Save',
                style: TextStyle(
                    color: Theme.of(context).textTheme.labelLarge?.color)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Settings',
                style: TextStyle(
                  color: Theme.of(context).textTheme.headlineMedium?.color ??
                      Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Consumer2<UserProvider, ThemeProvider>(
                builder: (context, userProvider, themeProvider, child) {
                  return _buildProfileSection(context, userProvider);
                },
              ),
              const SizedBox(height: 32),
              _buildSettingsGroup(context, 'Account', [
                _buildSettingItem(
                    context, Icons.person_outline, 'Personal Information'),
                _buildSettingItem(context, Icons.lock_outline, 'Security'),
                _buildSettingItem(context, Icons.payment, 'Payment Methods'),
              ]),
              const SizedBox(height: 24),
              Consumer<ThemeProvider>(
                builder: (context, themeProvider, child) {
                  return _buildSettingsGroup(context, 'Preferences', [
                    _buildSettingItem(
                        context, Icons.notifications_none, 'Notifications'),
                    _buildSettingItem(context, Icons.language, 'Language'),
                    ListTile(
                      leading: Icon(
                        themeProvider.isDarkMode
                            ? Icons.dark_mode
                            : Icons.light_mode,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      title: Text(
                        themeProvider.isDarkMode ? 'Dark Mode' : 'Light Mode',
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.titleMedium?.color),
                      ),
                      trailing: Switch(
                        value: themeProvider.isDarkMode,
                        onChanged: (_) => themeProvider.toggleTheme(),
                        activeColor: Theme.of(context).colorScheme.primary,
                        activeTrackColor: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.3),
                        inactiveThumbColor:
                            Theme.of(context).colorScheme.onSurface,
                        inactiveTrackColor: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.3),
                      ),
                    ),
                  ]);
                },
              ),
              const SizedBox(height: 24),
              _buildSettingsGroup(context, 'Support', [
                _buildSettingItem(context, Icons.help_outline, 'Help Center'),
                _buildSettingItem(
                    context, Icons.policy_outlined, 'Privacy Policy'),
                _buildSettingItem(
                    context, Icons.description_outlined, 'Terms of Service'),
              ]),
              const SizedBox(height: 24),
              _buildLogoutButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context, UserProvider userProvider) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppTheme.cardGradient,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person_outline,
              color: Colors.white,
              size: 40,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userProvider.userName,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  userProvider.userType,
                  style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.7),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => _showEditNameDialog(context, userProvider),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.edit,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsGroup(
      BuildContext context, String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color:
                Theme.of(context).textTheme.titleMedium?.color ?? Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: items,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingItem(BuildContext context, IconData icon, String title) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1,
          ),
        ),
      ),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).iconTheme.color),
        title: Text(
          title,
          style:
              TextStyle(color: Theme.of(context).textTheme.titleMedium?.color),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: Theme.of(context).iconTheme.color,
        ),
        onTap: () {},
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: TextButton.icon(
        onPressed: () {},
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor:
              Theme.of(context).colorScheme.surface.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: const Icon(
          Icons.logout,
          color: Colors.red,
        ),
        label: const Text(
          'Log Out',
          style: TextStyle(
            color: Colors.red,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
