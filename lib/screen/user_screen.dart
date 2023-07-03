import 'package:flutter/material.dart';
import 'package:github_app/service/github_service.dart';
import 'package:github_app/widgets/async_layout_constructor.dart';
import 'package:github_app/widgets/widget_call_safe.dart';

import '../model/user.dart';

class UserScreen extends StatefulWidget {
  final String url;

  const UserScreen({super.key, required this.url});

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> with AutomaticKeepAliveClientMixin<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AsyncLayoutConstructor<User>(
        future: GitHubService.findUserByUrl(widget.url),
        hasDataWidget: (user) {
          return NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => [],
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Image.network(user.avatarUrl),
                    title: Text(user.login),
                    // subtitle: Text(user.login),
                  ),
                  WidgetCallSafe(
                      checkIfNull: () => user.reposUrl != null && user.htmlUrl != null,
                      success: () {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            WidgetCallSafe(
                              checkIfNull: () => user.htmlUrl != null,
                              success: () {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                  child: Text(user.htmlUrl),
                                );
                              },
                              fail: () => Container(),
                            ),
                            WidgetCallSafe(
                              checkIfNull: () => user.company != null,
                              success: () {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                  child: Text('${user.company}'),
                                );
                              },
                              fail: () => Container(),
                            ),
                            WidgetCallSafe(
                              checkIfNull: () => user.description != null,
                              success: () {
                                return ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: const Icon(Icons.people),
                                  title: Text(user.description is String ? "" : ""),
                                  subtitle: Text(user.login),
                                );
                              },
                              fail: () => Container(),
                            )
                          ],
                        );
                      },
                      fail: () => Container())
                ],
              ),
            ),
          );
        },
        hasErrorWidget: (err) => const Center(child: Text("Ocorreu um erro")),
        loadingWidget: () => const Center(child: CircularProgressIndicator()),
        hasDataEmptyWidget: () => Container(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
