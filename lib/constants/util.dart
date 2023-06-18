import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String message,
    [bool? value = true]) {
  Color color =
  value == true ? Colors.green : Colors.orange;
  final snackBar = SnackBar(
    margin: const EdgeInsets.all(20),
    shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        side: BorderSide(color: color, width: 1)),
    content: Row(
      children: [
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          child: Center(
              child: Icon(
                value == true ? Icons.check : Icons.close,
                color: Colors.white,
                size: 15,
              )),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            message,
            style: TextStyle(color: color, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    ),
    duration: const Duration(seconds: 2),
    backgroundColor: Colors.black,
    behavior: SnackBarBehavior.floating,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}