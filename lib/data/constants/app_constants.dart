enum AppLanguage { english, tamil }

const emailKey = "email_key";
const pinKey = "pin_key";

final emailRegex = RegExp(
  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
);
