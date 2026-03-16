class GitHubUser {
  final String id;
  final String login;
  final String name;
  final String? avatarUrl;
  final String? bio;
  final String? company;
  final String? location;
  final int publicRepos;
  final int followers;
  final int following;

  GitHubUser({
    required this.id,
    required this.login,
    required this.name,
    this.avatarUrl,
    this.bio,
    this.company,
    this.location,
    required this.publicRepos,
    required this.followers,
    required this.following,
  });

  factory GitHubUser.fromJson(Map<String, dynamic> json) {
    return GitHubUser(
      id: json['id'].toString(),
      login: json['login'] ?? '',
      name: json['name'] ?? json['login'] ?? 'User',
      avatarUrl: json['avatar_url'],
      bio: json['bio'],
      company: json['company'],
      location: json['location'],
      publicRepos: json['public_repos'] ?? 0,
      followers: json['followers'] ?? 0,
      following: json['following'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'login': login,
      'name': name,
      'avatar_url': avatarUrl,
      'bio': bio,
      'company': company,
      'location': location,
      'public_repos': publicRepos,
      'followers': followers,
      'following': following,
    };
  }
}
