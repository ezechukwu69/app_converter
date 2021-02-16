import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TotalWidget extends StatelessWidget {
  final String title;
  final String total;
  final TextStyle style1 =
      GoogleFonts.aBeeZee().copyWith(color: Colors.white, fontSize: 16);
  final TextStyle style2 =
      GoogleFonts.aBeeZee().copyWith(color: Colors.white, fontSize: 20);
  TotalWidget({Key key, this.title, this.total}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Total", style: style2),
          Row(
            children: [
              Text(
                title.isNotEmpty ? title + " - " : "Title - ",
                style: style1,
              ),
              Text(
                total,
                style: style1,
              )
            ],
          )
        ],
      ),
    );
  }
}
