import 'package:flutter/material.dart';

class RowDivider extends StatelessWidget {
  const RowDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(width: 20),
        Container(
          color: const Color(0xff444444),
          height: 1,
          width: 70,
        ),
        const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text('Atau lanjutkan dengan')),
        Container(color: const Color(0xff444444), height: 1, width: 70),
        const SizedBox(width: 20),
      ],
    );
  }
}
