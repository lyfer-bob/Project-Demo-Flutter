import 'package:flutter/material.dart';
import 'package:/screen/chat/ChatUI.dart';
import 'package:/screen/chat/providers/ChatArgument_provider.dart';
import 'package:/utils/Constants.dart';
import 'package:provider/provider.dart';

class ChatRoomPage extends StatefulWidget {
  const ChatRoomPage({Key? key}) : super(key: key);

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  TextEditingController text = TextEditingController();

  @override
  void initState() {
    super.initState();

    Provider.of<ChatArgumentProvider>(context, listen: false)
        .setOpenChatRoom(true);

    Provider.of<ChatArgumentProvider>(context, listen: false)
        .setHaveChatNotic(false);

    Provider.of<ChatArgumentProvider>(context, listen: false)
        .fetchFirebaseChat();

    Provider.of<ChatArgumentProvider>(context, listen: false).fetchReadChat();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatArgumentProvider>(
      builder: (BuildContext context, chatArgumentValue, Widget? child) =>
          WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () {
                chatArgumentValue.setHaveChatNotic(false);

                chatArgumentValue.setOpenChatRoom(false);

                chatArgumentValue.clearChatMessageList();

                Navigator.pop(context);
              },
            ),
            backgroundColor: Constants.themeColor,
            title:
                Text(chatArgumentValue.messageRecipientByAppAppBar.toString()),
          ),
          body: Column(
            children: [
              Expanded(
                flex: 9,
                child: StreamBuilder(
                  stream: chatArgumentValue.chatRef,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (!snapshot.hasData ||
                        snapshot.data!.snapshot.value == null)
                      return Center(
                        child: Text('ยังไม่มีข้อมูล'),
                      );

                    return Container(
                      height: MediaQuery.of(context).size.height * 0.9,
                      child: ChatUI(
                        messages: chatArgumentValue.chatMessages,
                        idUser:
                            '${chatArgumentValue.messageRecipientByApp}_${chatArgumentValue.noticDataList[1]}',
                        // textstyle: widget.textstyle,
                        // colorBoxChat: widget.colorBoxChat,
                      ),
                    );
                  },
                ),
              ),
              Divider(thickness: 1),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  // height:100,
                  child: TextField(
                    controller: text,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      hintText: 'กรุณาใส่ข้อความ',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          chatArgumentValue
                              .sendFirebaseChat(text.text.toString());

                          text.clear();
                          text = TextEditingController();
                          setState(() {});
                        },
                        icon: Icon(
                          Icons.send,
                          color: Color(0xFFFEBC18),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
