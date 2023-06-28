import 'package:flutter/material.dart';

import '../delegate/github_search_delegate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bem vindo ao GitHub"),
        actions: <Widget>[
          IconButton(
              onPressed: (){
                showSearch(
                    context: context,
                    delegate: GitHubSearchDelegate(),
                );
              },
              icon: const Icon(Icons.search)
          ),
        ],
      ),
      body: const Center(
        child: Text("Buscar repositórios publicos"),
      ),
    );
  }
}
