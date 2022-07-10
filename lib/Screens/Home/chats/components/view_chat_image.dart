import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ViewChatImage extends StatelessWidget {
  const ViewChatImage({Key? key, required this.imageUrl}) : super(key: key);
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        child: Center(
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.fitWidth,
          ),
        ),
      )),
    );
  }
}
