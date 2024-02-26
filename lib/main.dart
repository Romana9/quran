import 'package:adhan/adhan.dart';
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
  await CacheNetwork.cacheInitilzation();
  await LocationHelper.determinePosition();
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

  runApp(const Quran());
}

class Quran extends StatelessWidget {
  const Quran({super.key});

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
