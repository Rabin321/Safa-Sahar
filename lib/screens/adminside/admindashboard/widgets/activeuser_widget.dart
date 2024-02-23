import 'package:flutter/material.dart';

Widget buildActiveUsersWidget(String activeUsersText, int totalUsers) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Container(
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              activeUsersText,
              style: const TextStyle(
                color: Color(0xFF003E1F),
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "TOTAL: $totalUsers",
              style: const TextStyle(
                color: Color(0xFF003E1F),
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    ),
  );
}
