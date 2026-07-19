import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TodosApiPage extends StatefulWidget {
  const TodosApiPage({super.key});

  @override
  State<TodosApiPage> createState() => _TodosApiPageState();
}

class _TodosApiPageState extends State<TodosApiPage> {
  List todos = [];

  Future<void> getTodos() async {
    final res = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/todos'),
    );

    if (res.statusCode == 200) {
      todos = jsonDecode(res.body);
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos API'),
        backgroundColor: Colors.purple,
        toolbarHeight: 80,
      ),
      body: todos.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(todos[index]['id'].toString()),
                    ),
                    title: Text(
                      todos[index]['title'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text('User ID: ${todos[index]['userId']}'),
                    trailing: Icon(
                      todos[index]['completed']
                          ? Icons.check_circle
                          : Icons.cancel,
                      color: todos[index]['completed']
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
