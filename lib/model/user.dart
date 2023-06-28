

class User {
  // String name;
  String login;
  String avatarUrl;
  String url;
  String htmlUrl;
  String organizationsUrl;
  String reposUrl;
  String type;
  // String email;

  User.fromJson(Map<String, dynamic> json)
      : //name = json['name'],
        login = json['login'],
        avatarUrl = json['avatar_url'],
        url = json['url'],
        htmlUrl = json['html_url'],
        organizationsUrl = json['organizations_url'],
        reposUrl = json['repos_url'],
        type = json['type'];
        // email = json['emails'];
}