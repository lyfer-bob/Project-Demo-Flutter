import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:/utils/Constants.dart';

class NoticDetail extends StatefulWidget {
  const NoticDetail({Key? key}) : super(key: key);

  @override
  _NoticDetailState createState() => _NoticDetailState();
}

class _NoticDetailState extends State<NoticDetail> {
  @override
  Widget build(BuildContext context) {
    final NoticDetailValues? values =
        ModalRoute.of(context)!.settings.arguments as NoticDetailValues?;

    print(values!.subject);

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              Navigator.pop(context);
              // mainPageProviderValue.setStackContextName('home');
            },
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Color(0xFF3D525C), //change your color here
          ),
          shadowColor: Color(0x29000000),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.95,
                height: MediaQuery.of(context).size.height * 0.632,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x29000000),
                      offset: Offset(0, 3),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                        color: Color(0xFF3D525C),
                      ),
                      child: Center(
                        child: Text(
                          values.subject.toString(),
                          style: Constants().textStyleBold(
                              fontSize: 22.0, colorValue: Colors.white),
                        ),
                      ),
                    ),
                    Divider(
                      height: 2,
                      color: Colors.grey,
                    ),
                    Html(
                      data: values.content.toString(),
                      style: {
                        "body": Style(
                          fontSize: FontSize(20.0),
                          fontWeight: FontWeight.bold,
                        ),
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        )

        //Text(values.content.toString()),
        );
  }
}

class NoticDetailValues {
  final String? subject;
  final String? content;

  NoticDetailValues(this.subject, this.content);
}
