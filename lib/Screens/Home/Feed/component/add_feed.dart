import 'package:flutter/material.dart';
import 'package:sedweb/Screens/Home/Feed/add_new_feed/new_feed.dart';
import 'package:sedweb/components/constraints.dart';

class AddFeed extends StatelessWidget {
  final bool isFromArticles;
  const AddFeed({Key? key, this.isFromArticles = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => AddNewFeed(
                      isFromArticles: isFromArticles,
                    ))));
      },
      child: Card(
          color: const Color(0xFFF4F4F4),
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.person),
              ),
              title: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(35),
                    border: Border.all(color: const Color(0xFF444444))),
                child: const Text('Share your ideas'),
              ),
              trailing: const Icon(
                Icons.image,
                color: Colors.lightGreen,
              ),
            ),
          )),
    );
  }
}
