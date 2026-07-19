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
            fontWeight: FontWeight(400),
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    child: Card(
                      color: const Color.fromARGB(255, 233, 146, 32),
                      child: ExpansionTile(
                        shape: const Border(),
                        collapsedShape: const Border(),
                        dense: true,
                        leading: CircleAvatar(
                          backgroundColor: Colors.amber,
                          foregroundColor: Colors.white,
                          child: Text((users[index]['id']).toString()),
                        ),
                        title: Text(users[index]['name']),
                        subtitle: Text(users[index]['email']),
                        children: [
                          ListTile(
                            dense: true,
                            leading: Icon(Icons.location_city, size: 20),
                            title: Text(users[index]['address']['city']),
                          ),
                          ListTile(
                            dense: true,
                            leading: Icon(Icons.phone, size: 20),
                            title: Text(users[index]['phone']),
                          ),
                          ListTile(
                            dense: true,
                            leading: Icon(Icons.language, size: 20),
                            title: Text(users[index]['website']),
                          ),
                          ListTile(
                            dense: true,
                            leading: Icon(Icons.business, size: 20),
                            title: Text(users[index]['company']['name']),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
