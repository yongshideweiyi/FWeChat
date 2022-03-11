class Chat {
  final String? name;
  final String? message;
  final String? avatar;
  Chat({this.name, this.message, this.avatar});

  factory Chat.formMap(Map map) {
    return Chat(
        name: map['name'],
        message: map['message'],
        avatar: map['avatar']
    );
  }
}