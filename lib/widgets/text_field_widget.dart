import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldWidget extends StatelessWidget {
  final void Function(String data) update;
  final TextEditingController controller;
  final Widget suffixIcon;
  final TextInputType textInputType;
  final int maxLength;
  final String hint;
  final Widget Function(BuildContext,
      {int currentLength, bool isFocused, int maxLength}) buildCounter;
  final bool maxLengthEnforced;
  final bool showBuildCounter;
  const TextFieldWidget(
      {Key key,
      this.update,
      this.suffixIcon,
      this.hint,
      this.textInputType,
      this.maxLength,
      this.maxLengthEnforced,
      this.showBuildCounter,
      this.buildCounter,
      this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      child: TextField(
        key: key,
        controller: controller,
        onChanged: update,
        maxLength: maxLength ?? null,
        maxLengthEnforced: maxLengthEnforced ?? false,
        buildCounter: buildCounter,
        keyboardType: textInputType ?? TextInputType.name,
        enableSuggestions: false,
        decoration: InputDecoration(
          hintStyle: GoogleFonts.aBeeZee().copyWith(color: Colors.grey),
          hintText: hint,
          prefixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
        ),
      ),
    );
  }
}
