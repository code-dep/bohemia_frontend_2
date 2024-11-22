import 'package:bohemia/pages/register_page/register_page_model.dart';
import 'package:bohemia/widgets/button/custom_button.dart';
import 'package:bohemia/widgets/textfield/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  final RegisterPageModel _model = RegisterPageModel();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Create an account to continue",
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 32),
                Form(
                  key: _model.formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextfield(
                              controller: _model.nameController,
                              hintText: 'Name',
                              validator: _model.validateName,
                              obscureText: false,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CustomTextfield(
                              controller: _model.surnameController,
                              hintText: 'Surname',
                              validator: _model.validateSurname,
                              obscureText: false,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      CustomTextfield(
                        controller: _model.emailController,
                        hintText: 'Email',
                        validator: _model.validateEmail,
                        obscureText: false,
                      ),
                      const SizedBox(height: 16),
                      CustomTextfield(
                        controller: _model.usernameController,
                        hintText: 'Username',
                        validator: _model.validateUsername,
                        obscureText: false,
                      ),
                      const SizedBox(height: 16),
                      CustomTextfield(
                        controller: _model.instagramController,
                        hintText: 'Instagram (optional)',
                        obscureText: false,
                      ),
                      const SizedBox(height: 16),
                      Obx(() => CustomTextfield(
                            controller: _model.passwordController,
                            hintText: 'Password',
                            validator: _model.validatePassword,
                            obscureText: !_model.isPasswordVisible.value,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _model.isPasswordVisible.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: _model.togglePasswordVisibility,
                            ),
                          )),
                      const SizedBox(height: 16),
                      Obx(() => CustomTextfield(
                            controller: _model.confirmPasswordController,
                            hintText: 'Confirm Password',
                            validator: _model.validateConfirmPassword,
                            obscureText: !_model.isConfirmPasswordVisible.value,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _model.isConfirmPasswordVisible.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: _model.toggleConfirmPasswordVisibility,
                            ),
                          )),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomTextfield(
                        controller: _model.promoterCodeController,
                        hintText: 'Promoter Code (optional)',
                        obscureText: false,
                        suffixIcon: IconButton(
                          onPressed: _model.validatePromoterCode,
                          icon: const Icon(Icons.check),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              onPressed: _model.doRegister,
                              text: 'Register',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () => Get.back(),
                        child: const Text('Hai già un account? Accedi'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
