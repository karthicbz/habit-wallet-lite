import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_wallet_lite/data/models/secure_auth_model.dart';
import 'package:habit_wallet_lite/data/models/settings_model.dart';
import 'package:habit_wallet_lite/data/providers/secure_auth_provider.dart';
import 'package:habit_wallet_lite/data/providers/settings_provider.dart';
import 'package:habit_wallet_lite/views/pages/navigation_page.dart';
import 'package:habit_wallet_lite/views/pages/signup_page.dart';
import 'package:habit_wallet_lite/views/widgets/consumer_segmented_button.dart';
import 'package:habit_wallet_lite/views/widgets/custom_elevated_button.dart';
import 'package:habit_wallet_lite/views/widgets/custom_text_button.dart';
import 'package:habit_wallet_lite/views/widgets/show_scaffold_message.dart';

import '../../l10n/app_localizations.dart';
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
            padding: EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 35,
                      child: Icon(Icons.payments, size: 36),
                    ),
                    ConsumerSegmentedButton(),
                  ],
                ),
                SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.signInText,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    Text(
                      AppLocalizations.of(context)!.appMessage,
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
                      label: AppLocalizations.of(context)!.emailText,
                      textInputType: TextInputType.emailAddress,
                      isPassword: false,
                    ),
                    CustomTextField(
                      textEditingController: pinController,
                      label:
                          "4 ${AppLocalizations.of(context)!.fourDigitPinText}",
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
                        Text(
                          AppLocalizations.of(context)!.rememberMeText,
                          style: Theme.of(context).textTheme.bodyMedium,
                          overflow: TextOverflow.ellipsis,
                        ),

                        Spacer(),
                        // TextButton(
                        //   onPressed: () {},
                        //   child: SizedBox(
                        //     width: 100,
                        //     child: Text(
                        //       AppLocalizations.of(context)!.forgotPinText,
                        //       style: Theme.of(context).textTheme.bodyMedium,
                        //       overflow: TextOverflow.ellipsis,
                        //     ),
                        //   ),
                        // ),
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
                        SecureAuthModel secureAuthModel = ref.watch(
                          secureAuthProvider,
                        );
                        return (secureAuthModel.isLoading ?? false)
                            ? LinearProgressIndicator()
                            : CustomElevatedButton(
                                buttonText: AppLocalizations.of(
                                  context,
                                )!.loginText,
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
                                          builder: (context) =>
                                              NavigationPage(),
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

                SizedBox(height: 50),
                Column(
                  children: [
                    Text(AppLocalizations.of(context)!.newUserText),
                    CustomTextButton(
                      buttonText: AppLocalizations.of(
                        context,
                      )!.createAccountText,
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
