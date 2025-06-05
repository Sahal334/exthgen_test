import 'package:flutter/material.dart';

BoxDecoration customGradientButtonDecoration() {
  return BoxDecoration(
    gradient: const LinearGradient(
      colors: [Color(0xFFD5E660), Color(0xFFE8B4FD)],
    ),
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
    ],
  );
}
