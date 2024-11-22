import 'package:bohemia/pages/login_page/login_page_model.dart';
import 'package:bohemia/pages/register_page/register_page.dart';
import 'package:bohemia/widgets/button/custom_button.dart';
import 'package:bohemia/widgets/textfield/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final LoginPageModel _model = LoginPageModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Accedi per continuare",
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 64),
                    Form(
                      key: _model.formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CustomTextfield(
                            controller: _model.usernameController,
                            obscureText: false,
                            hintText: 'Username',
                            validator: (p0) {
                              return _model.validateUsername(p0);
                            },
                          ),
                          const SizedBox(height: 16),
                          CustomTextfield(
                            controller: _model.passwordController,
                            obscureText: true,
                            hintText: 'Password',
                            validator: (p0) {
                              return _model.validatePassword(p0);
                            },
                          ),
                          const SizedBox(height: 4),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "Hai dimenticato la password?",
                            ),
                          ),
                          const SizedBox(height: 16),
                          const SizedBox(height: 16),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                onPressed: _model.doLogin,
                                text: 'Login',
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  Get.to(() => RegisterPage());
                                },
                                child: Text("Non hai un account? Registrati"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        )),
      ),
    );
  }
}
