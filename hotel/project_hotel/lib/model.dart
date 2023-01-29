class HotelModel {
  String action;
  List<Room> room;
  String addressId;
  String id;
  String latitude;
  String longitude;
  HotelModel(
      {required this.action,
      required this.room,
      required this.addressId,
      required this.id,
      required this.latitude,
      required this.longitude});
}

class Room {
  String? roomNumb;
  String? custName;
  int? custAge;
  String? keyCard;
  bool? isBook;
  bool? checkOut;
  Room({
    this.roomNumb,
    this.custName,
    this.custAge,
    this.keyCard,
    this.isBook,
    this.checkOut,
  });
}
