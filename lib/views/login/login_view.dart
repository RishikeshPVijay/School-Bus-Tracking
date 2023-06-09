import 'package:flutter/material.dart';
import 'package:smart_school_bus/pages/smb_page.dart';
import 'package:smart_school_bus/views/login/login_view_model.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, ch) {
        return SMBPage(
          body: Form(
            key: model.loginFormKey,
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const SizedBox(
                        height: 48.0,
                      ),
                      TextFormField(
                        key: const ValueKey('email'),
                        onSaved: (value) {
                          model.email = value!;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Email',
                        ),
                        validator: (value) {
                          if (value!.isEmpty || !model.isValidEmailFn(value)) {
                            return 'Email is not valid';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 28.0,
                      ),
                      TextFormField(
                        key: const ValueKey('password'),
                        onSaved: (value) {
                          model.password = value!;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Password',
                        ),
                        validator: (value) {
                          if (value!.isEmpty || value.length < 7) {
                            return 'Password must be 7 character long';
                          }
                          return null;
                        },
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 36.0,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: model.login,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Login'),
                              SizedBox(
                                width: 12.0,
                              ),
                              Icon(Icons.arrow_forward)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account?'),
                    TextButton(
                      onPressed: model.gotoSignUpView,
                      child: const Text('Sign Up'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
