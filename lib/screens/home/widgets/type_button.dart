import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/widgets/custom_button_type.dart';

class TypeButton extends StatefulWidget {
  final List typeList;

  const TypeButton({
    super.key,
    required this.typeList,
  });

  @override
  State<TypeButton> createState() => _TypeButtonState();
}

class _TypeButtonState extends State<TypeButton> {
  int randomColor = 0;

  colorTypeBackGround() {
    switch (randomColor) {
      case 0:
        randomColor = 1;
        return const Color(0xFFF1AFB2);
      case 1:
        randomColor = 2;
        return const Color(0xFF49D0B0);
      case 2:
        randomColor = 3;
        return const Color(0xFF9E81A9);
      case 3:
        randomColor = 4;
        return const Color(0xFF2E7885);
      case 4:
        randomColor = 0;
        return const Color(0xFF000000);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tipo',
          style: GoogleFonts.nunito(
              textStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Theme.of(context).primaryColor)),
        ),
        SizedBox(
          height: 30,
          width: double.infinity,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: widget.typeList.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    ButtonType(
                        name: widget.typeList[index]['name'],
                        color: colorTypeBackGround()),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                );
              }),
        )
      ],
    );
  }
}
