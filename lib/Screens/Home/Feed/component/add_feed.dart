import 'package:flutter/material.dart';
import 'package:sedweb/components/constraints.dart';

class AddFeed extends StatelessWidget {
  const AddFeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Color(0xFFF4F4F4),
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.person),
            ),
            title: TextFormField(
              maxLines: 1,
              decoration: InputDecoration(
                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35)),
                  fillColor: Colors.white,
                  hintText: 'Share your ideas'),
            ),
            trailing: Icon(
              Icons.image,
              color: Colors.lightGreen,
            ),
          ),
        ));
  }
}
