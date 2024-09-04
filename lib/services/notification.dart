import 'dart:ui';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {}

final localNotifications = FlutterLocalNotificationsPlugin();

class LocalNotification {
  Future<void> initializeLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    await localNotifications
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );

    DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
        onDidReceiveLocalNotification: onDidReceiveLocalNotification,
        notificationCategories: [
          const DarwinNotificationCategory(
            'demoCategory',
            actions: [],
            options: <DarwinNotificationCategoryOption>{
              DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
            },
          )
        ]);

    LinuxInitializationSettings initializationSettingsLinux =
    const LinuxInitializationSettings(
        defaultActionName: 'Open notification');

    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
        linux: initializationSettingsLinux);

    await localNotifications.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (notificationResponse) async {},
        onDidReceiveBackgroundNotificationResponse: notificationTapBackground);
  }

  // this function is applicable to iOS versions older than 10.
  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {}
}
// class LocalNotification{
//   static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   static Future init()async{
//     const AndroidInitializationSettings initializationSettingsAndroid =
//     AndroidInitializationSettings('app_icon');
//     final DarwinInitializationSettings initializationSettingsDarwin =
//     DarwinInitializationSettings(
//         onDidReceiveLocalNotification: (id, title, body, payload) => null,);
//     final LinuxInitializationSettings initializationSettingsLinux =
//     LinuxInitializationSettings(
//         defaultActionName: 'Open notification');
//     final InitializationSettings initializationSettings = InitializationSettings(
//         android: initializationSettingsAndroid,
//         iOS: initializationSettingsDarwin,
//         linux: initializationSettingsLinux);
//     _flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onDidReceiveNotificationResponse: (details) => null,);
//   }
// }

Future<void> showLocalNotificationPeriodically() async {
  final platformChannelSpecifics = await _notificationDetails();

  await localNotifications.periodicallyShow(
    1,
    'All languages Voice Dictionary',
    'Expand your dictionary with our voice dictionary.',
    RepeatInterval.daily,
    platformChannelSpecifics,
    payload: 'Test',
  );
}

Future<NotificationDetails> _notificationDetails() async {
  AndroidNotificationDetails androidPlatformChannelSpecifics =
  const AndroidNotificationDetails(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.high,
    playSound: true,
    groupKey: 'com.example.flutter_push_notifications',
    channelDescription: 'channel description',
    priority: Priority.max,
    icon: 'dictionary',
    ticker: 'ticker',
    channelShowBadge: true,
    colorized: true,
    color: Color(0xff0c8a7b),
  );

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      importance: Importance.high,
      enableLights: true,
      showBadge: true,
      playSound: true);

  await localNotifications
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  DarwinNotificationDetails iosNotificationDetails =
  const DarwinNotificationDetails(threadIdentifier: "thread1");

  final details = await localNotifications.getNotificationAppLaunchDetails();
  if (details != null && details.didNotificationLaunchApp) {}
  NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics, iOS: iosNotificationDetails);

  return platformChannelSpecifics;
}


