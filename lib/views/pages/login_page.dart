import 'package:flutter/material.dart';
import 'package:habit_wallet_lite/data/constants/strings.dart';
import 'package:habit_wallet_lite/views/pages/navigation_page.dart';
import 'package:habit_wallet_lite/views/pages/signup_page.dart';
import 'package:habit_wallet_lite/views/widgets/custom_text_button.dart';

import '../widgets/custom_textfield.dart';

class LoginPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController pinController = TextEditingController();

  LoginPage({super.key});

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
                        Checkbox(value: false, onChanged: (_) {}),
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
                ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NavigationPage()),
                  ),
                  style: ButtonStyle(
                    elevation: WidgetStatePropertyAll(0),
                    backgroundColor: WidgetStatePropertyAll(
                      Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      loginText,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
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
