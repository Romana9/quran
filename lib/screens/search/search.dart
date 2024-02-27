import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quran/core/app_cubit/app_cubit.dart';
import '../surah/surah.dart';

class Search extends StatelessWidget {
  const Search({super.key});

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
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "قرآني",
                          style: TextStyle(
                            fontSize: 23.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: "TheSansBold",
                          ),
                        ),
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 25.h,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    AppCubit.get(context).search.isEmpty
                        ? SizedBox(
                            height: 600.h,
                            child: Center(
                              child: Text(
                                "اكتب اسم السوره صحيح من فضلك",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 32.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.italic,
                                  fontFamily: "TheSansBold",
                                ),
                              ),
                            ),
                          )
                        : Expanded(
                            child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.all(0),
                              itemCount: AppCubit.get(context).search.length,
                              separatorBuilder:
                                  (BuildContext context, int index) => SizedBox(
                                width: 326.w,
                                child: Divider(
                                  color: const Color(0xffBBC4CE),
                                  thickness: 1.h,
                                ),
                              ),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Surah(
                                                page: AppCubit.get(context)
                                                    .search[index]["page"],
                                                name: AppCubit.get(context)
                                                    .search[index]["name"],
                                                surah: AppCubit.get(context)
                                                    .search[index],
                                                pdfName: 'quran',
                                              ))),
                                  child: SizedBox(
                                    height: 62.h,
                                    width: 342.w,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Stack(
                                              children: [
                                                SvgPicture.asset(
                                                  "assets/svg/aya.svg",
                                                  height: 42.h,
                                                  width: 42.w,
                                                  fit: BoxFit.cover,
                                                ),
                                                Positioned(
                                                  right: index + 1 < 10
                                                      ? 17.w
                                                      : index + 1 < 100
                                                          ? 13.w
                                                          : 8.5.w,
                                                  top: 10.h,
                                                  child: Text(
                                                    "${index + 1}",
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(width: 16.w),
                                            Text(
                                              AppCubit.get(context)
                                                  .search[index]["name"],
                                              style: TextStyle(
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              AppCubit.get(context)
                                                              .search[index]
                                                          ["makkia"] ==
                                                      1
                                                  ? "مكية"
                                                  : "مدنية",
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                color: const Color(0xff8789A3),
                                              ),
                                            ),
                                            SizedBox(width: 5.w),
                                            Icon(
                                              Icons.circle,
                                              size: 4.h,
                                              color: const Color(0xffBBC4CE),
                                            ),
                                            SizedBox(width: 5.w),
                                            Text(
                                              "${AppCubit.get(context).search[index]["aya"]} آية ",
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                color: const Color(0xff8789A3),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
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
