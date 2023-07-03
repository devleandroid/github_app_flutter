import 'package:github_app/model/user.dart';

class Repository {
  String name;
  String fullName;
  String? description;
  String? language;
  User? owner;
  int stars;

  Repository.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        fullName = json['full_name'],
        description = json['description'],
        language = json['language'],
        stars = json['stargazers_count'],
        owner = json['owner'] != null ? User.fromJson(json['owner']) : null;
}
