import 'package:flutter/material.dart';

ListTile weatherDataList(
    {required IconData icon,
    required String title,
    required String subtitle,
    required Color color}) {
  return ListTile(
    leading: Icon(
      icon,
      color: color,
    ),
    title: Text(
      title,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
    ),
    subtitle: Text(
      subtitle,
      style: TextStyle(fontSize: 16),
    ),
  );
}
