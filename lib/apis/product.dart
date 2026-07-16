import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List photos = [];
  Future<void> getPhotos() async {
    final res = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/photos'),
    );
    if (res.statusCode == 200) {
      photos = jsonDecode(res.body);
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.cyan,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(onPressed: () {}, child: Text('Next Api')),
          ),
        ],
        title: Text('Product Api'),
      ),
      body: ListView.builder(
        itemCount: 50,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ExpansionTile(
              title: Text(photos[index]['title']),
              children: [
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Image.network(
                    photos[index]['thumbnailUrl'],
                    width: 150,
                    height: 150,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
