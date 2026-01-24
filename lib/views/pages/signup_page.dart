import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_wallet_lite/data/constants/app_constants.dart';
import 'package:habit_wallet_lite/data/constants/strings.dart';
import 'package:habit_wallet_lite/data/models/secure_auth_model.dart';
import 'package:habit_wallet_lite/data/providers/secure_auth_provider.dart';
import 'package:habit_wallet_lite/views/widgets/custom_elevated_button.dart';
import 'package:habit_wallet_lite/views/widgets/custom_text_button.dart';
import 'package:habit_wallet_lite/views/widgets/custom_textfield.dart';
import 'package:habit_wallet_lite/views/widgets/show_scaffold_message.dart';

class SignupPage extends ConsumerWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  final TextEditingController pinConfirmController = TextEditingController();

  SignupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SecureAuthNotifier secureAuthNotifier = ref.read(
      secureAuthProvider.notifier,
    );

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 16.0,
              children: [
                Text(
                  createAccountText,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Text(signupAppMessageText),
                CustomTextField(
                  textEditingController: emailController,
                  label: emailText,
                  isPassword: false,
                ),
                Row(
                  spacing: 8.0,
                  children: [
                    Expanded(
                      child: CustomTextField(
                        textEditingController: pinController,
                        label: "4 $fourDigitPinText",
                        isPassword: true,
                      ),
                    ),
                    Expanded(
                      child: CustomTextField(
                        textEditingController: pinConfirmController,
                        label: confirmPinText,
                        isPassword: true,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 300),
                Consumer(
                  builder:
                      (BuildContext context, WidgetRef ref, Widget? child) {
                        SecureAuthModel secureAuthModel = ref.watch(
                          secureAuthProvider,
                        );
                        return (secureAuthModel.isLoading ?? false)
                            ? LinearProgressIndicator()
                            : CustomElevatedButton(
                                buttonText: signupText,
                                buttonAction: () async {
                                  if (pinController.text !=
                                      pinConfirmController.text) {
                                    showScaffoldMessage(
                                      "PIN doesn't match",
                                      context,
                                    );
                                  } else if (pinController.text.length != 4 ||
                                      pinConfirmController.text.length != 4) {
                                    showScaffoldMessage(
                                      "PIN must be 4 digit",
                                      context,
                                    );
                                  } else if (!emailRegex.hasMatch(
                                    emailController.text,
                                  )) {
                                    showScaffoldMessage(
                                      "Email id is not valid",
                                      context,
                                    );
                                  } else {
                                    await secureAuthNotifier.saveCredentials(
                                      emailController.text,
                                      pinController.text,
                                    );

                                    if (context.mounted) {
                                      showScaffoldMessage(
                                        "Sign Up Success!",
                                        context,
                                      );
                                      Navigator.pop(context);
                                    }
                                  }
                                },
                              );
                      },
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Text(
                        alreadyAccountText,
                        textAlign: TextAlign.right,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    CustomTextButton(
                      buttonText: loginText,
                      buttonAction: () => Navigator.pop(context),
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
