import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sedweb/Screens/Home/profile/full_picture_view.dart';
import 'package:sedweb/components/constraints.dart';
import 'package:sedweb/models/post_model.dart';

class PictureBox extends StatelessWidget {
  const PictureBox({Key? key, required this.post}) : super(key: key);
  final PostModel post;

  @override
  Widget build(BuildContext context) {
    const Color kBorderColor = Color(0xFFcccccc);
    double width = MediaQuery.of(context).size.width;
    return ClipRRect(
      child: Container(
        width: width * 0.205,
        height: width * 0.205,
        color: kBorderColor,
        child: TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>  PictureDetails(image:post.image!)));
          },
          child: post.image!.isNotEmpty
              ? CachedNetworkImage(
                  imageUrl: post.image!,
                  width: width * 0.205,
                  height: width * 0.205,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, progess) {
                    return ColoredBox(
                        color: kBorderColor.withOpacity(0.5),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: kPrimaryColor,
                            value: progess.progress,
                          ),
                        ));
                  },
                )
              : const SizedBox(child: Icon(Icons.text_format,color: Colors.black,),),
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
        ),
      ),
    );
  }
}
