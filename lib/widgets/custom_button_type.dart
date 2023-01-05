import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonType extends StatefulWidget {
  final String name;
  final Color color;

  const ButtonType({super.key, required this.name, required this.color});

  @override
  State<ButtonType> createState() => _ButtonTypeState();
}

class _ButtonTypeState extends State<ButtonType> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 80,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Text(
          widget.name,
          style: GoogleFonts.nunito(
              textStyle: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Colors.white)),
        ),
      ),
    );
  }
}
