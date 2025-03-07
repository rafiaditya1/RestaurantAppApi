import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api/data/provider/preferences_provider.dart';
import 'package:restaurant_api/data/provider/scheduling_provider.dart';
import 'package:restaurant_api/utils/custom_dialog.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key key}) : super(key: key);
  static const routeName = '/setting_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings Page'),
        ),
        body: _buildList(context));
  }

  _buildList(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, child) {
        return ListView(
          children: [
            Material(
              child: ListTile(
                title: const Text('Scheduling Restaurant'),
                trailing: Consumer<SchedulingProvider>(
                  builder: (context, scheduled, _) {
                    return Switch.adaptive(
                      value: provider.isDailyRestoActive,
                      onChanged: (value) async {
                        if (Platform.isIOS) {
                          customDialog(context);
                        } else {
                          scheduled.scheduledRestaurant(value);
                          provider.enableDailyResto(value);
                        }
                      },
                    );
                  },
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
