import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_wallet_lite/data/constants/strings.dart';
import 'package:habit_wallet_lite/data/models/settings_model.dart';
import 'package:habit_wallet_lite/data/models/sync_model.dart';
import 'package:habit_wallet_lite/data/providers/settings_provider.dart';
import 'package:habit_wallet_lite/data/providers/sync_provider.dart';
import 'package:habit_wallet_lite/views/pages/login_page.dart';
import 'package:habit_wallet_lite/views/widgets/custom_elevated_button.dart';
import 'package:habit_wallet_lite/views/widgets/show_scaffold_message.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SettingsModel settingsModel = ref.watch(settingsProvider);
    SettingsNotifier settingsNotifier = ref.read(settingsProvider.notifier);

    SyncModel syncModel = ref.watch(syncProvider);

    SyncNotifier syncNotifier = ref.read(syncProvider.notifier);

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   title: Text(settingsTitleText),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Settings",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Column(
                  spacing: 8,
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
                      switchValue: settingsModel.darkMode,
                      switchFunc: settingsNotifier.updateDarkMode,
                    ),
                  ],
                ),
                Divider(color: Theme.of(context).dividerColor),
                Column(
                  spacing: 8,
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
                Divider(color: Theme.of(context).dividerColor),
                Column(
                  spacing: 8,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      dataSyncDisplayText.toUpperCase(),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    // SettingsList(
                    //   listTitle: backgroundSyncTitleText,
                    //   listSubtitle: backgroundSyncSubtitleText,
                    //   listIcon: Icons.task,
                    //   isSwitch: true,
                    // ),
                    SettingsList(
                      listTitle: syncTitle,
                      listSubtitle:
                          "Last Synced ${DateTime.now().difference(syncModel.lastSynced).inMinutes}m ago",
                      listIcon: Icons.sync,
                      isButton: true,
                      buttonFunc: () async {
                        await syncNotifier.syncTransaction();
                        if(context.mounted) {
                          showScaffoldMessage("Transactions synced successfully!", context);
                        }
                      },
                      isLoading: syncModel.isSyncing,
                    ),
                  ],
                ),
                Divider(color: Theme.of(context).dividerColor),
                Column(
                  spacing: 8,
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
                      switchValue: settingsModel.remainder,
                      switchFunc: settingsNotifier.updateRemainder,
                    ),
                  ],
                ),
                SizedBox(height: 30),

                CustomElevatedButton(
                  buttonText: logoutText,
                  buttonAction: () {
                    settingsNotifier.updateAutoLogin();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                ),
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
  final bool? switchValue;
  final Function? switchFunc;
  final Function? buttonFunc;
  final bool? isLoading;

  const SettingsList({
    super.key,
    required this.listTitle,
    required this.listSubtitle,
    required this.listIcon,
    this.isSwitch,
    this.isButton,
    this.switchValue,
    this.switchFunc,
    this.buttonFunc,
    this.isLoading,
  });

  //get the switch value and switch and update the state
  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        tileColor: Theme.of(context).listTileTheme.tileColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(14),
        ),
        leading: Icon(listIcon),
        title: Text(listTitle),
        subtitle: Text(listSubtitle),
        trailing: (isLoading ?? false)
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(),
              )
            : (isSwitch ?? false)
            ? Switch(
                value: switchValue ?? false,
                onChanged: (_) => switchFunc!(),
              )
            : (isButton ?? false)
            ? OutlinedButton(
                onPressed: () => buttonFunc!(),
                child: Text("Sync"),
              )
            : Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}
