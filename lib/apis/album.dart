import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_json_placeholder_api/apis/todos.dart';
import 'package:http/http.dart' as http;

class AlbumApiPage extends StatefulWidget {
  const AlbumApiPage({super.key});

  @override
  State<AlbumApiPage> createState() => _AlbumApiPageState();
}

class _AlbumApiPageState extends State<AlbumApiPage> {
  List albums = [];
  Future<void> getAlbums() async {
    final res = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    );
    if (res.statusCode == 200) {
      albums = jsonDecode(res.body);
      setState(() {});
    }
  }

  @override
  initState() {
    super.initState();
    getAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        toolbarHeight: 80,
        title: Text("Albums Api"),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TodosApiPage()),
              );
            },
            child: Text('Next Api'),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: albums.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListTile(
                        leading: Text(albums[index]['id'].toString()),
                        title: Text(albums[index]['title']),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
