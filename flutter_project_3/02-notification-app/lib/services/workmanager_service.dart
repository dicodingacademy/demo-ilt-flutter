import 'dart:math';

import 'package:notification_app/model/user.dart';
import 'package:notification_app/services/http_service.dart';
import 'package:notification_app/services/local_notification_service.dart';
import 'package:workmanager/workmanager.dart';

final uniqueName = "com.dicoding.notificationApp";
final taskName = "notificationTask";

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final httpService = HttpService();
    final localNotificationService = LocalNotificationService(httpService);
    await localNotificationService.init();

    if (task == taskName) {
      // This is where you can fetch data from the API and show a notification
      // For example, let's say you want to fetch a random post from JSONPlaceholder
      // and show a notification with the title and body of that post.
      // You can replace this with your own API call
      // and notification logic.
      int randomNumber = Random().nextInt(100);
      final result = await httpService.getDataFromUrl(
          "https://jsonplaceholder.typicode.com/posts/$randomNumber");
      final user = User.fromJson(result);

      localNotificationService.showNotification(
          id: randomNumber,
          title: user.title ?? "Empty title",
          body: user.body ?? "Empty body",
          payload: user.toJson());
    }

    return Future.value(true);
  });
}

class WorkmanagerService {
  final Workmanager _workmanager;

  WorkmanagerService([Workmanager? workmanager])
      : _workmanager = workmanager ??= Workmanager();

  Future<void> init() async {
    await _workmanager.initialize(callbackDispatcher, isInDebugMode: true);
  }

  Future<void> runPeriodicTask() async {
    // this task will run every 24 hours, starting on 11:00 AM
    await _workmanager.registerPeriodicTask(
      uniqueName,
      taskName,
      // frequency: const Duration(hours: 24),
      // initialDelay: calculateInitialDelay(),
      frequency: const Duration(minutes: 15),
      initialDelay: const Duration(seconds: 5),
      inputData: {
        "data": "This is a valid payload from periodic task workmanager",
      },
    );
  }

  Duration calculateInitialDelay() {
    final now = DateTime.now();
    final elevenAM = DateTime(now.year, now.month, now.day, 11, 0, 0);

    if (now.isAfter(elevenAM)) {
      // If it's after 11 AM today, schedule for 11 AM tomorrow
      final tomorrow = now.add(const Duration(days: 1));
      final elevenAMTomorrow =
          DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 11, 0, 0);
      return elevenAMTomorrow.difference(now);
    } else {
      // If it's before 11 AM today, schedule for 11 AM today
      return elevenAM.difference(now);
    }
  }

  Future<void> cancelAllTask() async {
    await _workmanager.cancelAll();
  }
}
