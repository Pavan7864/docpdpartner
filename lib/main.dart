import 'dart:async';

import 'package:docpdpartner/custom_ui/imageView/FullImageView.dart';
import 'package:docpdpartner/utils/FirebaseNotifications.dart';
import 'package:docpdpartner/utils/MyAppPrefrences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:docpdpartner/page/appointment_page.dart';
import 'package:docpdpartner/page/edit_profile.dart';
import 'package:docpdpartner/page/history_container.dart';
import 'package:docpdpartner/page/my_availability.dart';
import 'package:docpdpartner/page/namaste_page.dart';
import 'package:docpdpartner/page/otp_page.dart';
import 'package:docpdpartner/page/home_page.dart';
import 'package:docpdpartner/page/patient_detail.dart';
import 'package:docpdpartner/page/patient_other_details.dart';
import 'package:docpdpartner/page/profile_menu.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';



final BehaviorSubject<String> selectNotificationSubject = BehaviorSubject<String>();

NotificationAppLaunchDetails notificationAppLaunchDetails;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );


    notificationAppLaunchDetails = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    var initializationSettingsAndroid = AndroidInitializationSettings('ic_launcher');
    // Note: permissions aren't requested here just to demonstrate that can be done later using the `requestPermissions()` method
    // of the `IOSFlutterLocalNotificationsPlugin` class
    var initializationSettingsIOS = IOSInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);


  }
  runApp(
    ThemeSwitcherWidget(
      initialTheme: themeData,
      child: MyApp(),
    ),
  );
}


Future onDidReceiveLocalNotification(
    int id, String title, String body, String payload) async {
  // display a dialog with the notification details, tap ok to go to another page
  selectNotificationSubject.add(payload);
  showDialog(
    context: mContext,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(body),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          child: Text('Ok'),
          onPressed: () async {
            Navigator.of(context, rootNavigator: true).pop();

            await Navigator.pushNamed(context, '/DetailsBlog',arguments: {"id" :payload});

          },
        )
      ],
    ),
  );
}
/*
void _configureSelectNotificationSubject() {
  selectNotificationSubject.stream.listen((String payload) async {
    await Navigator.push(
      mContext,
      MaterialPageRoute(builder: (context) => DetailsBlog()),
    );
    await Navigator.pushNamed(mContext, '/DetailsBlog',arguments: {"id" :payload});

  });
}*/

var mContext;
Future selectNotification(String payload) async {
  selectNotificationSubject.add(payload);
  /* await Navigator.push(
    mContext,
    MaterialPageRoute(builder: (context) => DetailsBlog()),
  );
  await Navigator.pushNamed(mContext, '/DetailsBlog',arguments: {"id" :payload});
*/

}


var themeData = ThemeData(
    fontFamily: 'Roboto',
    primaryColor: Colors.black,
    brightness: Brightness.light,
    backgroundColor: Colors.white,
    accentColor: Color(0xff666666),
    dividerColor: Color(0xff00ae99),
    hintColor: Color(0xff797979),

);


var themeDataDark = ThemeData(
  fontFamily: 'Roboto',
  primaryColor: Colors.black,
  brightness: Brightness.light,
  backgroundColor: Colors.white,
  accentColor: Color(0xff666666),
  dividerColor: Color(0xff00ae99),
  hintColor: Color(0xff797979),

);


class ThemeSwitcher extends InheritedWidget {
  final _ThemeSwitcherWidgetState data;

  const ThemeSwitcher({
    Key key,
    @required this.data,
    @required Widget child,
  })  : assert(child != null),
        super(key: key, child: child);

  static _ThemeSwitcherWidgetState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(ThemeSwitcher)
    as ThemeSwitcher)
        .data;
  }

  @override
  bool updateShouldNotify(ThemeSwitcher old) {
    return this != old;
  }
}

class ThemeSwitcherWidget extends StatefulWidget {
  final ThemeData initialTheme;
  final Widget child;

  ThemeSwitcherWidget({Key key, this.initialTheme, this.child})
      : assert(initialTheme != null),
        assert(child != null),
        super(key: key);

  @override
  _ThemeSwitcherWidgetState createState() => _ThemeSwitcherWidgetState();
}

class _ThemeSwitcherWidgetState extends State<ThemeSwitcherWidget> {
  ThemeData themeData;

  void switchTheme(ThemeData theme) {
    setState(() {
      themeData = theme;
    });
  }
  @override
  void initState() {
    super.initState();
    FirebaseNotifications().setUpFirebase();
  }

  @override
  Widget build(BuildContext context) {

    themeData = themeData ?? widget.initialTheme;
    return ThemeSwitcher(
      data: this,
      child: widget.child,
    );
  }
}

class MyApp extends StatelessWidget {



  Route onGenerateRoute(RouteSettings settings) {
    Route page;
    switch (settings.name) {
      case "/":
        page = CupertinoPageRoute(builder: (context) => Splash());
        break;
      case "/NamasteScreen":
        page = CupertinoPageRoute(builder: (context) => NamasteScreen());
        break;
      case "/OTPScreen":
        page = CupertinoPageRoute(builder: (context) => OTPScreen());
        break;
      case "/HomePage":
        page = CupertinoPageRoute(builder: (context) => HomePage());
        break;
      case "/ProfileMenu":
        page = CupertinoPageRoute(builder: (context) => ProfileMenu());
        break;
      case "/AppointmentScreen":
        page = CupertinoPageRoute(builder: (context) => AppointmentScreen());
        break;
      case "/PatientDetails":
        page = CupertinoPageRoute(builder: (context) => PatientDetails());
        break;
      case "/EditProfile":
        page = CupertinoPageRoute(builder: (context) => EditProfile());
        break;
      case "/HistoryContainer":
        page = CupertinoPageRoute(builder: (context) => HistoryContainer());
        break;
      case "/MyAvailability":
        page = CupertinoPageRoute(builder: (context) => MyAvailability());
        break;
      case "/PatientOtherDetails":
        page = CupertinoPageRoute(builder: (context) => PatientOtherDetails());
        break;
    }
    return page;
  }


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeSwitcher.of(context).themeData,
    //  routes: Routes.getAll(),
      onGenerateRoute: onGenerateRoute,
      initialRoute: "/",

    );
  }
}
class Splash extends StatefulWidget{

  @override
  MainSplash createState()=>MainSplash();
}
class MainSplash extends State<Splash>{



  @override
  void initState() {

    super.initState();
    _getHome();
  }

  _getHome() async {
    var user=await MyAppPrefrences.getLogin();
    new Timer(new Duration(seconds: 4), (){
      if(user==null){
        Navigator.pushReplacementNamed(mContext, "/NamasteScreen");
      }else{
        Navigator.pushReplacementNamed(mContext, "/HomePage");
      }

    });

  }






  @override
  Widget build(BuildContext context) {
    mContext=context;
    return Scaffold(
      body: SafeArea(child: Container(
        padding: const EdgeInsets.only(left: 30,right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FullImageView('assets/icon/logo.png',padding: const EdgeInsets.only(left: 50,right: 50),mergin: const EdgeInsets.only(bottom: 5),),
            FullImageView('assets/icon/loader.gif',padding: const EdgeInsets.only(left: 50,right: 50),),
          ],
        ),
      )),
    );
  }


}
