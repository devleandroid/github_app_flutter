import 'package:flutter/material.dart';
import 'package:github_app/model/content.dart';
import 'package:github_app/widgets/async_layout_constructor.dart';

import '../service/github_service.dart';
import '../widgets/list_content.dart';

class RepositoryFolderScreen extends StatelessWidget {
  final Content content;

  const RepositoryFolderScreen({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(content.name),
        titleSpacing: 0,
      ),
      body: AsyncLayoutConstructor<List<Content>>(
        future: GitHubService.findFolderByUrl(content.url),
        hasDataWidget: (data) => ListContent(contents: data),
        hasErrorWidget: (err) => const Center(child: Text("Ocorreu Erro!"),),
        loadingWidget: () => const Center(child: CircularProgressIndicator(),),
        hasDataEmptyWidget: () => Container(),
      ),
    );
  }
}
