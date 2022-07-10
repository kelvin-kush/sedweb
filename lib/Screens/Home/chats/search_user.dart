import 'package:flutter/material.dart';
import 'package:sedweb/components/constraints.dart';

class SearchUser extends StatefulWidget {
  const SearchUser({Key? key}) : super(key: key);

  @override
  State<SearchUser> createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          leadingWidth: 0,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Form(
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Search for user',
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(color: Colors.black45)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(color: kPrimaryColor))),
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: kPrimaryColor),
                )),
          ]),
    );
  }
}
