const String apiPath = "https://api.github.com";

/**
 * Chamada a api do GitHub
 * https://api.github.com/search/repositories?q=crawler&page=1
 * */


/**
return FutureBuilder<Pagination<Repository>>(
      future: GitHubService.findAllRepositoryByName(widget.query, page),
      builder: (BuildContext context,
          AsyncSnapshot<Pagination<Repository>> snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Deu Erro!"));
        }
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.items.length,
            itemBuilder: (context, index) {
              return RepositoryView(repository: snapshot.data!.items[index]); //Text("${snapshot.data?.items[index].name}");
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
**/

/**
 *
 * checkIfNull: () => user.email != null && user.bio != null,
    success: () {
    return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
    WidgetCallSafe(
    checkIfNull: () => user.email != null,
    success: () {
    return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Text("${user.email}"),
    );
    },
    fail: () => Container(),
    ),
    WidgetCallSafe(
    checkIfNull: () => user.bio != null,
    success: () {
    return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Text("${user.bio}"),
    );
    },
    fail: () => Container(),
    ),
    ],
    );
    },
    fail: () => Container()
 *
 */
