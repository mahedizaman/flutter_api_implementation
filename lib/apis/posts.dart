import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_json_placeholder_api/apis/album.dart';
import 'package:http/http.dart' as app;

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  List posts = [];
  Future<void> getPosts() async {
    final res = await app.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );
    if (res.statusCode == 200) {
      posts = jsonDecode(res.body);
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      getPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        toolbarHeight: 80,
        title: Text('Posts Api'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AlbumApiPage()),
                );
              },
              child: Text('Next Api'),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return Card(
            surfaceTintColor: const Color.fromARGB(255, 115, 0, 165),
            color: const Color.fromARGB(255, 104, 139, 96),
            shadowColor: Colors.amber,
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    posts[index]['title'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(posts[index]['body']),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
