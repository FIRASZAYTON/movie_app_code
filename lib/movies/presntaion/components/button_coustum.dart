import 'package:flutter/material.dart';

Widget elevatedButton(
    {required bool isLogin,
    required BuildContext context,
    required VoidCallback ontap}) {
  return Container(
    
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: TextButton(
        child: Text(
          isLogin ? "LOG IN" : "SIGN OUT",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        style: ButtonStyle(
          shadowColor: MaterialStateProperty.all(Colors.grey),
          elevation: MaterialStateProperty.all(5),
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.grey;
            } else {
              return Colors.grey.withOpacity(0.9);
            }
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        ),
        onPressed: () {
          ontap;
        }),
  );
}
