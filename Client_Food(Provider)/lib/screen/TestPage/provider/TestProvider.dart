import 'package:flutter/material.dart';

class TestProvider extends ChangeNotifier {
  TestProvider();

  dynamic listCountryModel = [
    {
      "id": 1,
      "name": "กรุงเทพมหานคร",
      "name_en": "Bangkok",
      "geography_id": 2,
      "select_status": "1"
    },
    {
      "id": 2,
      "name": "สมุทรปราการ",
      "name_en": "Samut Prakan",
      "geography_id": 2,
      "select_status": "0"
    },
    {
      "id": 3,
      "name": "นนทบุรี",
      "name_en": "Nonthaburi",
      "geography_id": 2,
      "select_status": "0"
    },
    {
      "id": 4,
      "name": "ปทุมธานี",
      "name_en": "Pathum Thani",
      "geography_id": 2,
      "select_status": "0"
    },
    {
      "id": 5,
      "name": "พระนครศรีอยุธยา",
      "name_en": "Phra Nakhon Si Ayutthaya",
      "geography_id": 2,
      "select_status": "0"
    },
    {
      "id": 6,
      "name": "อ่างทอง",
      "name_en": "Ang Thong",
      "geography_id": 2,
      "select_status": "0"
    },
    {
      "id": 7,
      "name": "ลพบุรี",
      "name_en": "Loburi",
      "geography_id": 2,
      "select_status": "0"
    },
    {
      "id": 8,
      "name": "สิงห์บุรี",
      "name_en": "Sing Buri",
      "geography_id": 2,
      "select_status": "0"
    },
    {
      "id": 9,
      "name": "ชัยนาท",
      "name_en": "Chai Nat",
      "geography_id": 2,
      "select_status": "0"
    },
    {
      "id": 10,
      "name": "สระบุรี",
      "name_en": "Saraburi",
      "geography_id": 2,
      "select_status": "0"
    },
    {
      "id": 11,
      "name": "ชลบุรี",
      "name_en": "Chon Buri",
      "geography_" "id": 5,
      "select_status": "0"
    },
    {
      "id": 12,
      "name": "ระยอง",
      "name_en": "Rayong",
      "geography_" "id": 5,
      "select_status": "0"
    },
    {
      "id": 13,
      "name": "จันทบุรี",
      "name_en": "Chanthaburi",
      "geography_" "id": 5,
      "select_status": "0"
    },
    {
      "id": 14,
      "name": "ตราด",
      "name_en": "Trat",
      "geography_" "id": 5,
      "select_status": "0"
    },
    {
      "id": 15,
      "name": "ฉะเชิงเทรา",
      "name_en": "Chachoengsao",
      "geography_" "id": 5,
      "select_status": "0"
    },
    {
      "id": 16,
      "name": "ปราจีนบุรี",
      "name_en": "Prachin Buri",
      "geography_" "id": 5,
      "select_status": "0"
    },
    {
      "id": 17,
      "name": "นครนายก",
      "name_en": "Nakhon Nayok",
      "geography_id": 2,
      "select_status": "0"
    },
    {
      "id": 18,
      "name": "สระแก้ว",
      "name_en": "Sa Kaeo",
      "geography_" "id": 5,
      "select_status": "0"
    },
    {
      "id": 19,
      "name": "นครราชสีมา",
      "name_en": "Nakhon Ratchasima",
      "geography_" "id": 3,
      "select_status": "0"
    },
    {
      "id": 20,
      "name": "บุรีรัมย์",
      "name_en": "Buri Ram",
      "geography_" "id": 3,
      "select_status": "0"
    },
    {
      "id": 21,
      "name": "สุรินทร์",
      "name_en": "Surin",
      "geography_" "id": 3,
      "select_status": "0"
    },
    {
      "id": 22,
      "name": "ศรีสะเกษ",
      "name_en": "Si Sa Ket",
      "geography_" "id": 3,
      "select_status": "0"
    },
    {
      "id": 23,
      "name": "อุบลราชธานี",
      "name_en": "Ubon Ratchathani",
      "geography_" "id": 3,
      "select_status": "0"
    },
    {
      "id": 24,
      "name": "ยโสธร",
      "name_en": "Yasothon",
      "geography_" "id": 3,
      "select_status": "0"
    },
    {
      "id": 25,
      "name": "ชัยภูมิ",
      "name_en": "Chaiyaphum",
      "geography_" "id": 3,
      "select_status": "0"
    },
    {
      "id": 26,
      "name": "อำนาจเจริญ",
      "name_en": "Amnat Charoen",
      "geography_" "id": 3,
      "select_status": "0"
    },
    {
      "id": 27,
      "name": "หนองบัวลำภู",
      "name_en": "Nong Bua Lam Phu",
      "geography_" "id": 3,
      "select_status": "0"
    },
    {
      "id": 28,
      "name": "ขอนแก่น",
      "name_en": "Khon Kaen",
      "geography_" "id": 3,
      "select_status": "0"
    },
    {
      "id": 29,
      "name": "อุดรธานี",
      "name_en": "Udon Thani",
      "geography_" "id": 3,
      "select_status": "0"
    },
    {
      "id": 30,
      "name": "เลย",
      "name_en": "Loei",
      "geography_" "id": 3,
      "select_status": "0"
    },
    {
      "id": 31,
      "name": "หนองคาย",
      "name_en": "Nong Khai",
      "geography_" "id": 3,
      "select_status": "0"
    },
    {
      "id": 32,
      "name": "มหาสารคาม",
      "name_en": "Maha Sarakham",
      "geography_" "id": 3,
      "select_status": "0"
    },
    {
      "id": 33,
      "name": "ร้อยเอ็ด",
      "name_en": "Roi Et",
      "geography_" "id": 3,
      "select_status": "0"
    },
    {
      "id": 34,
      "name": "กาฬสินธุ์",
      "name_en": "Kalasin",
      "geography_" "id": 3,
      "select_status": "0"
    },
    {
      "id": 35,
      "name": "สกลนคร",
      "name_en": "Sakon Nakhon",
      "geography_" "id": 3,
      "select_status": "0"
    },
    {
      "id": 36,
      "name": "นครพนม",
      "name_en": "Nakhon Phanom",
      "geography_" "id": 3,
      "select_status": "0"
    },
    {
      "id": 37,
      "name": "มุกดาหาร",
      "name_en": "Mukdahan",
      "geography_" "id": 3,
      "select_status": "0"
    },
    {
      "id": 38,
      "name": "เชียงใหม่",
      "name_en": "Chiang Mai",
      "geography_" "id": 1,
      "select_status": "0"
    },
    {
      "id": 39,
      "name": "ลำพูน",
      "name_en": "Lamphun",
      "geography_" "id": 1,
      "select_status": "0"
    },
    {
      "id": 40,
      "name": "ลำปาง",
      "name_en": "Lampang",
      "geography_" "id": 1,
      "select_status": "0"
    },
    {
      "id": 41,
      "name": "อุตรดิตถ์",
      "name_en": "Uttaradit",
      "geography_" "id": 1,
      "select_status": "0"
    },
    {
      "id": 42,
      "name": "แพร่",
      "name_en": "Phrae",
      "geography_" "id": 1,
      "select_status": "0"
    },
    {
      "id": 43,
      "name": "น่าน",
      "name_en": "Nan",
      "geography_" "id": 1,
      "select_status": "0"
    },
    {
      "id": 44,
      "name": "พะเยา",
      "name_en": "Phayao",
      "geography_" "id": 1,
      "select_status": "0"
    },
    {
      "id": 45,
      "name": "เชียงราย",
      "name_en": "Chiang Rai",
      "geography_" "id": 1,
      "select_status": "0"
    },
    {
      "id": 46,
      "name": "แม่ฮ่องสอน",
      "name_en": "Mae Hong Son",
      "geography_" "id": 1,
      "select_status": "0"
    },
    {
      "id": 47,
      "name": "นครสวรรค์",
      "name_en": "Nakhon Sawan",
      "geography_id": 2,
      "select_status": "0"
    },
    {
      "id": 48,
      "name": "อุทัยธานี",
      "name_en": "Uthai Thani",
      "geography_id": 2,
      "select_status": "0"
    },
    {
      "id": 49,
      "name": "กำแพงเพชร",
      "name_en": "Kamphaeng Phet",
      "geography_id": 2,
      "select_status": "0"
    },
    {
      "id": 50,
      "name": "ตาก",
      "name_en": "Tak",
      "geography_" "id": 4,
      "select_status": "0"
    },
    {
      "id": 51,
      "name": "สุโขทัย",
      "name_en": "Sukhothai",
      "geography_id": 2,
      "select_status": "0"
    },
    {
      "id": 52,
      "name": "พิษณุโลก",
      "name_en": "Phitsanulok",
      "geography_id": 2,
      "select_status": "0"
    },
    {
      "id": 53,
      "name": "พิจิตร",
      "name_en": "Phichit",
      "geography_id": 2,
      "select_status": "0"
    },
    {
      "id": 54,
      "name": "เพชรบูรณ์",
      "name_en": "Phetchabun",
      "geography_id": 2,
      "select_status": "0"
    },
    {
      "id": 55,
      "name": "ราชบุรี",
      "name_en": "Ratchaburi",
      "geography_" "id": 4,
      "select_status": "0"
    },
    {
      "id": 56,
      "name": "กาญจนบุรี",
      "name_en": "Kanchanaburi",
      "geography_" "id": 4,
      "select_status": "0"
    },
    {
      "id": 57,
      "name": "สุพรรณบุรี",
      "name_en": "Suphan Buri",
      "geography_id": 2,
      "select_status": "0"
    },
    {
      "id": 58,
      "name": "นครปฐม",
      "name_en": "Nakhon Pathom",
      "geography_id": 2,
      "select_status": "0"
    },
    {
      "id": 59,
      "name": "สมุทรสาคร",
      "name_en": "Samut Sakhon",
      "geography_id": 2,
      "select_status": "0"
    },
    {
      "id": 60,
      "name": "สมุทรสงคราม",
      "name_en": "Samut Songkhram",
      "geography_id": 2,
      "select_status": "0"
    },
    {
      "id": 61,
      "name": "เพชรบุรี",
      "name_en": "Phetchaburi",
      "geography_" "id": 4,
      "select_status": "0"
    },
    {
      "id": 62,
      "name": "ประจวบคีรีขันธ์",
      "name_en": "Prachuap Khiri Khan",
      "geography_" "id": 4,
      "select_status": "0"
    },
    {
      "id": 63,
      "name": "นครศรีธรรมราช",
      "name_en": "Nakhon Si Thammarat",
      "geography_" "id": 6,
      "select_status": "0"
    },
    {
      "id": 64,
      "name": "กระบี่",
      "name_en": "Krabi",
      "geography_" "id": 6,
      "select_status": "0"
    },
    {
      "id": 65,
      "name": "พังงา",
      "name_en": "Phangnga",
      "geography_" "id": 6,
      "select_status": "0"
    },
    {
      "id": 66,
      "name": "ภูเก็ต",
      "name_en": "Phuket",
      "geography_" "id": 6,
      "select_status": "0"
    },
    {
      "id": 67,
      "name": "สุราษฎร์ธานี",
      "name_en": "Surat Thani",
      "geography_" "id": 6,
      "select_status": "0"
    },
    {
      "id": 68,
      "name": "ระนอง",
      "name_en": "Ranong",
      "geography_" "id": 6,
      "select_status": "0"
    },
    {
      "id": 69,
      "name": "ชุมพร",
      "name_en": "Chumphon",
      "geography_" "id": 6,
      "select_status": "0"
    },
    {
      "id": 70,
      "name": "สงขลา",
      "name_en": "Songkhla",
      "geography_" "id": 6,
      "select_status": "0"
    },
    {
      "id": 71,
      "name": "สตูล",
      "name_en": "Satun",
      "geography_" "id": 6,
      "select_status": "0"
    },
    {
      "id": 72,
      "name": "ตรัง",
      "name_en": "Trang",
      "geography_" "id": 6,
      "select_status": "0"
    },
    {
      "id": 73,
      "name": "พัทลุง",
      "name_en": "Phatthalung",
      "geography_" "id": 6,
      "select_status": "0"
    },
    {
      "id": 74,
      "name": "ปัตตานี",
      "name_en": "Pattani",
      "geography_" "id": 6,
      "select_status": "0"
    },
    {
      "id": 75,
      "name": "ยะลา",
      "name_en": "Yala",
      "geography_" "id": 6,
      "select_status": "0"
    },
    {
      "id": 76,
      "name": "นราธิวาส",
      "name_en": "Narathiwat",
      "geography_" "id": 6,
      "select_status": "0"
    },
    {
      "id": 77,
      "name": "บึงกาฬ",
      "name_en": "buogkan",
      "geography_" "id": 3,
      "select_status": "0"
    }
  ];
  dynamic listPackage = [
    {"id": 1, "name": "เสื้อคลุม", "select_status": "1"},
    {"id": 2, "name": "กล่องเก็บอาหาร", "select_status": "0"},
    {"id": 2, "name": "สายรัด", "select_status": "0"},
  ];
  List<String> countryName = ["กรุงเทพ", "อ่างทอง", "ยะลา", "ระยอง"];
  List<String> bankName = [
    'ออมสิน',
    'กรุงเทพ',
    'กรุงไทย',
    'กสิกร',
    'ไทยพาณิชย์',
    'กรุงศรี',
    'TMB',
  ];
  TextEditingController ageContrl = TextEditingController();
  List<int> radio = [0, 1];
  int grouRadio = 1;
  bool selectAddress = false;
  intit() async {}

//   String MathChallenge(String str) {
//     String result = '';
//     List<String> listData = str.split('');
//     List<String> checkString = [];
//     List<List<String>> addData = [];
//     List<String> allData = [];
//     var seenint = Set<String>();
//     String textElement = '';
//     int count = 0;
//     int checkLengthValue = 0;
//     List<String> uniqueText =
//         listData.where((numone) => seenint.add(numone.toString())).toList();

//     uniqueText.forEach((element) {
//       if (element.allMatches(str).length > 1) {
//         checkString.add(element);
//       }
//     });

//     checkString.forEach((element) {
//       //เอาจำนวนซ้ำมาแยก
//       List<String> araySprit = str.split(element);

//       for (var i = 0; i < araySprit.length; i++) {
//         araySprit[i] = element + araySprit[i];
//       }
//       addData.add(araySprit);
//     });

//     try {
//       addData.forEach((value) {
//         value.removeAt(0);
//         value.forEach((elementInVal) {
//           for (var i = 0; i < value.length; i++) {
//             if (elementInVal == value[i]) {
//               textElement = elementInVal;
//               allData.add(textElement);
//               i++;
//             } else {
//               textElement += elementInVal;
//               allData.add(textElement);
//               textElement = '';
//               i++;
//             }
//           }
//         });
//       });

//       uniqueText =
//           allData.where((numone) => seenint.add(numone.toString())).toList();

//       List<String> _uniqueText = uniqueText;
//       allData = [];
//       uniqueText = [];
//       _uniqueText.forEach((element) {
//         if (element.allMatches(str).length > 1) {
//           uniqueText.add(element);
//         }
//       });

//       for (var i = 0; i < uniqueText.length; i++) {
//         if (checkLengthValue < uniqueText[i].length) {
//           checkLengthValue = uniqueText[i].length;
//           allData = [];
//           allData.add(uniqueText[i]);
//         } else if (checkLengthValue == uniqueText[i].length) {
//           allData.add(uniqueText[i]);
//         }
//       }

//       if (allData.length > 1) {
//         for (var i = 0; i < allData.length; i++) {
//           if (allData[i].allMatches(str).length > count) {
//             count = allData[i].allMatches(str).length;
//             result = allData[i];
//           }
//         }
//       } else
//         result = allData[0];

//       if (result.length * result.allMatches(str).length != str.length) {
//         result = '-1';
//       }
//     } catch (e) {
//       result = '-1';
//     }

//     return result;
//   }

//   int ArrayChallenge(List<int> arr) {
//     // code goes here
// // int getLenght = arr.lenght;
//     List<int> listData = [];
//     int sum = 0;
//     int sumList = 0;
//     int sumtolListMax = 0;
//     bool checkSts = false;
//     List tttt = [-2, 3, -5, 6, -3, -1, 11, -8, 24];

//     for (int i = 0; i < arr.length; i++) {
//       if (i != arr.length) {
//         print(arr[i]);
//         if (sumList == 0 || checkSts) {
//           if ((sum + arr[i]) > sum) {
//             if (checkSts) sum = 0;
//             sum = sum + arr[i];
//             print('sum == $sum');
//             listData.add(sum);
//             sumList = 0;
//             sumtolListMax = 0;
//           } else {
//             if ((sum + arr[i]) > 0) {
//               sumList = (sum + arr[i]);
//               print('sumList1 == $sumList');
//             } else {
//               sum = 0;
//               sumList = 0;
//               sumtolListMax = 0;
//               print('else sum');
//             }
//           }
//         } else {
//           if ((sumList + arr[i]) > sumList) {
//             sumList = sumList + arr[i];
//             sumtolListMax = sumList;
//             print('sumtolListMax == $sumList');
//           } else {
//             if ((sumList + arr[i]) > 0) {
//               sumList = (sumList + arr[i]);
//               print('sumList2 == $sumList');
//             } else {
//               checkSts = true;
//               print('checktrue');
//             }
//           }
//         }
//       }
//     }
//     listData.addAll(arr);
//     listData.add(sumtolListMax);
//     listData.add(7);
//     int total = listData.reduce(max);
//     print('total = $total');

//     try {} catch (e) {}

//     return sum;
//   }

  changeStsSelect(bool sts, int index, String flag) {
    if (flag == 'package') {
      sts
          ? listPackage[index]["select_status"] = "1"
          : listPackage[index]["select_status"] = "0";
    } else if (flag == 'country') {
      sts
          ? listCountryModel[index]["select_status"] = "1"
          : listCountryModel[index]["select_status"] = "0";
    }

    notifyListeners();
  }

  isSelectAddress(bool sts) {
    selectAddress = sts;
    notifyListeners();
  }

  changeStatusSelect(int? status) {
    grouRadio = status!;
    print(status == 0 ? "ใช่" : "ไม่ใช่");
    notifyListeners();
  }

  actionSubmit() {
    print('accoutNumBerContrl.text  = ${ageContrl.text}');
  }
}
