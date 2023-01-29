import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'model.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Room> room = [];

  @override
  void initState() {
    _getFileData('assets/input.txt').then((value) => _gpsHelper(value));

    super.initState();
  }

  Future<String> _getFileData(String path) async {
    // get root bundle
    return await rootBundle.loadString(path);
  }

  void _gpsHelper(String text) {
    // get data text and convert to line
    LineSplitter ls = const LineSplitter();
    List<String> masForUsing = ls.convert(text);

    // for each  data
    masForUsing.forEach(_checkCaseAction);
  }

  _checkCaseAction(String data) {
    List<String> value = data.split(' ');

    // print(data);
    if (value.length > 4) {
      debugPrint("error data format");
    } else {
      // check case action
      switch (value[0]) {
        case 'create_hotel':
          _createFunc(value[1], value[2]);
          break;
        case 'book':
          _bookFunc(value[1], value[2], value[3]);
          break;
        case 'list_available_rooms':
          _availableRoomsFunc();
          break;
        case 'checkout':
          _checkoutFunc(value[1], value[2]);
          break;
        case 'list_guest':
          _listGuestFucn();
          break;
        case 'get_guest_in_room':
          _getGuestInRoomFunc(value[1]);
          break;
        case 'list_guest_by_age':
          _listGuestByAgeFunc(value[1], value[2]);
          break;
        case 'list_guest_by_floor':
          _listGuestByFloorFunc(value[1]);
          break;
        case 'checkout_guest_by_floor':
          _checkoutGuestByFloorFunc(value[1]);
          break;
        case 'book_by_floor':
          _bookByFloorFunc(value[1], value[2], value[3]);
          break;
        default:
          debugPrint('Cannot do action ${value[0]}');
      }
    }
  }

  void _createFunc(String floor, String roomNumber) {
    if (int.parse(floor) > 9) {
      debugPrint('Sorry, floor can max 9');
      floor = '9';
    }

    for (var i = 0; i < int.parse(floor); i++) {
      for (var j = 0; j < int.parse(roomNumber); j++) {
        room.add(Room(roomNumb: '${i + 1}${j >= 10 ? j : "0${j + 1}"}'));
      }
    }
    debugPrint(
        'Hotel created with $floor floor(s), $roomNumber room(s) per floor.');
  }

  void _bookFunc(String roomNumb, String custName, String age,
      {bool? bookByFloor = false}) {
    // check room in hotel
    var contain = room.where((element) => element.roomNumb == roomNumb);
    if (contain.isEmpty) {
      debugPrint("Can't book room $roomNumb because don't have this room");
    } else {
      int indexRoom =
          room.indexWhere((element) => element.roomNumb == roomNumb);

      if (room[indexRoom].isBook != true) {
        // set data when can book
        room[indexRoom].isBook = true;
        room[indexRoom].custName = custName;
        room[indexRoom].custAge = int.parse(age);
        room[indexRoom].checkOut = false;

        List<String> keyRoomBook = [];

        // check keyCard the reserved room
        for (var element in room) {
          if (element.isBook == true &&
              element.roomNumb != room[indexRoom].roomNumb) {
            keyRoomBook.add(element.keyCard!);
          }
        }

        //set keyCard
        if (keyRoomBook.isEmpty) {
          room[indexRoom].keyCard = '1';
        } else {
          // i start 1 cause set defaul isEmpty = 1
          for (var i = 1; i < keyRoomBook.length + 1; i++) {
            if (!keyRoomBook.contains('${i + 1}')) {
              room[indexRoom].keyCard = '${i + 1}';
              break;
            }
          }
        }
        if (!bookByFloor!) {
          debugPrint(
              'Room $roomNumb is booked by ${room[indexRoom].custName} with keycard number ${room[indexRoom].keyCard}.');
        }
      } else {
        debugPrint(
            "Cannot book room $roomNumb for $custName, The room is currently booked by ${room[indexRoom].custName}.");
      }
    }
  }

  void _availableRoomsFunc() {
    String result = '';
    //check room avaiable
    for (var i = 0; i < room.length; i++) {
      if (room[i].isBook != true) {
        if (result == '') {
          result = room[i].roomNumb!;
        } else {
          result = '$result,${room[i].roomNumb}';
        }
      }
    }
    result == '' ? debugPrint("fully booked") : debugPrint(result);
  }

  void _checkoutFunc(String keycard, String custName,
      {bool? checkOutbyFloor = false}) {
    List<String> keyAll = [];
    List<String> custAll = [];

    for (var element in room) {
      if (element.isBook == true) {
        // add element isbook in list keys and custs
        keyAll.add(element.keyCard!);
        custAll.add(element.custName!);
      }
    }
    bool keyError = !keyAll.contains(keycard);
    bool custError = !custAll.contains(custName);

    if (!keyError && !custError) {
      int indexRoom = room.indexWhere((element) => element.keyCard == keycard);
      if (room[indexRoom].custName == custName) {
        // reset booking when check out success
        room[indexRoom].isBook = null;
        room[indexRoom].custName = null;
        room[indexRoom].custAge = null;
        room[indexRoom].keyCard = null;
        room[indexRoom].checkOut = true;

        if (!checkOutbyFloor!) {
          debugPrint('Room ${room[indexRoom].roomNumb} is checkout.');
        }
      } else {
        debugPrint(
            'Only ${room[indexRoom].custName} can checkout with keycard number ${room[indexRoom].keyCard}.');
      }
    } else {
      debugPrint('keycard or customername incorrect');
    }
  }

  void _listGuestFucn() {
    String result = '';
    // check guest  booking
    for (var i = 0; i < room.length; i++) {
      if (room[i].isBook == true) {
        if (result == '') {
          result = room[i].custName!;
        } else {
          if (!result.contains(room[i].custName!)) {
            result = '$result,${room[i].custName}';
          }
        }
      }
    }
    result == '' ? debugPrint("don't have guest") : debugPrint(result);
  }

  void _getGuestInRoomFunc(String roomnNumb) {
    int indexRoom = room.indexWhere((element) => element.roomNumb == roomnNumb);
    debugPrint(room[indexRoom].custName);
  }

  void _listGuestByAgeFunc(String operation, String age) {
    String result = '';

    for (var element in room) {
      if (element.isBook == true) {
        bool condision = true;
        // operation case
        switch (operation) {
          case '<':
            condision = element.custAge! < int.parse(age);
            break;
          case '<=':
            condision = element.custAge! <= int.parse(age);
            break;
          case '>':
            condision = element.custAge! > int.parse(age);
            break;
          case '>=':
            condision = element.custAge! >= int.parse(age);
            break;
          case '==':
            condision = element.custAge! == int.parse(age);
            break;
          case '=':
            condision = element.custAge! == int.parse(age);
            break;
          case '!=':
            condision = element.custAge! != int.parse(age);
            break;
          default:
            debugPrint('Cannot do from $operation');
        }

        if (condision) {
          if (result == '') {
            result = element.custName!;
          } else {
            if (!result.contains(element.custName!)) {
              result = '$result,${element.custName}';
            }
          }
        }
      }
    }
    result == ''
        ? debugPrint("Don't have guest age $operation $age")
        : debugPrint(result);
  }

  void _listGuestByFloorFunc(String floor) {
    // check guest on floor
    String result = '';

    for (var element in room) {
      if (element.isBook == true) {
        if (element.roomNumb![0] == floor) {
          if (result == '') {
            result = element.custName!;
          } else {
            result = '$result,${element.custName}';
          }
        }
      }
    }

    result == ''
        ? debugPrint("Don't have guest on floor $floor")
        : debugPrint(result);
  }

  void _checkoutGuestByFloorFunc(String floor) {
    // check out by floor

    String roomPrint = '';

    for (var element in room) {
      if (element.roomNumb![0] == floor) {
        if (element.isBook == true) {
          int indexRoom =
              room.indexWhere((value) => value.keyCard == element.keyCard);
          if (roomPrint == '') {
            roomPrint = room[indexRoom].roomNumb!;
          } else {
            roomPrint = '$roomPrint, ${room[indexRoom].roomNumb!}';
          }
          _checkoutFunc(element.keyCard!, element.custName!,
              checkOutbyFloor: true);
        }
      }
    }
    debugPrint('Room $roomPrint are checkout.');
  }

  void _bookByFloorFunc(String floor, String custName, String custAge) {
    // book by floor
    bool isBookFloor = true;

    for (var element in room) {
      if (element.roomNumb![0] == floor) {
        if (element.isBook == true) {
          isBookFloor = false;
        }
      }
    }

    if (!isBookFloor) {
      debugPrint('Cannot book floor $floor for $custName.');
    } else {
      String roomPrint = '';
      String keyCardPrint = '';
      for (var element in room) {
        if (element.roomNumb![0] == floor) {
          _bookFunc(element.roomNumb!, custName, custAge, bookByFloor: true);
        }
      }

      for (var element in room) {
        if (element.roomNumb![0] == floor) {
          if (roomPrint == '') {
            roomPrint = element.roomNumb!;
          } else {
            roomPrint = '$roomPrint, ${element.roomNumb!}';
          }

          if (keyCardPrint == '') {
            keyCardPrint = element.keyCard!;
          } else {
            keyCardPrint = '$keyCardPrint, ${element.keyCard!}';
          }
        }
      }
      debugPrint(
          'Room $roomPrint are booked with keycard number $keyCardPrint');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
            widthFactor: MediaQuery.of(context).size.width,
            heightFactor: MediaQuery.of(context).size.height,
            child: const Text(
              'Hi there',
              style: TextStyle(fontSize: 30),
            ),
          )),
    );
  }
}
