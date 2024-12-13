import 'package:bohemia/pages/profile_page/profile_page_model.dart';
import 'package:bohemia/widgets/bottom_sheets/promoter_codes_bottom_sheet.dart';
import 'package:bohemia/widgets/button/custom_button.dart';
import 'package:bohemia/widgets/textfield/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  final ProfilePageModel _model = ProfilePageModel();
  ProfilePage({super.key});

  void _showDeleteAccountDialog(BuildContext context) {
    final passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        title: const Text('Delete Account'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'This action cannot be undone. Please enter your password to confirm.',
            ),
            const SizedBox(height: 16),
            CustomTextfield(
              controller: passwordController,
              hintText: 'Password',
              obscureText: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _model.deleteAccount(passwordController.text);
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 200,
                          width: double.infinity,
                          color: Theme.of(context).primaryColor,
                        ),
                        Positioned(
                          bottom: 0,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.white,
                            child: Obx(() =>
                                _model.user.value?.avatar != null &&
                                        _model.user.value!.avatar.isNotEmpty
                                    ? ClipOval(
                                        child: Image.network(
                                          _model.user.value!.avatar,
                                          width: 110,
                                          height: 110,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Icon(Icons.person,
                                        size: 60, color: Colors.grey[400])),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Obx(() => Text(
                          '${_model.user.value?.name ?? ''} ${_model.user.value?.surname ?? ''}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    const SizedBox(height: 8),
                    Obx(() => Text(
                          '@${_model.user.value?.username ?? ''}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        )),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          _buildInfoTile(
                            icon: Icons.email,
                            title: 'Email',
                            value: _model.user.value?.email ?? '',
                          ),
                          if (_model.user.value?.instagram != null &&
                              _model.user.value!.instagram.isNotEmpty)
                            _buildInfoTile(
                              icon: Icons.camera_alt,
                              title: 'Instagram',
                              value: '@${_model.user.value?.instagram}',
                            ),
                          _buildInfoTile(
                            icon: Icons.verified_user,
                            title: 'Account Type',
                            value: _model.getAccountType(),
                          ),
                          if (_model.getAccountType() == "Administrator")
                            _buildInfoTile(
                              icon: Icons.code,
                              title: 'Promoter Codes',
                              value: 'Manage',
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) =>
                                      PromoterCodesBottomSheet(),
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          onPressed: _model.logout,
                          text: 'Logout',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          onPressed: () => _showDeleteAccountDialog(context),
                          text: 'Delete Account',
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String value,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Row(
          children: [
            Icon(icon, size: 24, color: Colors.grey[600]),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            if (onTap != null)
              Icon(
                Icons.chevron_right,
                color: Colors.grey[600],
              ),
          ],
        ),
      ),
    );
  }
}
