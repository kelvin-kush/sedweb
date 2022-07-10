import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sedweb/components/constraints.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: profileImage == ""
                ? Container(
                   height: 50,
                    width: 50,
                    color: Colors.blue,
                  )
                : CachedNetworkImage(
                    imageUrl: profileImage,
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                     progressIndicatorBuilder: (context, url,progess) {
                        return  ColoredBox(
                            color: Colors.white24,
                            child:Center(
                              child: CircularProgressIndicator(
                                color: kPrimaryColor,
                                value: progess.progress,
                              ),
                            ));
                      },
                    errorWidget: (context, error, url) {
                      return const Icon(
                        Icons.error,
                        color: Colors.red,
                        size: 25,
                      );
                    },
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
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 18),
                ),
                Text(
                  info,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
