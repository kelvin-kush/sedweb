import 'package:flutter/material.dart';

import '../Feed/component/add_feed.dart';

class ArticlesTab extends StatelessWidget {
  const ArticlesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Articles'),
      ),
      body: Column(
        children: [
          const AddFeed(
            isFromArticles: true,
          ),
        ],
      ),
    );
  }
}
