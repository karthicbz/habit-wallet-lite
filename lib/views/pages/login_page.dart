import 'package:flutter/material.dart';
import 'package:habit_wallet_lite/data/constants/strings.dart';

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
                  children: [
                    Icon(Icons.payments),
                    Spacer(),
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
                Column(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    LoginTextField(
                      textEditingController: emailController,
                      label: emailText,
                      textInputType: TextInputType.emailAddress,
                      isPassword: false,
                    ),
                    LoginTextField(
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
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    elevation: WidgetStatePropertyAll(0),
                    backgroundColor: WidgetStatePropertyAll(
                      Theme.of(context).primaryColor,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      loginText,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 0,
                  child: Row(
                    children: [
                      Icon(Icons.sync),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          syncMessage,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text(newUserText),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        createAccountText,
                        style: Theme.of(context).textTheme.titleMedium,
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

class LoginTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String label;
  final TextInputType? textInputType;
  final bool isPassword;

  const LoginTextField({
    super.key,
    required this.textEditingController,
    required this.label,
    required this.isPassword,
    this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      keyboardType: textInputType ?? TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }
}
