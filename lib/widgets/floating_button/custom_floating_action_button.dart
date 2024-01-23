import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final Function onPressed;
  final IconData icon;

  CustomFloatingActionButton({required this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56.0,
      height: 56.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: FloatingActionButton(
        onPressed: () => onPressed(),
        child: Icon(icon),
      ),
    );
  }
}
