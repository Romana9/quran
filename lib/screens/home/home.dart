import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:quran/core/app_cubit/app_cubit.dart';
import 'package:quran/screens/surah/surah.dart';
import '../../core/colors.dart';
import '../../core/widgets/custom_appbar.dart';
import '../../main.dart';
import '../search/search.dart';
import 'widgets/prayer_time_container.dart';
import 'widgets/surah_listview.dart';

final _searchController = TextEditingController();

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
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  image: DecorationImage(
                    opacity: 0.5,
                    fit: BoxFit.fill,
                    image: AssetImage("assets/img/home.png"),
                  ),
                ),
              ),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.only(top: 50.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: const CustomAppBar(),
                      ),
                      SizedBox(height: 24.h),
                      const PrayerTimeContainer(),
                      SizedBox(height: 24.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 300.w,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(15.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade400,
                                  blurRadius: 5.r,
                                  spreadRadius: 1.r,
                                  offset: const Offset(0, 0),
                                ),
                              ],
                            ),
                            child: TextFormField(
                              controller: _searchController,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.sp),
                              cursorColor: AppColors.secondray,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.search,
                              onFieldSubmitted: (value) {
                                AppCubit.get(context).search =
                                    AppCubit.get(context)
                                        .surah
                                        .where((s) => s["name"]
                                            .toString()
                                            .contains(_searchController.text))
                                        .toList();
                                PersistentNavBarNavigator.pushNewScreen(
                                  context,
                                  screen: const Search(),
                                  withNavBar: true,
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.cupertino,
                                );
                                _searchController.clear();
                              },
                              decoration: InputDecoration(
                                hintText: "عن اي سورة تبحث ؟",
                                hintStyle: TextStyle(
                                    fontSize: 16.sp, color: Colors.grey),
                                prefixIcon: Padding(
                                  padding: EdgeInsets.all(8.h),
                                  child: Icon(
                                    Icons.search,
                                    size: 20.h,
                                    color: const Color(0xff8789A3),
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 12.h, horizontal: 10.w),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.r)),
                                    borderSide:
                                        const BorderSide(color: Colors.white)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: AppColors.secondray,
                                    ),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.r))),
                                border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.r))),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 14.h),
                      Visibility(
                        visible: lastRead.isEmpty ? false : true,
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                PersistentNavBarNavigator.pushNewScreen(
                                  context,
                                  screen: Surah(
                                    page: lastRead[0]["currentPage"] ??
                                        lastRead[0]["page"],
                                    name: lastRead[0]["name"],
                                    surah: lastRead[0],
                                    pdfName: 'quran',
                                    index: 0,
                                  ),
                                  withNavBar: false,
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.cupertino,
                                );
                              },
                              child: Center(
                                child: Container(
                                  width: 300.w,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.w, vertical: 10.h),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(15.r),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        ' آخر قراءة',
                                        style: TextStyle(
                                          fontSize: 20.sp,
                                          color: Colors.white,
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: "TheSansBold",
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        size: 21.h,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 14.h),
                          ],
                        ),
                      ),

                      const SurahListView(),
                      // AppCubit.get(context).buttonIndex == 0
                      //     ?
                      //     : AppCubit.get(context).buttonIndex == 1
                      //         ? const AzkarListView()
                      //         : AppCubit.get(context).buttonIndex == 2
                      //             ? currentList.isEmpty
                      //                 ? SizedBox(
                      //                     height: 350.h,
                      //                     child: Center(
                      //                       child: Lottie.asset(
                      //                         'assets/svg/bookmark.json',
                      //                       ),
                      //                     ),
                      //                   )
                      //                 : const LastReadListView()
                      //             : const QiblahCompass(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
