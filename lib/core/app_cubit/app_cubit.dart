import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../Cache/local_network.dart';
// import 'package:http/http.dart' as http;
part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context) => BlocProvider.of(context);

  int buttonIndex = 0;

  buttonIndexFun(index) {
    buttonIndex = index;
    emit(ButtonIndexState());
  }

  updateCache(String key, String newValue) async {
    await CacheNetwork.update(key: key, newValue: newValue);
    emit(UpdateCache());
  }

  List search = [];
  List surah = [
    {
      "page": 0,
      "name": "الفاتحة",
      "aya": 7,
      "makkia": 1,
    },
    {
      "page": 0,
      "name": "البقرة",
      "aya": 286,
      "makkia": 0,
    },
    {
      "page": 48,
      "name": "آل عمران",
      "aya": 200,
      "makkia": 0,
    },
    {
      "page": 75,
      "name": "النساء",
      "aya": 176,
      "makkia": 0,
    },
    {
      "page": 104,
      "name": "المائدة",
      "aya": 120,
      "makkia": 0,
    },
    {
      "page": 126,
      "name": "الأنعام",
      "aya": 165,
      "makkia": 1,
    },
    {
      "page": 149,
      "name": "الأعراف",
      "aya": 206,
      "makkia": 1,
    },
    {
      "page": 175,
      "name": "الأنفال",
      "aya": 75,
      "makkia": 0,
    },
    {
      "page": 185,
      "name": "التوبة",
      "aya": 129,
      "makkia": 0,
    },
    {
      "page": 206,
      "name": "يونس",
      "aya": 109,
      "makkia": 1,
    },
    {
      "page": 219,
      "name": "هود",
      "aya": 123,
      "makkia": 1,
    },
    {
      "page": 233,
      "name": "يوسف",
      "aya": 111,
      "makkia": 1,
    },
    {
      "page": 247,
      "name": "الرعد",
      "aya": 43,
      "makkia": 0,
    },
    {
      "page": 253,
      "name": "إبراهيم",
      "aya": 52,
      "makkia": 1,
    },
    {
      "page": 260,
      "name": "الحجر",
      "aya": 99,
      "makkia": 1,
    },
    {
      "page": 265,
      "name": "النحل",
      "aya": 128,
      "makkia": 1,
    },
    {
      "page": 280,
      "name": "الإسراء",
      "aya": 111,
      "makkia": 1,
    },
    {
      "page": 291,
      "name": "الكهف",
      "aya": 110,
      "makkia": 1,
    },
    {
      "page": 303,
      "name": "مريم",
      "aya": 98,
      "makkia": 1,
    },
    {
      "page": 310,
      "name": "طه",
      "aya": 135,
      "makkia": 1,
    },
    {
      "page": 320,
      "name": "الأنبياء",
      "aya": 112,
      "makkia": 1,
    },
    {
      "page": 330,
      "name": "الحج",
      "aya": 78,
      "makkia": 0,
    },
    {
      "page": 340,
      "name": "المؤمنون",
      "aya": 118,
      "makkia": 1,
    },
    {
      "page": 348,
      "name": "النور",
      "aya": 64,
      "makkia": 0,
    },
    {
      "page": 357,
      "name": "الفرقان",
      "aya": 77,
      "makkia": 1,
    },
    {
      "page": 365,
      "name": "الشعراء",
      "aya": 227,
      "makkia": 1,
    },
    {
      "page": 375,
      "name": "النمل",
      "aya": 93,
      "makkia": 1,
    },
    {
      "page": 383,
      "name": "القصص",
      "aya": 88,
      "makkia": 1,
    },
    {
      "page": 394,
      "name": "العنكبوت",
      "aya": 69,
      "makkia": 1,
    },
    {
      "page": 402,
      "name": "الروم",
      "aya": 60,
      "makkia": 1,
    },
    {
      "page": 409,
      "name": "لقمان",
      "aya": 34,
      "makkia": 1,
    },
    {
      "page": 413,
      "name": "السجدة",
      "aya": 30,
      "makkia": 1,
    },
    {
      "page": 416,
      "name": "الأحزاب",
      "aya": 73,
      "makkia": 0,
    },
    {
      "page": 426,
      "name": "سبأ",
      "aya": 54,
      "makkia": 1,
    },
    {
      "page": 432,
      "name": "فاطر",
      "aya": 45,
      "makkia": 1,
    },
    {
      "page": 438,
      "name": "يس",
      "aya": 83,
      "makkia": 1,
    },
    {
      "page": 444,
      "name": "الصافات",
      "aya": 182,
      "makkia": 1,
    },
    {
      "page": 451,
      "name": "ص",
      "aya": 88,
      "makkia": 1,
    },
    {
      "page": 456,
      "name": "الزمر",
      "aya": 75,
      "makkia": 1,
    },
    {
      "page": 465,
      "name": "غافر",
      "aya": 85,
      "makkia": 1,
    },
    {
      "page": 475,
      "name": "فصلت",
      "aya": 54,
      "makkia": 1,
    },
    {
      "page": 481,
      "name": "الشورى",
      "aya": 53,
      "makkia": 1,
    },
    {
      "page": 487,
      "name": "الزخرف",
      "aya": 89,
      "makkia": 1,
    },
    {
      "page": 494,
      "name": "الدّخان",
      "aya": 59,
      "makkia": 1,
    },
    {
      "page": 497,
      "name": "الجاثية",
      "aya": 37,
      "makkia": 1,
    },
    {
      "page": 500,
      "name": "الأحقاف",
      "aya": 35,
      "makkia": 1,
    },
    {
      "page": 505,
      "name": "محمد",
      "aya": 38,
      "makkia": 0,
    },
    {
      "page": 509,
      "name": "الفتح",
      "aya": 29,
      "makkia": 0,
    },
    {
      "page": 513,
      "name": "الحجرات",
      "aya": 18,
      "makkia": 0,
    },
    {
      "page": 516,
      "name": "ق",
      "aya": 45,
      "makkia": 1,
    },
    {
      "page": 518,
      "name": "الذاريات",
      "aya": 60,
      "makkia": 1,
    },
    {
      "page": 521,
      "name": "الطور",
      "aya": 49,
      "makkia": 1,
    },
    {
      "page": 524,
      "name": "النجم",
      "aya": 60,
      "makkia": 1,
    },
    {
      "page": 526,
      "name": "القمر",
      "aya": 55,
      "makkia": 1,
    },
    {
      "page": 529,
      "name": "الرحمن",
      "aya": 78,
      "makkia": 0,
    },
    {
      "page": 532,
      "name": "الواقعة",
      "aya": 96,
      "makkia": 1,
    },
    {
      "page": 535,
      "name": "الحديد",
      "aya": 29,
      "makkia": 0,
    },
    {
      "page": 540,
      "name": "المجادلة",
      "aya": 22,
      "makkia": 0,
    },
    {
      "page": 543,
      "name": "الحشر",
      "aya": 24,
      "makkia": 0,
    },
    {
      "page": 547,
      "name": "الممتحنة",
      "aya": 13,
      "makkia": 0,
    },
    {
      "page": 549,
      "name": "الصف",
      "aya": 14,
      "makkia": 0,
    },
    {
      "page": 551,
      "name": "الجمعة",
      "aya": 11,
      "makkia": 0,
    },
    {
      "page": 552,
      "name": "المنافقون",
      "aya": 11,
      "makkia": 0,
    },
    {
      "page": 554,
      "name": "التغابن",
      "aya": 18,
      "makkia": 0,
    },
    {
      "page": 556,
      "name": "الطلاق",
      "aya": 12,
      "makkia": 0,
    },
    {
      "page": 558,
      "name": "التحريم",
      "aya": 12,
      "makkia": 0,
    },
    {
      "page": 560,
      "name": "الملك",
      "aya": 30,
      "makkia": 1,
    },
    {
      "page": 562,
      "name": "القلم",
      "aya": 52,
      "makkia": 1,
    },
    {
      "page": 564,
      "name": "الحاقة",
      "aya": 52,
      "makkia": 1,
    },
    {
      "page": 566,
      "name": "المعارج",
      "aya": 44,
      "makkia": 1,
    },
    {
      "page": 568,
      "name": "نوح",
      "aya": 28,
      "makkia": 1,
    },
    {
      "page": 570,
      "name": "الجن",
      "aya": 28,
      "makkia": 1,
    },
    {
      "page": 572,
      "name": "المزمل",
      "aya": 20,
      "makkia": 1,
    },
    {
      "page": 573,
      "name": "المدثر",
      "aya": 56,
      "makkia": 1,
    },
    {
      "page": 575,
      "name": "القيامة",
      "aya": 40,
      "makkia": 1,
    },
    {
      "page": 576,
      "name": "الإنسان",
      "aya": 31,
      "makkia": 0,
    },
    {
      "page": 578,
      "name": "المرسلات",
      "aya": 50,
      "makkia": 1,
    },
    {
      "page": 580,
      "name": "النبأ",
      "aya": 40,
      "makkia": 1,
    },
    {
      "page": 581,
      "name": "النازعات",
      "aya": 46,
      "makkia": 1,
    },
    {
      "page": 583,
      "name": "عبس",
      "aya": 42,
      "makkia": 1,
    },
    {
      "page": 584,
      "name": "التكوير",
      "aya": 29,
      "makkia": 1,
    },
    {
      "page": 585,
      "name": "الإنفطار",
      "aya": 19,
      "makkia": 1,
    },
    {
      "page": 585,
      "name": "المطففين",
      "aya": 36,
      "makkia": 1,
    },
    {
      "page": 587,
      "name": "الإنشقاق",
      "aya": 25,
      "makkia": 1,
    },
    {
      "page": 588,
      "name": "البروج",
      "aya": 22,
      "makkia": 1,
    },
    {
      "page": 589,
      "name": "الطارق",
      "aya": 17,
      "makkia": 1,
    },
    {
      "page": 589,
      "name": "الأعلى",
      "aya": 19,
      "makkia": 1,
    },
    {
      "page": 590,
      "name": "الغاشية",
      "aya": 26,
      "makkia": 1,
    },
    {
      "page": 591,
      "name": "الفجر",
      "aya": 30,
      "makkia": 1,
    },
    {
      "page": 592,
      "name": "البلد",
      "aya": 20,
      "makkia": 1,
    },
    {
      "page": 593,
      "name": "الشمس",
      "aya": 15,
      "makkia": 1,
    },
    {
      "page": 593,
      "name": "الليل",
      "aya": 21,
      "makkia": 1,
    },
    {
      "page": 594,
      "name": "الضحى",
      "aya": 11,
      "makkia": 1,
    },
    {
      "page": 594,
      "name": "الشرح",
      "aya": 8,
      "makkia": 1,
    },
    {
      "page": 595,
      "name": "التين",
      "aya": 8,
      "makkia": 1,
    },
    {
      "page": 595,
      "name": "العلق",
      "aya": 19,
      "makkia": 1,
    },
    {
      "page": 596,
      "name": "القدر",
      "aya": 5,
      "makkia": 1,
    },
    {
      "page": 596,
      "name": "البينة",
      "aya": 8,
      "makkia": 0,
    },
    {
      "page": 597,
      "name": "الزلزلة",
      "aya": 8,
      "makkia": 0,
    },
    {
      "page": 597,
      "name": "العاديات",
      "aya": 11,
      "makkia": 1,
    },
    {
      "page": 598,
      "name": "القارعة",
      "aya": 11,
      "makkia": 1,
    },
    {
      "page": 598,
      "name": "التكاثر",
      "aya": 8,
      "makkia": 1,
    },
    {
      "page": 599,
      "name": "العصر",
      "aya": 3,
      "makkia": 1,
    },
    {
      "page": 599,
      "name": "الهمزة",
      "aya": 9,
      "makkia": 1,
    },
    {
      "page": 599,
      "name": "الفيل",
      "aya": 5,
      "makkia": 1,
    },
    {
      "page": 600,
      "name": "قريش",
      "aya": 4,
      "makkia": 1,
    },
    {
      "page": 600,
      "name": "الماعون",
      "aya": 7,
      "makkia": 1,
    },
    {
      "page": 600,
      "name": "الكوثر",
      "aya": 3,
      "makkia": 1,
    },
    {
      "page": 601,
      "name": "الكافرون",
      "aya": 6,
      "makkia": 1,
    },
    {
      "page": 601,
      "name": "النصر",
      "aya": 3,
      "makkia": 0,
    },
    {
      "page": 601,
      "name": "المسد",
      "aya": 5,
      "makkia": 1,
    },
    {
      "page": 602,
      "name": "الإخلاص",
      "aya": 4,
      "makkia": 1,
    },
    {
      "page": 602,
      "name": "الفلق",
      "aya": 5,
      "makkia": 1,
    },
    {
      "page": 602,
      "name": "الناس",
      "aya": 6,
      "makkia": 1,
    }
  ];
}
