/// read : false
/// receiver_id : "rider_36"
/// received_time : 1646665279360
/// message : "gangster"
/// sender_id : "restaurant_12"

class ChatArgumentModel {
  ChatArgumentModel({
      this.read, 
      this.receiverId, 
      this.receivedTime, 
      this.message, 
      this.senderId,});

  ChatArgumentModel.fromJson(dynamic json) {
    read = json['read'];
    receiverId = json['receiver_id'];
    receivedTime = json['received_time'];
    message = json['message'];
    senderId = json['sender_id'];
  }
  bool? read;
  String? receiverId;
  int? receivedTime;
  String? message;
  String? senderId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['read'] = read;
    map['receiver_id'] = receiverId;
    map['received_time'] = receivedTime;
    map['message'] = message;
    map['sender_id'] = senderId;
    return map;
  }

}