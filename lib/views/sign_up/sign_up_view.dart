import 'package:flutter/material.dart';
import 'package:smart_school_bus/enums/user_type.dart';
import 'package:smart_school_bus/extensions/string_extensions.dart';
import 'package:smart_school_bus/pages/ssb_page.dart';
import 'package:smart_school_bus/views/sign_up/sign_up_view_model.dart';
import 'package:smart_school_bus/widgets/loader_button.dart';
import 'package:stacked/stacked.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SignUpViewModel(),
      builder: (context, model, ch) {
        return SSBPage(
          body: SingleChildScrollView(
            child: Form(
              key: model.signupFormKey,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: height),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: height * 0.15,
                        ),
                        Text(
                          'Create Account',
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        const SizedBox(
                          height: 48.0,
                        ),
                        TextFormField(
                          key: const ValueKey('name'),
                          decoration: const InputDecoration(
                            hintText: 'Name',
                          ),
                          onSaved: (value) {
                            model.name = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty || !model.isNameValid(value)) {
                              return 'Name must have a first_name and last_name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 28.0,
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
                            if (value!.isEmpty ||
                                !model.isValidEmailFn(value)) {
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
                          height: 28.0,
                        ),
                        FormField(
                          builder: (FormFieldState<UserType> state) {
                            return Column(
                              children: [
                                ButtonBar(
                                  alignment: MainAxisAlignment.center,
                                  children: UserType.values
                                      .map(
                                        (type) => Row(
                                          children: [
                                            Radio(
                                                value: type,
                                                groupValue: model.userType,
                                                onChanged: (value) {
                                                  model.setUserType(value);
                                                  state.didChange(value);
                                                }),
                                            Text(
                                              type.toShortString().capitalize(),
                                            ),
                                          ],
                                        ),
                                      )
                                      .toList(),
                                ),
                                if (state.hasError)
                                  Text(
                                    state.errorText!,
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.error,
                                    ),
                                  )
                              ],
                            );
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Usertype is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 36.0,
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: LoaderButton(
                            loading: model.isSigningUp,
                            onPressed: model.signup,
                            text: 'Sign Up',
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Already have an account?'),
                            TextButton(
                              onPressed: model.gotoLoginView,
                              child: const Text('Login'),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
