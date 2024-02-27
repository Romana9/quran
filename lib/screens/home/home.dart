import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:quran/core/app_cubit/app_cubit.dart';
import '../../core/widgets/custom_appbar.dart';
import '../../main.dart';
import 'widgets/azkar_listview.dart';
import 'widgets/last_read_listview.dart';
import 'widgets/prayer_time_container.dart';
import 'widgets/qiblah_compass.dart';
import 'widgets/surah_listview.dart';
import 'widgets/row_buttons.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Image.asset(
                  "assets/img/home.png",
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 50.h, right: 24.w, left: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomAppBar(),
                    SizedBox(height: 24.h),
                    const PrayerTimeContainer(),
                    SizedBox(height: 24.h),
                    const CustomRowButtons(),
                    SizedBox(height: 24.h),
                    AppCubit.get(context).buttonIndex == 0
                        ? const SurahListView()
                        : AppCubit.get(context).buttonIndex == 1
                            ? const AzkarListView()
                            : AppCubit.get(context).buttonIndex == 2
                                ? currentList.isEmpty
                                    ? SizedBox(
                                        height: 350.h,
                                        child: Center(
                                          child: Lottie.asset(
                                            'assets/svg/bookmark.json',
                                          ),
                                        ),
                                      )
                                    : const LastReadListView()
                                : const QiblahCompass(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
