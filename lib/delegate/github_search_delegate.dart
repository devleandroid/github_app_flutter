import 'package:flutter/material.dart';
import 'package:github_app/model/repository.dart';
import 'package:github_app/screen/repository_tab_screen.dart';
import 'package:github_app/service/github_service.dart';
import 'package:github_app/util/pagination.dart';
import 'package:github_app/widgets/async_layout_constructor.dart';
import 'package:github_app/widgets/text_icon.dart';

class GitHubSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    if (query.isNotEmpty) {
      return [
        IconButton(onPressed: () => query = "", icon: const Icon(Icons.clear))
      ];
    }

    return [Container()];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, ""),
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_close,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }
    return ReposotoryList(query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }
    return ListTile(
      leading: const Icon(Icons.book),
      title: Text("Repositorios com $query"),
      onTap: () => showResults(context),
    );
  }

  @override
  String? get searchFieldLabel => "Pesquisar";
}

class ReposotoryList extends StatefulWidget {
  final String query;

  const ReposotoryList({Key, key, required this.query}) : super(key: key);

  @override
  State<ReposotoryList> createState() => _ReposotoryListState();
}

class _ReposotoryListState extends State<ReposotoryList> {
  final List<Widget> cache = [];
  late Future<List<Widget>> future;
  final maxGitResult = 1000;
  int page = 1;

  @override
  void initState() {
    future = findAllRepositoryByName();
    super.initState();
  }

  Future<List<Widget>> findAllRepositoryByName() async {
    final pagination =
        await GitHubService.findAllRepositoryByName(widget.query, page);
    if (cache.isEmpty) {
      cache.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Flexible(child: Text("Repositorios encontrados")),
            Text("${pagination.total}"),
          ],
        ),
      ));
    }
    if (cache.last is LoadingList) {
      cache.removeLast();
    }
    cache.addAll(pagination.items.map((it) => RepositoryView(repository: it)));
    if (haveMore(pagination)) {
      cache.add(LoadingList());
    }
    page++;
    return cache;
  }

  @override
  Widget build(BuildContext context) {
    return AsyncLayoutConstructor<List<Widget>>(
      future: future,
      hasDataWidget: (data) {
        return ListView.separated(
          itemCount: data.length,
          addAutomaticKeepAlives: false,
          itemBuilder: (context, index) {
            if (data is LoadingList) {
              future = findAllRepositoryByName().whenComplete(() => setState(() {}));
            }
            return data[index]; //Text("${snapshot.data?.items[index].name}");
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        );
      },
      hasErrorWidget: (err) => const Center(child: Text("Deu Erro!")),
      loadingWidget: () => const Center(child: CircularProgressIndicator()),
      hasDataEmptyWidget: () => Container(),
    );
  }

  bool haveMore(Pagination<Repository> pagination) {
    int total = cache.where((element) => element is RepositoryView).length;
    if (total < pagination.total && total < maxGitResult) {
      return true;
    }
    return false;
  }
}

class RepositoryView extends StatelessWidget {
  final Repository? repository;

  const RepositoryView({Key? key, this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (BuildContext context) {
              return RepositoryTabScreen(repository: repository!);
            })
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: <Widget>[
                Image.network(
                  repository!.owner!.avatarUrl,
                  width: 32,
                  height: 32,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(repository!.owner!.login),
                ),
              ],
            ),
          ),
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            title: Text(repository!.name),
            subtitle: Text(repository?.description ?? "Sem descrição"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(child: Text(repository?.language ?? "Não definida")),
                TextIcon(
                  title: "${repository!.stars}",
                  icon: const Icon(
                    Icons.stars,
                    color: Colors.amberAccent,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class LoadingList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
