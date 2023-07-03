import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:github_app/widgets/async_layout_constructor.dart';
import 'package:github_app/widgets/widget_call_safe.dart';
import '../model/content.dart';
import '../service/github_service.dart';

class RepositoryContentBlobScreen extends StatelessWidget {
  final Base64Codec base64codec = Base64Codec();
  final Utf8Codec utf8codec = Utf8Codec();
  Content content;

  RepositoryContentBlobScreen({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                titleSpacing: 0,
                title: Text(content.name ?? content.path),
              ),
            ];
          },
          body: AsyncLayoutConstructor<Content>(
            future: GitHubService.findFileByUrl(content.url),
            hasDataWidget: (data) {
              final String? decodeContent = tryDecode(data);
              return WidgetCallSafe(
                checkIfNull:() => decodeContent != null,
                success: () {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: HighlightView(
                        decodeContent!,
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                        theme: githubTheme,
                        language: "javascript",
                      ),
                    ),
                  );
                },
                fail: () {
                  return Center(
                    child: Text("Não foi possivel ler o arquivo"),
                  );
                },
              );
            },
            hasErrorWidget: (err) =>
            const Center(child: Text("Ocorreu Erro!"),),
            loadingWidget: () =>
            const Center(child: CircularProgressIndicator(),),
            hasDataEmptyWidget: () => Container(),
          )
      ),
    );
  }

  String? tryDecode(Content content) {
    try {
      return utf8codec.decode(
          base64codec.decode(content.content!.replaceAll("\n", "")));
    } catch (err) {
      print(err);
      return null;
    }
  }
}
