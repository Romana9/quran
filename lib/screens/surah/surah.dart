import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import '../../core/colors.dart';

class Surah extends StatelessWidget {
  final String index;
  final String name;
  const Surah({super.key, required this.index, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 45.h),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "قرآني",
                    style: TextStyle(
                      fontSize: 23.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 25.h,
                      color: const Color(0xff8789A3),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.h),
            Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Stack(
                  children: [
                    Image.asset(
                      "assets/img/surah.png",
                      height: 150.h,
                      width: 327.w,
                      fit: BoxFit.fill,
                    ),
                    Positioned(
                      top: 20.h,
                      right: 100.w,
                      child: Text(
                        "سورة $name",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 560.h,
                  child: const PDF(
                    swipeHorizontal: true,
                    fitPolicy: FitPolicy.BOTH,
                  ).cachedFromUrl(
                    "https://www.nourelquran.com/quranforall/fahd/source-pdf/$index.pdf",
                    placeholder: (double progress) =>
                        Center(child: Text('$progress %')),
                    errorWidget: (dynamic error) =>
                        const Center(child: Text("حدث خطأ ما.. حاول مرة اخرى")),
                  ),
                ),
                // fromAsset(
                //   'assets/pdf/${index + 1}.pdf',
                //   loadingWidget: () =>
                //       const Center(child: CircularProgressIndicator()),
                //   errorWidget: (error) =>
                //       const Center(child: Text("حدث خطأ ما.. حاول مرة اخرى")),
                // ),

                // FutureBuilder<PDFViewController>(
                //   future: _pdfViewController.future,
                //   builder: (_, AsyncSnapshot<PDFViewController> snapshot) {
                //     if (snapshot.hasData && snapshot.data != null) {
                //       return Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                //         children: [
                //           FloatingActionButton(
                //             child:
                //                 Icon(Icons.arrow_back_ios_rounded, size: 25.h),
                //             onPressed: () async {
                //               final PDFViewController pdfController =
                //                   snapshot.data!;
                //               final int currentPage =
                //                   (await pdfController.getCurrentPage())! + 1;
                //               final int numberOfPages =
                //                   await pdfController.getPageCount() ?? 0;
                //               if (numberOfPages > currentPage) {
                //                 await pdfController.setPage(currentPage);
                //               }
                //             },
                //           ),
                //           FloatingActionButton(
                //             child: Icon(Icons.arrow_forward_ios_rounded,
                //                 size: 25.h),
                //             onPressed: () async {
                //               final PDFViewController pdfController =
                //                   snapshot.data!;
                //               final int currentPage =
                //                   (await pdfController.getCurrentPage())! - 1;
                //               if (currentPage >= 0) {
                //                 await pdfController.setPage(currentPage);
                //               }
                //             },
                //           ),
                //         ],
                //       );
                //     }
                //     return const SizedBox();
                //   },
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
