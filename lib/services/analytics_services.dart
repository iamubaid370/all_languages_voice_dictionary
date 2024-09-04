import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService{

  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  FirebaseAnalyticsObserver getAnalyticsObserver()=>FirebaseAnalyticsObserver(analytics: analytics);

  Future<void> logEvent(
      String eventName,
      Map<String,Object> parameters,
      )async{
    await analytics.logEvent(name: eventName,parameters: parameters);

  }

}