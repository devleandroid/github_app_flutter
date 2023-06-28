import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:github_app/model/repository.dart';
import 'package:github_app/screen/repository_code_screen.dart';
import 'package:github_app/widgets/text_icon.dart';

import 'user_screen.dart';

class RepositoryTabScreen extends StatefulWidget {
  final Repository repository;

  const RepositoryTabScreen({super.key, required this.repository});

  @override
  _RepositoryTabScreenState createState() => _RepositoryTabScreenState();
}

class _RepositoryTabScreenState extends State<RepositoryTabScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  forceElevated: innerBoxIsScrolled,
                  title: Text("${widget.repository.name}"),
                  snap: true,
                  floating: true,
                  titleSpacing: 0,
                  bottom: TabBar(
                    tabs: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: const TextIcon(
                          title: "Proprietário",
                          icon: Icon(Icons.person),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: const TextIcon(
                          title: "Código",
                          icon: Icon(Icons.code),
                        ),
                      ),
                    ],
                  ),
                )
              ];
            },
            body: TabBarView(
              children: <Widget>[
                UserScreen(url: widget.repository.owner!.url,),
                RepositoryCodeScreen(repository: widget.repository,),
              ],
            ),
          ),
        ));
  }
}
