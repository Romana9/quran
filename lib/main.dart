import 'package:adhan/adhan.dart';
import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:quran/generated/l10n.dart';
import 'core/Cache/local_network.dart';
import 'core/app_cubit/app_cubit.dart';
import 'core/constants.dart';
import 'core/location_helper.dart';
import 'screens/splash/splash.dart';

List currentList = [];
late PrayerTimes prayerTimes;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Alarm.init();
  await CacheNetwork.cacheInitilzation();
  currentList = await CacheNetwork.loadData();
  position = await LocationHelper.determinePosition();
  print("currentList is $currentList");

  lat = position!.latitude;
  lng = position!.longitude;
  final myCoordinates = Coordinates(lat!, lng!);
  final params = CalculationMethod.egyptian.getParameters();
  params.madhab = Madhab.shafi;
  prayerTimes = PrayerTimes.today(myCoordinates, params);
  print(
      "---Today's Prayer Times in Your Local Timezone(${prayerTimes.fajr.timeZoneName})---");
  print(DateFormat.jm().format(prayerTimes.fajr));
  print(DateFormat.jm().format(prayerTimes.sunrise));
  print(DateFormat.jm().format(prayerTimes.dhuhr));
  print(DateFormat.jm().format(prayerTimes.asr));
  print(DateFormat.jm().format(prayerTimes.maghrib));
  print(DateFormat.jm().format(prayerTimes.isha));

  Alarm.set(
    alarmSettings: AlarmSettings(
      id: 1,
      dateTime: prayerTimes.fajr,
      // DateTime(
      //   DateTime.now().year,
      //   DateTime.now().month,
      //   DateTime.now().day,
      //   DateTime.now().hour,
      //   DateTime.now().minute,
      //   DateTime.now().second + 10,
      // ),
      assetAudioPath: 'assets/pdf/fajr.mp3',
      loopAudio: false,
      vibrate: true,
      volume: 0.8,
      fadeDuration: 3.0,
      notificationTitle: 'الأذان',
      notificationBody: 'حان الأن موعد الأذان',
      enableNotificationOnKill: true,
    ),
  );
  Alarm.set(
    alarmSettings: AlarmSettings(
      id: 2,
      dateTime: prayerTimes.dhuhr,
      assetAudioPath: 'assets/pdf/adhan.mp3',
      loopAudio: false,
      vibrate: true,
      volume: 0.8,
      fadeDuration: 3.0,
      notificationTitle: 'الأذان',
      notificationBody: 'حان الأن موعد الأذان',
      enableNotificationOnKill: true,
    ),
  );
  Alarm.set(
    alarmSettings: AlarmSettings(
      id: 3,
      dateTime: prayerTimes.asr,
      assetAudioPath: 'assets/pdf/adhan.mp3',
      loopAudio: false,
      vibrate: true,
      volume: 0.8,
      fadeDuration: 3.0,
      notificationTitle: 'الأذان',
      notificationBody: 'حان الأن موعد الأذان',
      enableNotificationOnKill: true,
    ),
  );
  Alarm.set(
    alarmSettings: AlarmSettings(
      id: 4,
      dateTime: prayerTimes.maghrib,
      assetAudioPath: 'assets/pdf/adhan.mp3',
      loopAudio: false,
      vibrate: true,
      volume: 0.8,
      fadeDuration: 3.0,
      notificationTitle: 'الأذان',
      notificationBody: 'حان الأن موعد الأذان',
      enableNotificationOnKill: true,
    ),
  );
  Alarm.set(
    alarmSettings: AlarmSettings(
      id: 5,
      dateTime: prayerTimes.isha,
      assetAudioPath: 'assets/pdf/adhan.mp3',
      loopAudio: false,
      vibrate: true,
      volume: 0.8,
      fadeDuration: 3.0,
      notificationTitle: 'الأذان',
      notificationBody: 'حان الأن موعد الأذان',
      enableNotificationOnKill: true,
    ),
  );

  runApp(const Quran());
}

class Quran extends StatefulWidget {
  const Quran({super.key});

  @override
  State<Quran> createState() => _QuranState();
}

class _QuranState extends State<Quran> {
  late List<AlarmSettings> alarms;

  @override
  void initState() {
    super.initState();
    loadAlarms();
  }

  void loadAlarms() {
    setState(() {
      alarms = Alarm.getAlarms();
      alarms.sort((a, b) => a.dateTime.isBefore(b.dateTime) ? 0 : 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(374, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return BlocProvider(
          create: (context) => AppCubit(),
          child: MaterialApp(
            locale: const Locale("ar"),
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            theme: ThemeData(fontFamily: "TheSans"),
            supportedLocales: S.delegate.supportedLocales,
            debugShowCheckedModeBanner: false,
            title: "قرآني",
            home: const Splash(),
          ),
        );
      },
    );
  }
}
