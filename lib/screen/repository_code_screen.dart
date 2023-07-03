import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:github_app/delegate/github_search_delegate.dart';
import 'package:github_app/model/repository.dart';
import 'package:github_app/service/github_service.dart';
import 'package:github_app/widgets/async_layout_constructor.dart';
import 'package:github_app/widgets/list_content.dart';

import '../model/content.dart';

class RepositoryCodeScreen extends StatefulWidget {
  final Repository repository;

  const RepositoryCodeScreen({super.key, required this.repository});

  @override
  _RepositoryCodeScreenState createState() => _RepositoryCodeScreenState();
}

class _RepositoryCodeScreenState extends State<RepositoryCodeScreen> with AutomaticKeepAliveClientMixin<RepositoryCodeScreen>{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: AsyncLayoutConstructor<List<Content>>(
        future: GitHubService.findAllContentByFullName(widget.repository.fullName),
        hasDataWidget: (data){
          return ListContent(contents: data,);
        },
        hasErrorWidget: (err) => const Center(child: Text("Ocorreu Erro!"),),
        loadingWidget: () => const Center(child: CircularProgressIndicator(),),
        hasDataEmptyWidget: () => Container(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
