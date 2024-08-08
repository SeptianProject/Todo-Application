import 'package:flutter/material.dart';

class QButton extends StatefulWidget {
  final void Function()? onPressed;
  final Widget child;
  final Color? color;
  const QButton({
    super.key,
    this.color,
    required this.onPressed,
    required this.child,
  });

  @override
  State<QButton> createState() => _QButtonState();
}

class _QButtonState extends State<QButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.color,
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: widget.child);
  }
}
