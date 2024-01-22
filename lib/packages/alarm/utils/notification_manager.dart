import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:katkoty/packages/alarm/models/alarm_database_model.dart';
import 'package:katkoty/packages/alarm/models/alarm_repeate.dart';
import 'package:katkoty/db/database_service.dart';
import 'package:katkoty/packages/alarm/utils/alarm_audio_manager.dart';
import 'package:katkoty/packages/alarm/utils/alarms_manager.dart';
import 'package:vibration/vibration.dart';

import '../../../view/screens/notifications/notification_screen.dart';

const String ALARMS_NOTIFICATION_CHANNEL = "ALARMS_NOTIFICATION_CHANNEL";

bool isAppRunning = false;

setUpNotification() {
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelGroupKey: ALARMS_NOTIFICATION_CHANNEL,
        channelKey: ALARMS_NOTIFICATION_CHANNEL,
        channelName: ALARMS_NOTIFICATION_CHANNEL,
        channelDescription: ALARMS_NOTIFICATION_CHANNEL,
        playSound: false,
        enableVibration: true,
        criticalAlerts: true,
        importance: NotificationImportance.Max,
        defaultPrivacy: NotificationPrivacy.Public,
        defaultColor: const Color(0xFF9D50DD),
        ledColor: Colors.white,
      )
    ],
    channelGroups: [
      NotificationChannelGroup(
        channelGroupKey: ALARMS_NOTIFICATION_CHANNEL,
        channelGroupName: ALARMS_NOTIFICATION_CHANNEL,
      )
    ],
    debug: true,
  );
  AwesomeNotifications().setListeners(
    onActionReceivedMethod: onActionReceivedMethod,
  );
}

void fireAlarmNotification(Map<String, dynamic> alarmData) async {
  AlarmDatabaseModel alarmDb = AlarmDatabaseModel.fromJson(alarmData);
  AwesomeNotifications().cancelAll();
  playAudio(alarmDb);
  if (!isAppRunning) {
    Get.to(NotificationScreen());
  }

  AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: alarmDb.id!,
      channelKey: ALARMS_NOTIFICATION_CHANNEL,
      title: alarmDb.alarmData!.title ?? "",
      body: alarmDb.alarmData!.description ?? "",
      actionType: ActionType.Default,
      displayOnBackground: true,
      displayOnForeground: true,
      autoDismissible: false,
      wakeUpScreen: true,
      fullScreenIntent: true,
      criticalAlert: true,
      category: NotificationCategory.Alarm,
      locked: true,
      payload: {"alarm_data": jsonEncode(alarmDb.toJson())},
    ),
    actionButtons: [
      NotificationActionButton(
        key: "dismiss",
        label: "cancel".tr,
      ),
      if (alarmDb.alarmData!.snooze!)
        NotificationActionButton(
          key: "snooze",
          label: "snooze".tr,
        ),
    ],
  );
}

Future<void> onDismissActionReceivedMethod(
    ReceivedAction receivedAction) async {
  Future.delayed(const Duration(seconds: 2), () async {
    AwesomeNotifications().cancelAll();
    await alarmAudioPlayer.stop();
    var alarm = AlarmDatabaseModel.fromJson(
        jsonDecode(receivedAction.payload!["alarm_data"]!));
    print('an event = onDismissActionReceivedMethod');
    print('an event = ${receivedAction.buttonKeyPressed}');
    Vibration.cancel();
    if (receivedAction.buttonKeyPressed == "snooze") {
      alarm.alarmData!.snoozedAlarmId =
          alarm.alarmData!.snoozedAlarmId ?? alarm.id;
      alarm.alarmData!.repeatType = RepeatType.once.name;
      alarm.alarmData!.millisecondsSinceEpoch =
          alarm.alarmData!.millisecondsSinceEpoch! +
              const Duration(minutes: 5).inMilliseconds;
      AppDatabase appDatabase = await AppDatabase().initDb();
      alarm.id = null;
      await appDatabase.insert(alarm);
      await refreshAlarms();
    }

    MethodChannel _channel = const MethodChannel('restart_app');
    await _channel.invokeMethod("restart_app");
  });
}

Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
  Future.delayed(const Duration(seconds: 1), () async {
    AwesomeNotifications().cancelAll();
    await alarmAudioPlayer.stop();
    var alarm = AlarmDatabaseModel.fromJson(
        jsonDecode(receivedAction.payload!["alarm_data"]!));
    print('an event = onActionReceivedMethod');
    print('an event = ${receivedAction.buttonKeyPressed}');
    Vibration.cancel();
    if (receivedAction.buttonKeyPressed == "snooze") {
      alarm.alarmData!.snoozedAlarmId =
          alarm.alarmData!.snoozedAlarmId ?? alarm.id;
      alarm.alarmData!.repeatType = RepeatType.once.name;
      alarm.alarmData!.millisecondsSinceEpoch =
          alarm.alarmData!.millisecondsSinceEpoch! +
              const Duration(minutes: 5).inMilliseconds;
      AppDatabase appDatabase = await AppDatabase().initDb();
      alarm.id = null;
      await appDatabase.insert(alarm);
      await refreshAlarms();
    }

    MethodChannel _channel = const MethodChannel('restart_app');
    await _channel.invokeMethod("restart_app");
  });
}

