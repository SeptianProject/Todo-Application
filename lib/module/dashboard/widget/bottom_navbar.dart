import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavbar extends StatefulWidget {
  final Function? onZero;
  final Function? onFirst;
  final int selectedIndex;
  const BottomNavbar({
    super.key,
    this.onZero,
    this.onFirst,
    required this.selectedIndex,
  });

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: GNav(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          selectedIndex: widget.selectedIndex,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          tabMargin: const EdgeInsets.symmetric(horizontal: 30),
          color: const Color(0xff444444).withOpacity(0.3),
          rippleColor: Colors.white,
          activeColor: const Color(0xfffefefe),
          tabBackgroundColor: const Color(0xff5A7BFA),
          gap: 10,
          curve: Curves.easeInOut,
          style: GnavStyle.google,
          duration: const Duration(milliseconds: 800),
          tabs: [
            GButton(
              icon: Icons.notes,
              text: 'Toodo List',
              onPressed: widget.onZero,
            ),
            GButton(
              text: 'Dashboard',
              icon: Icons.dashboard,
              onPressed: widget.onFirst,
            )
          ]),
    );
  }
}
