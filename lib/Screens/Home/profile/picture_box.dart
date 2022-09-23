import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sedweb/Screens/Home/Feed/feed_details.dart';
import 'package:sedweb/Screens/Home/profile/full_picture_view.dart';
import 'package:sedweb/components/constraints.dart';
import 'package:sedweb/models/post_model.dart';
import 'package:sedweb/models/user_model.dart';

class PictureBox extends StatelessWidget {
  const PictureBox({Key? key, required this.post,required this.user}) : super(key: key);
  final PostModel post;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    const Color kBorderColor = Color(0xFFcccccc);
    double width = MediaQuery.of(context).size.width;
    return ClipRRect(
      child: Container(
        width: width * 0.3,
        height: width * 0.3,
        color: kBorderColor,
        child: TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FeedDetails(postModel: post, user: user)));
          },
          child: post.image!.isNotEmpty
              ? CachedNetworkImage(
                  imageUrl: post.image!,
                  width: width * 0.3,
                  height: width * 0.3,
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
              : const SizedBox(
                  child: Icon(
                    Icons.text_format,
                    color: Colors.black,
                  ),
                ),
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
        ),
      ),
    );
  }
}
