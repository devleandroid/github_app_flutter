import 'owner.dart';

class User {
  String login;
  String avatarUrl;
  String url;
  String htmlUrl;
  String organizationsUrl;
  String reposUrl;
  String type;
  String? description;
  String? language;
  String? company;
  Owner? owner;

  User.fromJson(Map<String, dynamic> json)
      : login = json['login'],
        avatarUrl = json['avatar_url'],
        url = json['url'],
        htmlUrl = json['html_url'],
        organizationsUrl = json['organizations_url'],
        reposUrl = json['repos_url'],
        type = json['type'],
        description = json['description'],
        language = json['language'],
        company = json['company'],
        owner = json['owner'];
}