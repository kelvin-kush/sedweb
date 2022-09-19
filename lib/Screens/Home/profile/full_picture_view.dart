import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PictureDetails extends StatelessWidget {
  const PictureDetails({Key? key,required this.image}) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Stack(
              children: [
                Align(
                    child: SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height ,
                  child: CachedNetworkImage(
                    imageUrl:image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    placeholder: (context, url) {
                      return const Icon(
                        Icons.image,
                        size: 60,
                      );
                    },
                    errorWidget: (context, error, url) {
                      return const Icon(
                        Icons.image,
                        color: Colors.red,
                        size: 50,
                      );
                    },
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
