import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:meta/meta.dart';
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

  String url = '';
  forLoop() {
    for (int i = 1; i <= 114; i++) {
      String paddedNumber = i.toString().padLeft(3, '0');
      String url =
          "https://www.nourelquran.com/quranforall/fahd/source-pdf/$paddedNumber.pdf";
      const PDF().cachedFromUrl(
        url,
        placeholder: (double progress) => Center(child: Text('$progress %')),
        errorWidget: (dynamic error) =>
            const Center(child: Text("حدث خطأ ما.. حاول مرة اخرى")),
        whenDone: (filePath) => print("hhhhhhhhhhhh $filePath hhhhhhhhhhh"),
      );
      print(url);
    }
  }

  List search = [];
  List surah = [
    {
      "id": "001",
      "name": "الفاتحة",
      "aya": 7,
      "makkia": 1,
    },
    {
      "id": "002",
      "name": "البقرة",
      "aya": 286,
      "makkia": 0,
    },
    {
      "id": "003",
      "name": "آل عمران",
      "aya": 200,
      "makkia": 0,
    },
    {
      "id": "004",
      "name": "النساء",
      "aya": 176,
      "makkia": 0,
    },
    {
      "id": "005",
      "name": "المائدة",
      "aya": 120,
      "makkia": 0,
    },
    {
      "id": "006",
      "name": "الأنعام",
      "aya": 165,
      "makkia": 1,
    },
    {
      "id": "007",
      "name": "الأعراف",
      "aya": 206,
      "makkia": 1,
    },
    {
      "id": "008",
      "name": "الأنفال",
      "aya": 75,
      "makkia": 0,
    },
    {
      "id": "009",
      "name": "التوبة",
      "aya": 129,
      "makkia": 0,
    },
    {
      "id": "010",
      "name": "يونس",
      "aya": 109,
      "makkia": 1,
    },
    {
      "id": "011",
      "name": "هود",
      "aya": 123,
      "makkia": 1,
    },
    {
      "id": "012",
      "name": "يوسف",
      "aya": 111,
      "makkia": 1,
    },
    {
      "id": "013",
      "name": "الرعد",
      "aya": 43,
      "makkia": 0,
    },
    {
      "id": "014",
      "name": "إبراهيم",
      "aya": 52,
      "makkia": 1,
    },
    {
      "id": "015",
      "name": "الحجر",
      "aya": 99,
      "makkia": 1,
    },
    {
      "id": "016",
      "name": "النحل",
      "aya": 128,
      "makkia": 1,
    },
    {
      "id": "017",
      "name": "الإسراء",
      "aya": 111,
      "makkia": 1,
    },
    {
      "id": "018",
      "name": "الكهف",
      "aya": 110,
      "makkia": 1,
    },
    {
      "id": "019",
      "name": "مريم",
      "aya": 98,
      "makkia": 1,
    },
    {
      "id": "020",
      "name": "طه",
      "aya": 135,
      "makkia": 1,
    },
    {
      "id": "021",
      "name": "الأنبياء",
      "aya": 112,
      "makkia": 1,
    },
    {
      "id": "022",
      "name": "الحج",
      "aya": 78,
      "makkia": 0,
    },
    {
      "id": "023",
      "name": "المؤمنون",
      "aya": 118,
      "makkia": 1,
    },
    {
      "id": "024",
      "name": "النور",
      "aya": 64,
      "makkia": 0,
    },
    {
      "id": "025",
      "name": "الفرقان",
      "aya": 77,
      "makkia": 1,
    },
    {
      "id": "026",
      "name": "الشعراء",
      "aya": 227,
      "makkia": 1,
    },
    {
      "id": "027",
      "name": "النمل",
      "aya": 93,
      "makkia": 1,
    },
    {
      "id": "028",
      "name": "القصص",
      "aya": 88,
      "makkia": 1,
    },
    {
      "id": "029",
      "name": "العنكبوت",
      "aya": 69,
      "makkia": 1,
    },
    {
      "id": "030",
      "name": "الروم",
      "aya": 60,
      "makkia": 1,
    },
    {
      "id": "031",
      "name": "لقمان",
      "aya": 34,
      "makkia": 1,
    },
    {
      "id": "032",
      "name": "السجدة",
      "aya": 30,
      "makkia": 1,
    },
    {
      "id": "033",
      "name": "الأحزاب",
      "aya": 73,
      "makkia": 0,
    },
    {
      "id": "034",
      "name": "سبأ",
      "aya": 54,
      "makkia": 1,
    },
    {
      "id": "035",
      "name": "فاطر",
      "aya": 45,
      "makkia": 1,
    },
    {
      "id": "036",
      "name": "يس",
      "aya": 83,
      "makkia": 1,
    },
    {
      "id": "037",
      "name": "الصافات",
      "aya": 182,
      "makkia": 1,
    },
    {
      "id": "038",
      "name": "ص",
      "aya": 88,
      "makkia": 1,
    },
    {
      "id": "039",
      "name": "الزمر",
      "aya": 75,
      "makkia": 1,
    },
    {
      "id": "040",
      "name": "غافر",
      "aya": 85,
      "makkia": 1,
    },
    {
      "id": "041",
      "name": "فصلت",
      "aya": 54,
      "makkia": 1,
    },
    {
      "id": "042",
      "name": "الشورى",
      "aya": 53,
      "makkia": 1,
    },
    {
      "id": "043",
      "name": "الزخرف",
      "aya": 89,
      "makkia": 1,
    },
    {
      "id": "044",
      "name": "الدّخان",
      "aya": 59,
      "makkia": 1,
    },
    {
      "id": "045",
      "name": "الجاثية",
      "aya": 37,
      "makkia": 1,
    },
    {
      "id": "046",
      "name": "الأحقاف",
      "aya": 35,
      "makkia": 1,
    },
    {
      "id": "047",
      "name": "محمد",
      "aya": 38,
      "makkia": 0,
    },
    {
      "id": "048",
      "name": "الفتح",
      "aya": 29,
      "makkia": 0,
    },
    {
      "id": "049",
      "name": "الحجرات",
      "aya": 18,
      "makkia": 0,
    },
    {
      "id": "050",
      "name": "ق",
      "aya": 45,
      "makkia": 1,
    },
    {
      "id": "051",
      "name": "الذاريات",
      "aya": 60,
      "makkia": 1,
    },
    {
      "id": "052",
      "name": "الطور",
      "aya": 49,
      "makkia": 1,
    },
    {
      "id": "053",
      "name": "النجم",
      "aya": 60,
      "makkia": 1,
    },
    {
      "id": "054",
      "name": "القمر",
      "aya": 55,
      "makkia": 1,
    },
    {
      "id": "055",
      "name": "الرحمن",
      "aya": 78,
      "makkia": 0,
    },
    {
      "id": "056",
      "name": "الواقعة",
      "aya": 96,
      "makkia": 1,
    },
    {
      "id": "057",
      "name": "الحديد",
      "aya": 29,
      "makkia": 0,
    },
    {
      "id": "058",
      "name": "المجادلة",
      "aya": 22,
      "makkia": 0,
    },
    {
      "id": "059",
      "name": "الحشر",
      "aya": 24,
      "makkia": 0,
    },
    {
      "id": "060",
      "name": "الممتحنة",
      "aya": 13,
      "makkia": 0,
    },
    {
      "id": "061",
      "name": "الصف",
      "aya": 14,
      "makkia": 0,
    },
    {
      "id": "062",
      "name": "الجمعة",
      "aya": 11,
      "makkia": 0,
    },
    {
      "id": "063",
      "name": "المنافقون",
      "aya": 11,
      "makkia": 0,
    },
    {
      "id": "064",
      "name": "التغابن",
      "aya": 18,
      "makkia": 0,
    },
    {
      "id": "065",
      "name": "الطلاق",
      "aya": 12,
      "makkia": 0,
    },
    {
      "id": "066",
      "name": "التحريم",
      "aya": 12,
      "makkia": 0,
    },
    {
      "id": "067",
      "name": "الملك",
      "aya": 30,
      "makkia": 1,
    },
    {
      "id": "068",
      "name": "القلم",
      "aya": 52,
      "makkia": 1,
    },
    {
      "id": "069",
      "name": "الحاقة",
      "aya": 52,
      "makkia": 1,
    },
    {
      "id": "070",
      "name": "المعارج",
      "aya": 44,
      "makkia": 1,
    },
    {
      "id": "071",
      "name": "نوح",
      "aya": 28,
      "makkia": 1,
    },
    {
      "id": "072",
      "name": "الجن",
      "aya": 28,
      "makkia": 1,
    },
    {
      "id": "073",
      "name": "المزمل",
      "aya": 20,
      "makkia": 1,
    },
    {
      "id": "074",
      "name": "المدثر",
      "aya": 56,
      "makkia": 1,
    },
    {
      "id": "075",
      "name": "القيامة",
      "aya": 40,
      "makkia": 1,
    },
    {
      "id": "076",
      "name": "الإنسان",
      "aya": 31,
      "makkia": 0,
    },
    {
      "id": "077",
      "name": "المرسلات",
      "aya": 50,
      "makkia": 1,
    },
    {
      "id": "078",
      "name": "النبأ",
      "aya": 40,
      "makkia": 1,
    },
    {
      "id": "079",
      "name": "النازعات",
      "aya": 46,
      "makkia": 1,
    },
    {
      "id": "080",
      "name": "عبس",
      "aya": 42,
      "makkia": 1,
    },
    {
      "id": "081",
      "name": "التكوير",
      "aya": 29,
      "makkia": 1,
    },
    {
      "id": "082",
      "name": "الإنفطار",
      "aya": 19,
      "makkia": 1,
    },
    {
      "id": "083",
      "name": "المطففين",
      "aya": 36,
      "makkia": 1,
    },
    {
      "id": "084",
      "name": "الإنشقاق",
      "aya": 25,
      "makkia": 1,
    },
    {
      "id": "085",
      "name": "البروج",
      "aya": 22,
      "makkia": 1,
    },
    {
      "id": "086",
      "name": "الطارق",
      "aya": 17,
      "makkia": 1,
    },
    {
      "id": "087",
      "name": "الأعلى",
      "aya": 19,
      "makkia": 1,
    },
    {
      "id": "088",
      "name": "الغاشية",
      "aya": 26,
      "makkia": 1,
    },
    {
      "id": "089",
      "name": "الفجر",
      "aya": 30,
      "makkia": 1,
    },
    {
      "id": "090",
      "name": "البلد",
      "aya": 20,
      "makkia": 1,
    },
    {
      "id": "091",
      "name": "الشمس",
      "aya": 15,
      "makkia": 1,
    },
    {
      "id": "092",
      "name": "الليل",
      "aya": 21,
      "makkia": 1,
    },
    {
      "id": "093",
      "name": "الضحى",
      "aya": 11,
      "makkia": 1,
    },
    {
      "id": "094",
      "name": "الشرح",
      "aya": 8,
      "makkia": 1,
    },
    {
      "id": "095",
      "name": "التين",
      "aya": 8,
      "makkia": 1,
    },
    {
      "id": "096",
      "name": "العلق",
      "aya": 19,
      "makkia": 1,
    },
    {
      "id": "097",
      "name": "القدر",
      "aya": 5,
      "makkia": 1,
    },
    {
      "id": "098",
      "name": "البينة",
      "aya": 8,
      "makkia": 0,
    },
    {
      "id": "099",
      "name": "الزلزلة",
      "aya": 8,
      "makkia": 0,
    },
    {
      "id": "100",
      "name": "العاديات",
      "aya": 11,
      "makkia": 1,
    },
    {
      "id": "101",
      "name": "القارعة",
      "aya": 11,
      "makkia": 1,
    },
    {
      "id": "102",
      "name": "التكاثر",
      "aya": 8,
      "makkia": 1,
    },
    {
      "id": "103",
      "name": "العصر",
      "aya": 3,
      "makkia": 1,
    },
    {
      "id": "104",
      "name": "الهمزة",
      "aya": 9,
      "makkia": 1,
    },
    {
      "id": "105",
      "name": "الفيل",
      "aya": 5,
      "makkia": 1,
    },
    {
      "id": "106",
      "name": "قريش",
      "aya": 4,
      "makkia": 1,
    },
    {
      "id": "107",
      "name": "الماعون",
      "aya": 7,
      "makkia": 1,
    },
    {
      "id": "108",
      "name": "الكوثر",
      "aya": 3,
      "makkia": 1,
    },
    {
      "id": "109",
      "name": "الكافرون",
      "aya": 6,
      "makkia": 1,
    },
    {
      "id": "110",
      "name": "النصر",
      "aya": 3,
      "makkia": 0,
    },
    {
      "id": "111",
      "name": "المسد",
      "aya": 5,
      "makkia": 1,
    },
    {
      "id": "112",
      "name": "الإخلاص",
      "aya": 4,
      "makkia": 1,
    },
    {
      "id": "113",
      "name": "الفلق",
      "aya": 5,
      "makkia": 1,
    },
    {
      "id": "114",
      "name": "الناس",
      "aya": 6,
      "makkia": 1,
    }
  ];
}
