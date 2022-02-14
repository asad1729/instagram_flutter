import 'package:flutter/material.dart';
import 'package:instagram_flutter/screens/FeedScreen.dart';
import 'package:instagram_flutter/screens/add_post_screen.dart';

const webScreenSize = 600;

const homeScreenItems = [
  FeedScreen(),
  Text("Search"),
  AddPostScreen(),
  Text("notification"),
  Text("Profile"),
];
