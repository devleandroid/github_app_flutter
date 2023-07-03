

class Owner {
    String login;
    String nodeId;
    String avatarUrl;
    String gravatarId;
    String url;
    String htmlUrl;
    String followersUrl;
    String type;

    Owner.fromJson(Map<String, dynamic> json) :
            login = json['login'],
            nodeId = json['node_id'],
            avatarUrl = json['avatar_url'],
            gravatarId = json['gravatar_id'],
            url = json['url'],
            htmlUrl = json['html_url'],
            followersUrl = json['followers_url'],
            type = json['html_url'];
}