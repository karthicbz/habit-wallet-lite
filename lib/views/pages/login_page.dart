import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_wallet_lite/data/constants/strings.dart';
import 'package:habit_wallet_lite/data/models/settings_model.dart';
import 'package:habit_wallet_lite/data/providers/secure_auth_provider.dart';
import 'package:habit_wallet_lite/data/providers/settings_provider.dart';
import 'package:habit_wallet_lite/views/pages/navigation_page.dart';
import 'package:habit_wallet_lite/views/pages/signup_page.dart';
import 'package:habit_wallet_lite/views/widgets/custom_elevated_button.dart';
import 'package:habit_wallet_lite/views/widgets/custom_text_button.dart';
import 'package:habit_wallet_lite/views/widgets/show_scaffold_message.dart';

import '../widgets/custom_textfield.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.payments),

                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text("English"),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      signInText,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    Text(
                      appMessage,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextField(
                      textEditingController: emailController,
                      label: emailText,
                      textInputType: TextInputType.emailAddress,
                      isPassword: false,
                    ),
                    CustomTextField(
                      textEditingController: pinController,
                      label: "4 $fourDigitPinText",
                      isPassword: true,
                    ),
                    Row(
                      children: [
                        Consumer(
                          builder:
                              (
                                BuildContext context,
                                WidgetRef ref,
                                Widget? child,
                              ) {
                                SettingsModel settings = ref.watch(
                                  settingsProvider,
                                );
                                SettingsNotifier settingsNotifier = ref.read(
                                  settingsProvider.notifier,
                                );
                                return Checkbox(
                                  value: settings.autoLogin,
                                  onChanged: (_) =>
                                      settingsNotifier.updateAutoLogin(),
                                );
                              },
                        ),
                        Text(rememberMeText),
                        Spacer(),
                        TextButton(
                          onPressed: () {},
                          child: Text(forgotPinText),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Consumer(
                  builder:
                      (BuildContext context, WidgetRef ref, Widget? child) {
                        SecureAuthNotifier secureAuthNotifier = ref.read(
                          secureAuthProvider.notifier,
                        );
                        return CustomElevatedButton(
                          buttonText: loginText,
                          buttonAction: () async {
                            bool isValidUser = await secureAuthNotifier
                                .validateLogin(
                                  emailController.text,
                                  pinController.text,
                                );
                            if (context.mounted) {
                              if (isValidUser) {
                                emailController.clear();
                                pinController.clear();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NavigationPage(),
                                  ),
                                );
                              } else {
                                showScaffoldMessage(
                                  "Invalid Email/PIN",
                                  context,
                                );
                              }
                              ;
                            }
                          },
                        );
                      },
                ),
                SizedBox(height: 250),
                // Card(
                //   elevation: 0,
                //   child: Row(
                //     children: [
                //       Icon(Icons.sync),
                //       Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Text(
                //           syncMessage,
                //           style: Theme.of(context).textTheme.bodyMedium,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(height: 50),
                Column(
                  children: [
                    Text(newUserText),
                    CustomTextButton(
                      buttonText: createAccountText,
                      buttonAction: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupPage()),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
