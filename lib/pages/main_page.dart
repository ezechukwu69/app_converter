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
  TextEditingController titleController;

  @override
  void initState() {
    super.initState();
    controller = MainPageController();
    titleController = TextEditingController();
    controller.titleSink("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFieldWidget(
                controller: titleController,
                update: (data) {
                  if (data.length <= 25) {
                    controller.titleSink(data);
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
                        child: Text('$currentLength of $maxLength')),
                maxLength: 22,
              ),
              TextFieldWidget(
                update: (data) {
                  if (data.isNotEmpty) {
                    controller.priceSink(double.tryParse(data));
                  } else {
                    controller.priceSink(0);
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
                update: (data) {
                  if (data.isNotEmpty) {
                    controller.discountSink(double.tryParse(data));
                  } else {
                    controller.discountSink(0);
                  }
                },
                hint: "Discount",
                textInputType: TextInputType.number,
                suffixIcon: Icon(
                  CupertinoIcons.percent,
                  size: 20,
                ),
              ),
              StreamBuilder<List<dynamic>>(
                  stream: controller.totalStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return TotalWidget(
                        title: snapshot.data[1],
                        total: snapshot.data[0].toString(),
                      );
                    } else {
                      return TotalWidget(
                        title: "Title",
                        total: '0.0',
                      );
                    }
                    return Container();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
