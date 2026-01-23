import 'package:flutter/material.dart';
import 'package:habit_wallet_lite/data/constants/strings.dart';
import 'package:habit_wallet_lite/views/widgets/custom_elevated_button.dart';
import 'package:habit_wallet_lite/views/widgets/custom_text_button.dart';
import 'package:habit_wallet_lite/views/widgets/custom_textfield.dart';

class SignupPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController pinConfirmController = TextEditingController();

  SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
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
                CustomElevatedButton(buttonText: signupText),
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
                    CustomTextButton(buttonText: loginText, buttonAction: ()=>Navigator.pop(context))
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
