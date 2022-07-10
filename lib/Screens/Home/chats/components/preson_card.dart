import 'package:flutter/material.dart';

Widget personCard({
  required String profileImage,
  required String name,
  required String info,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Color.fromARGB(64, 255, 255, 255)))),
      width: double.infinity,
      height: 70,

      // color: Colors.blue,
      padding:const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child:profileImage==""?Container(color: Colors.blue,): Image.network(
              profileImage,
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
          ),
         const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style:const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
                Text(
                  info,
                  style:const TextStyle(fontSize: 14),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
