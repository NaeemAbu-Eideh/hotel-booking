import 'package:flutter/material.dart';
import 'package:hotel1/main.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'second_screen.dart';


int ID = 1;
class NotificationService{

  static Future<void> initialNotification() async{
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelGroupKey: "high_importance_channel",
          channelKey: "high_importance_channel",
          channelName: "Basic channel",
          channelDescription: "Notification channel for basic testes",
          defaultColor: Colors.blue,
          ledColor: Colors.white,
          importance: NotificationImportance.Max,
          channelShowBadge: true,
          onlyAlertOnce: true,
          playSound: true,
          criticalAlerts: true

        ),
      ],
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: "high_importance_channel_group",
            channelGroupName: "group1",
        ),
      ],
      debug: true,
    );
    await AwesomeNotifications().isNotificationAllowed().then((value) async{
      if(!value){
        await AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod
    );
  }
  static Future<void> onActionReceivedMethod(ReceivedAction receivedAction)async{
    debugPrint("onActionReceivedMethod");
    final payload = receivedAction.payload??{};
    if(payload['navigate'] == "true"){
      MyApp.navigatorKey.currentState?.push(
        MaterialPageRoute(
            builder: (_)=>const SecondScreen(),
        ),
      );
    }
  }
  static Future<void> onNotificationDisplayedMethod(ReceivedNotification receivedNotification)async{
    debugPrint("onNotificationDisplayedMethod");
  }
  static Future<void> onNotificationCreatedMethod(ReceivedNotification receivedNotification)async{
    debugPrint("onNotificationCreatedMethod");
  }
  static Future<void> onDismissActionReceivedMethod(ReceivedAction receivedAction)async{
    debugPrint("onDismissActionReceivedMethod");

  }
  static Future<void> showNotification({
    int? id,
    required final String title,
    required final String body,
    final String? summary,
    final Map<String, String>?payload,
    final ActionType actionType = ActionType.Default,
    final NotificationLayout notificationLayout = NotificationLayout.Default,
    final bool scheduled = false,
    final int? interval,
    final List<NotificationActionButton>? actionButtons,
    final String? bigPicture,
    final NotificationCategory? category,

})async{
    assert(!scheduled || (scheduled && interval != null));
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: ID,
          channelKey: "high_importance_channel",
          title: title,
          body: body,
          actionType: actionType,
          notificationLayout: notificationLayout,
          summary: summary,
          category: category,
          payload: payload,
          bigPicture: bigPicture,
        ),
        actionButtons: actionButtons,
      schedule: scheduled ? NotificationInterval(
        interval: interval,
        timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
        preciseAlarm: true,
      ): null
    );
    ID++;
  }


}