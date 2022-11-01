import 'package:flutter/material.dart';
import 'package:/model/FromJSON/ChatArgumentModel.dart';
import 'package:/utils/Constants.dart';
// import 'package:food_ordering_store_dev/widgets/constant_value.dart';

import 'package:intl/intl.dart';

class ChatUI extends StatefulWidget {
  ChatUI(
      {Key? key, this.messages, this.idUser, this.textstyle, this.colorBoxChat})
      : super(key: key);
  final List? messages;
  final String? idUser;
  final TextStyle? textstyle;
  final Color? colorBoxChat;

  @override
  _ChatUIState createState() => _ChatUIState();
}

class _ChatUIState extends State<ChatUI> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: ScrollController(),
      reverse: true,
      itemCount: widget.messages!.length,
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 10, bottom: 10),
      //physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        ChatArgumentModel _argumentModel =
            ChatArgumentModel.fromJson(widget.messages![index]);

        Constants().printColorMagenta(
            '||||| CHAT UI::_argumentModel.senderId | ${_argumentModel.senderId} |||||');

        Constants().printColorMagenta(
            '||||| CHAT UI::widget.idUser | ${widget.idUser} |||||');

        return Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
          child: _argumentModel.senderId != "${widget.idUser}"
              ? SendMessageBubble(
                  messagesDataRead: _argumentModel.read,
                  message: _argumentModel.message,
                  time: "${DateFormat('hh:mm a').format(
                    DateTime.fromMillisecondsSinceEpoch(
                        _argumentModel.receivedTime!
                        //widget.messages![index]['data']['received_time'],
                        ),
                  )}",
                  //"${DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(widget.messages![index]['data']['received_time']))}",
                )
              : ReceivedMessageBubble(
                  message: _argumentModel
                      .message, //widget.messages![index]['data']['message'],
                  time: "${DateFormat('hh:mm a').format(
                    DateTime.fromMillisecondsSinceEpoch(
                        _argumentModel.receivedTime!
                        //widget.messages![index]['data']['received_time'],
                        ),
                  )}",
                ),
        );
      },
    );
  }
}

TextStyle fontStyleChatUi({double? fontSize, Color? colorValue}) {
  fontSize ??= 15;
  colorValue ??= Colors.black;
  return TextStyle(
      fontFamily: 'THSarabun',
      fontSize: fontSize,
      color: colorValue,
      fontWeight: FontWeight.normal);
}

class SendMessageBubble extends StatelessWidget {
  final String? message;
  final String? time;
  final bool? messagesDataRead;

  const SendMessageBubble({
    Key? key,
    this.message,
    this.time,
    this.messagesDataRead,
  })  : assert(message != null),
        assert(time != null),
        assert(messagesDataRead != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxBubbleWidth = constraints.maxWidth * 0.7;
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(time!,
                style:
                    fontStyleChatUi(fontSize: 10.0, colorValue: Colors.black54)
                // TextStyle(
                //   color: Colors.black54,
                //   fontSize: 10.0,
                // ),
                ),
            Align(
              alignment: Alignment.centerRight,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxBubbleWidth),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFFEBC18),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                      bottomLeft: Radius.circular(15.0),
                      bottomRight: Radius.circular(0.0),
                    ),
                  ),
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(10.0),
                  child: IntrinsicWidth(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(message!,
                            style: fontStyleChatUi(
                                fontSize: 15.0, colorValue: Colors.black54)),
                        const SizedBox(height: 5.0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            messagesDataRead == true
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/double_check.png',
                      height: 10,
                      width: 10,
                      fit: BoxFit.fill,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Icon(
                      Icons.access_time,
                      color: Color(0xFFFEBC18),
                      size: 15,
                    ),
                  ),
          ],
        );
      },
    );
  }
}

class ReceivedMessageBubble extends StatelessWidget {
  final String? message;
  final String? time;

  const ReceivedMessageBubble({
    Key? key,
    this.message,
    this.time,
  })  : assert(message != null),
        assert(time != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxBubbleWidth = constraints.maxWidth * 0.7;
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: maxBubbleWidth,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                      bottomLeft: Radius.circular(0.0),
                      bottomRight: Radius.circular(15.0),
                    ),
                  ),
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(10.0),
                  child: IntrinsicWidth(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(message!,
                            style: fontStyleChatUi(
                                fontSize: 15.0, colorValue: Colors.black54)),
                        const SizedBox(height: 5.0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Text(time!,
                style: fontStyleChatUi(
                    fontSize: 13.0, colorValue: Colors.black54)),
          ],
        );
      },
    );
  }
}
