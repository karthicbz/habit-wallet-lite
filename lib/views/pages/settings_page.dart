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
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      appearanceText.toUpperCase(),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    SettingsList(
                      listTitle: darkModeText,
                      listSubtitle: darkModeSubtitleText,
                      listIcon: Icons.dark_mode,
                      isSwitch: true,
                    ),
                  ],
                ),
                Divider(color: Colors.grey[200]),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      languageTitleText.toUpperCase(),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    SettingsList(
                      listTitle: languageText,
                      listSubtitle: "",
                      listIcon: Icons.translate,
                    ),
                  ],
                ),
                Divider(color: Colors.grey[200]),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      dataSyncDisplayText.toUpperCase(),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    SettingsList(
                      listTitle: backgroundSyncTitleText,
                      listSubtitle: backgroundSyncSubtitleText,
                      listIcon: Icons.task,
                      isSwitch: true,
                    ),
                    SettingsList(
                      listTitle: syncTitle,
                      listSubtitle: "Last Synced 5m ago",
                      listIcon: Icons.sync,
                      isButton: true,
                    ),
                  ],
                ),
                Divider(color: Colors.grey[200]),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      notificationTitleText.toUpperCase(),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    SettingsList(
                      listTitle: dailyRemainderTitleText,
                      listSubtitle: dailyRemainderSubtitleText,
                      listIcon: Icons.notifications,
                      isSwitch: true,
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                ElevatedButton(
                    onPressed: (){}, style: ButtonStyle(
                  elevation: WidgetStatePropertyAll(0),
                  backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.inversePrimary),
                  padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 16))
                ), child: Text(logoutText, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SettingsList extends StatelessWidget {
  final String listTitle;
  final String listSubtitle;
  final IconData listIcon;
  final bool? isSwitch;
  final bool? isButton;

  const SettingsList({
    super.key,
    required this.listTitle,
    required this.listSubtitle,
    required this.listIcon,
    this.isSwitch,
    this.isButton,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(listIcon),
      title: Text(listTitle),
      subtitle: Text(listSubtitle),
      trailing: (isSwitch ?? false)
          ? Switch(value: false, onChanged: (_) {})
          : (isButton ?? false)
          ? OutlinedButton(onPressed: () {}, child: Text("Sync"))
          : Icon(Icons.arrow_forward_ios, size: 16),
    );
  }
}
