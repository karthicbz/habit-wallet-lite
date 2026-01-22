import 'package:flutter/material.dart';
import 'package:habit_wallet_lite/data/constants/strings.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(settingsTitleText),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  appearanceText.toUpperCase(),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SwitchList extends StatelessWidget {
  final String listTitle;
  final String listSubtitle;
  final IconData listIcon;

  const SwitchList({
    super.key,
    required this.listTitle,
    required this.listSubtitle,
    required this.listIcon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(listIcon),
      title: Text(listTitle),
      subtitle: Text(listSubtitle),
      trailing: Switch(value: false, onChanged: (_) {}),
    );
  }
}
