import 'package:flutter/material.dart';

import '../controller/Elazkar_controller.dart';
import '../controller/List_pray_controller.dart';
import '../controller/elesthfer_controller.dart';
import '../controller/finish_praye_controller.dart';
import '../controller/quran_controller.dart';
import '../controller/treausers_controller.dart';

import 'images.dart';

const daysOfChallange = [
  ones,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
  ten,
  eleven,
  twelve,
  thre,
  fourteen,
  fivteen,
  sixteen,
  seenteen,
  eighteen,
  ninteen,
  twintey,
];

const texts = ['الصلاة', 'القرآن', 'الأذكار', 'كنوز الجنة', 'إحصائيات اليوم'];
const textEmtnan = ['المنشورات', 'المستخدمين', 'صفحتك'];
const textProfile = ['الإعجابات', 'مشاركتى'];

const emtnan = [
  'المستخدمين',
  'المنشورات',
  'صفحتك',
];

List<Prayer> prayers = [
  Prayer(name: 'الفجر'),
  Prayer(name: 'الظهر'),
  Prayer(name: 'العصر'),
  Prayer(name: 'المغرب'),
  Prayer(name: 'العشاء'),
];
List<FinishPrayer> finishPrayer = [
  FinishPrayer(name: 'سُنن الفروض'),
  FinishPrayer(name: 'الضحي'),
  FinishPrayer(name: 'قيام الليل'),
  /* FinishPrayer(name: 'العصر'),
  FinishPrayer(name: 'المغرب'),
  FinishPrayer(name: 'العشاء'), */
];

List<Quran> quran = [
  Quran(
    name: 'حفظ  ',
  ),
  Quran(
    name: 'تسميع ',
  ),
  Quran(
    name: 'الوِرد اليومي',
  ),
  /*  Quran(
    name: 'سورة البقرة',
  ), */
];

List<Elazkar> elzker = [
  Elazkar(name: 'أذكار الصباح', read: false),
  Elazkar(name: 'اذكار المساء', read: false),
  Elazkar(name: 'اذكار النوم', read: false),
];
List<Elesthfer> elesthfer = [
  Elesthfer(name: 'ورد أستغفار'),
  Elesthfer(name: 'لا حول ولا قوة إلا بالله '),
  Elesthfer(name: 'سبحان الله وبحمده'),
  Elesthfer(name: 'سبحان الله العظيم'),
  Elesthfer(name: 'الصلاة علي النبي'),
  Elesthfer(
      name:
          '''لا إله إلا الله وحده لا شريك له له الملك وله الحمد وهو على كل شئ قدير '''),
];

List<Treasures> elzkerT = [
  Treasures(name: 'جبر خواطر'),
  Treasures(name: 'زيارة مريض'),
  Treasures(name: 'إخراج صدقة'),
  Treasures(name: 'دعاء بظهر الغيب'),
  Treasures(name: 'مشاهدة فيديو ديني'),
  Treasures(name: 'صيام الإثنين والخميس'),
  Treasures(name: 'قراءة سورة الملك قبل النوم'),
];

final List<String> treatment = [
  'الحل النهائي للإنتكاسة - د/ أحمد عبد المنعم',
  'الفتور والملل - عمر عبدالكافي',
  'كيف أقوم بعد الإنتكاس - محمد الغليظ',
  'انتصر على نفسك - الشيخ أحمد السيد',
  'علاج الفتور - م/علاء حامد',
  'كيف تتغلب علي الفتور - أمير منير',
  'المحافظه علي الصلاة - محمد إبراهيم',
  '5 معلومات بعدها مش هتبطل صلاة - أمير منير',
  'أهمية الصلاة - محمد إبراهيم ومحمد الغليظ',
  'الثبات على الصلاة - حازم شومان',
  'خلي قلبك يسمع عن ربنا - مصطفى حسني',
  'التعلق بالقرآن - شريف علي',
  'فضل المداومة على الأذكار - حازم شومان',
  'مبتصليش وبتقطع في الصلاة؟ - محمد الغليظ',
];
List<String> videoUrls = [
  'https://youtube.com/watch?v=Sg17UBfllHM&feature=share7',
  'https://youtube.com/watch?v=PszFVwtjCdg&feature=share7',
  'https://youtube.com/watch?v=cWvdFlH5E6M&feature=share7',
  'https://youtube.com/watch?v=CpgTu3Ne0Bg&feature=share7',
  'https://youtube.com/watch?v=s5DWydPvMjA&feature=share7',
  'https://youtube.com/watch?v=P71H7mXOyxg&feature=share7',
  'https://youtube.com/watch?v=CkTn2q3k-oc&feature=share7',
  'https://youtube.com/watch?v=iL4PrN-Yh50&feature=share7',
  'https://youtube.com/watch?v=xDCRq1P8b44&feature=share7',
  'https://youtube.com/watch?v=IhSk450fXDA&feature=share7',
  'https://youtube.com/watch?v=y00J9a5Ghdc&feature=share7',
  'https://youtube.com/watch?v=hshgodmGzVI&feature=share7',
  'https://youtube.com/watch?v=4X28gps4JL0&feature=share7',
  'https://youtube.com/watch?v=LUhi8GoeBGw&feature=share7',
  'https://youtube.com/watch?v=I9RrVjb8zaw&feature=share7',
];
List<Color> itemColors = [
  const Color(0xff7CA1BC),
  const Color(0xffB3E59F),
  const Color(0xffBEDDF3),
  const Color(0xffFFE07D),
  const Color(0xffE28086),
  const Color.fromARGB(255, 255, 255, 255),
];
