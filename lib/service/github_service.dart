

import 'dart:convert';

import 'package:github_app/http/http_provider.dart';
import 'package:github_app/model/content.dart';
import 'package:github_app/model/repository.dart';
import 'package:github_app/util/api_path.dart';
import 'package:github_app/util/pagination.dart';

import '../model/user.dart';


abstract class GitHubService {
  static Future<Pagination<Repository>> findAllRepositoryByName(String name, int page) async {
      var response = await HttpProvider.get("$apiPath/search/repositories?q=$name&page=$page"); //, headers: {"Content-Type": "application/json; charset=utf-8"}
      var keyMap = jsonDecode(response.body);

      Iterable iterable = keyMap['items'];
      List<Repository> repositorys = iterable.map((repository) => Repository.fromJson(repository)).toList();

      return Pagination<Repository>(items: repositorys, total: keyMap['total_count']);
  }

  static Future<List<Content>> findAllContentByFullName(String fullName) async {
    var response = await HttpProvider.get("$apiPath/repos/$fullName/contents"); //, headers: {"Content-Type": "application/json; charset=utf-8"}
    Iterable iterable = json.decode(response.body);

    return iterable.map((content) => Content.fromJson(content)).toList();
  }


  static Future<List<Content>> findFolderByUrl(String url) async {
    var response = await HttpProvider.get(url); //, headers: {"Content-Type": "application/json; charset=utf-8"}
    Iterable iterable = json.decode(response.body);

    return iterable.map((content) => Content.fromJson(content)).toList();
  }

  static Future<User> findUserByUrl(String url) async {
      var response = await HttpProvider.get(url);
      return User.fromJson(json.decode(response.body));
  }
}