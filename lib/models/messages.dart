class Message {
  final String message;

  Message(this.message);

  factory Message.fromJson(jasonDate) {
    return Message(jasonDate['message']);
  }
}
