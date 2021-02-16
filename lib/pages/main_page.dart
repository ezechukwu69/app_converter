import 'package:app_converter/controller/main_page_controller.dart';
import 'package:app_converter/widgets/text_field_widget.dart';
import 'package:app_converter/widgets/total_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MainPageController controller;

  @override
  void initState() {
    super.initState();
    controller = MainPageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ...controller.streams
                  .asMap()
                  .entries
                  .map((e) => Column(
                        children: [
                          TextFieldWidget(
                            key: ValueKey("title"),
                            update: (data) {
                              if (data.length <= 25) {
                                e.value.titleSink(data);
                              }
                            },
                            showBuildCounter: true,
                            suffixIcon: Icon(
                              CupertinoIcons.app_fill,
                              size: 30,
                            ),
                            hint: "Title",
                            maxLengthEnforced: true,
                            buildCounter: (context,
                                    {currentLength, isFocused, maxLength}) =>
                                Visibility(
                                    visible: isFocused,
                                    child: Text('$currentLength of $maxLength',
                                        style: GoogleFonts.aBeeZee())),
                            maxLength: 22,
                          ),
                          TextFieldWidget(
                            key: ValueKey("price"),
                            update: (data) {
                              if (data.isNotEmpty) {
                                e.value.priceSink(double.tryParse(data));
                              } else {
                                e.value.priceSink(0);
                              }
                            },
                            hint: "Price",
                            textInputType: TextInputType.number,
                            suffixIcon: Icon(
                              CupertinoIcons.money_dollar,
                              size: 30,
                            ),
                          ),
                          TextFieldWidget(
                            key: ValueKey("discount"),
                            update: (data) {
                              if (data.isNotEmpty) {
                                e.value.discountSink(double.tryParse(data));
                              } else {
                                e.value.discountSink(0);
                              }
                            },
                            hint: "Discount",
                            textInputType: TextInputType.number,
                            suffixIcon: Icon(
                              CupertinoIcons.percent,
                              size: 20,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  setState(() {
                                    controller.streams.removeAt(e.key);
                                  });
                                },
                              ),
                            ],
                          ),
                          Divider()
                        ],
                      ))
                  .toList(),
              IconButton(
                icon: Icon(
                  Icons.add_circle,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    controller.streams.add(CustomStreamHandler());
                  });
                },
              ),
              StreamBuilder<double>(
                  stream: controller.totalStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return TotalWidget(
                        total: snapshot.data.toString(),
                      );
                    } else {
                      return TotalWidget(
                        total: '0.0',
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
