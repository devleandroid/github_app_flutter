import 'package:flutter/material.dart';
import '../model/content.dart';
import '../screen/repository_folder_screen.dart';

class ListContent extends StatelessWidget {
  final List<Content> contents;
  final Map<String, Widget> typeWidget = {
    "dir": const Icon(
      Icons.folder,
      color: Colors.blue,
    ),
    "file": const Icon(
      Icons.insert_drive_file,
      color: Colors.grey,
    ),
  };

  ListContent({super.key, required this.contents});

  @override
  Widget build(BuildContext context) {
    final List<Content> files = contents.where((element) => element.type == "file").toList();
    final List<Content> folders = contents.where((element) => element.type == "dir").toList();
    folders.addAll(files);
    // onde esta tentdo erro
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      itemCount: folders.length,
      addAutomaticKeepAlives: false,
      itemBuilder: (context, index) {
        final Content content = folders[index];
        final Widget icon = typeWidget[content.type]!;
        return ListTile(
          onTap: () => callback(context, content),
          leading: icon, //?? const Icon(Icons.info),
          title: Text(content.name),
        );
      },
    );
  }

  Function? callback(BuildContext context, Content content) {
    final Map<String, Function> typeCallback = {
      "dir": () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  RepositoryFolderScreen(content: content)),
        );
      },
      "file": () {},
    };
    return typeCallback[content.type];
  }


}
