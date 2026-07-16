import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_json_placeholder_api/apis/product.dart';
import 'package:http/http.dart' as http;

class UserApiPage extends StatefulWidget {
  const UserApiPage({super.key});

  @override
  State<UserApiPage> createState() => _UserApiPageState();
}

class _UserApiPageState extends State<UserApiPage> {
  List users = [];
  Future<void> getUser() async {
    final res = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
    );
    if (res.statusCode == 200) {
      users = jsonDecode(res.body);
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProductPage()),
                  );
                });
              },
              child: Text("Next Api"),
            ),
          ),
        ],
        title: Text(
          'User Api ',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight(600),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 41, 35, 16),
      ),
      body: SafeArea(
        child: Center(
          child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Text(users[index]['name']),
                  Text(users[index]['username']),
                  Text(users[index]['email']),
                  Text(users[index]['address']['city']),
                  Text(users[index]['address']['geo']['lat']),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
