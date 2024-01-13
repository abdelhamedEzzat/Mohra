import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message,
    {Duration? duration, Color? backgroundcolor}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: backgroundcolor ?? Colors.black.withOpacity(0.7),
      duration: duration ?? const Duration(seconds: 4),
      content: Text(message),
    ),
  );
}
