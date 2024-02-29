import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/core/app_cubit/app_cubit.dart';

import '../../core/Cache/local_network.dart';
import '../../core/colors.dart';
import '../../main.dart';

class Surah extends StatefulWidget {
  final Map surah;
  final int page;
  final int index;
  final String name;
  final String pdfName;
  const Surah(
      {super.key,
      required this.page,
      required this.name,
      required this.surah,
      required this.pdfName,
      required this.index});

  @override
  State<Surah> createState() => _SurahState();
}

class _SurahState extends State<Surah> {
  final Completer<PDFViewController> _pdfViewController =
      Completer<PDFViewController>();
  int pageCount = 0;
  final StreamController<String> _pageCountController =
      StreamController<String>();
  int currentPage = 0;
  bool reversedDefaultPage = false;
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
                padding: EdgeInsets.only(top: 45.h),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          widget.pdfName == "quran"
                              ? Row(
                                  children: [
                                    currentList.any((item) =>
                                            item['name'] == widget.name)
                                        ? IconButton(
                                            onPressed: () async {
                                              AppCubit.get(context).updateCache(
                                                  "lastRead", "false");
                                              await CacheNetwork
                                                  .removeItemFromList(
                                                      widget.surah["name"]);
                                              currentList =
                                                  await CacheNetwork.loadData();
                                              print(
                                                  'Current List: $currentList');
                                            },
                                            icon: Icon(
                                              Icons.bookmark_added,
                                              color: Colors.white,
                                              size: 26.h,
                                            ),
                                          )
                                        : IconButton(
                                            onPressed: () async {
                                              widget.surah["currentPage"] =
                                                  pageCount - currentPage - 1;
                                              AppCubit.get(context).addToCache(
                                                  "lastRead", "true");
                                              await CacheNetwork.addMapToList(
                                                  widget.surah);
                                              currentList =
                                                  await CacheNetwork.loadData();
                                              print(
                                                  'Current List: $currentList');
                                            },
                                            icon: Icon(
                                              Icons.bookmark_add_outlined,
                                              color: Colors.white,
                                              size: 26.h,
                                            ),
                                          ),
                                    SizedBox(width: 10.w),
                                    Text(
                                      "قرآني",
                                      style: TextStyle(
                                        fontSize: 23.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontFamily: "TheSansBold",
                                      ),
                                    ),
                                  ],
                                )
                              : Padding(
                                  padding: EdgeInsets.only(right: 30.w),
                                  child: Text(
                                    "قرآني",
                                    style: TextStyle(
                                      fontSize: 23.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: "TheSansBold",
                                    ),
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
                    ),
                    SizedBox(height: 10.h),
                    SizedBox(
                      height: 650.h,
                      child: PDF(
                        defaultPage: widget.page == 0 ? 1 : widget.page,
                        swipeHorizontal: true,
                        preventLinkNavigation: true,
                        fitPolicy: FitPolicy.BOTH,
                        onPageChanged: (int? current, int? total) async {
                          pageCount = total!;
                          if (!reversedDefaultPage) {
                            final pdfController =
                                await _pdfViewController.future;
                            pdfController.setPage(total - widget.page - 1);
                            reversedDefaultPage = true;
                            return;
                          }
                          _pageCountController.add('${current! + 1} - $total');
                          currentPage = current;
                          print('page changed $currentPage');
                        },
                        onViewCreated:
                            (PDFViewController pdfViewController) async {
                          _pdfViewController.complete(pdfViewController);
                          final int currentPage =
                              await pdfViewController.getCurrentPage() ?? 0;
                          _pageCountController
                              .add('${currentPage + 1} - $pageCount');
                        },
                      ).fromAsset(
                        "assets/pdf/${widget.pdfName}.pdf",
                        loadingWidget: () => const Center(
                            child: CircularProgressIndicator(
                                color: AppColors.primary)),
                        errorWidget: (dynamic error) => const Center(
                            child: Text("حدث خطأ ما.. حاول مرة اخرى")),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: FutureBuilder<PDFViewController>(
            future: _pdfViewController.future,
            builder: (_, AsyncSnapshot<PDFViewController> snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return SizedBox(
                  width: 345.w,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      FloatingActionButton(
                        backgroundColor: AppColors.primary,
                        heroTag: '+',
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: 25.h,
                        ),
                        onPressed: () async {
                          final PDFViewController pdfController =
                              snapshot.data!;
                          final int currentPage =
                              (await pdfController.getCurrentPage())! + 1;
                          final int numberOfPages =
                              await pdfController.getPageCount() ?? 0;
                          if (numberOfPages > currentPage) {
                            await pdfController.setPage(currentPage);
                          }
                        },
                      ),
                      FloatingActionButton(
                        backgroundColor: AppColors.primary,
                        heroTag: '-',
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                          size: 25.h,
                        ),
                        onPressed: () async {
                          final PDFViewController pdfController =
                              snapshot.data!;
                          final int currentPage =
                              (await pdfController.getCurrentPage())! - 1;
                          if (currentPage >= 0) {
                            await pdfController.setPage(currentPage);
                          }
                        },
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        );
      },
    );
  }
}
