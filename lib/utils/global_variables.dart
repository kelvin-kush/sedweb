import 'package:flutter/material.dart';
import 'package:sedweb/Screens/Home/Feed/feed.dart';
import 'package:sedweb/Screens/add_post_screen.dart';

const webScreenSize = 600;

const homeScreenItems = [
  Feed(),
  Text('search'),
  AddPostScreen(),
  Text('notif'),
  Text('profile'),
];
