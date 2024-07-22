class Message {
  final int chatId;
  final String messageText;
  final int timestamp;

  const Message({
    required this.chatId,
    required this.messageText,
    required this.timestamp,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    final message = json['message'];
    return Message(
      chatId: message['chat']['id'],
      messageText: message['text'] ?? '',
      timestamp: message['date'],
    );
  }

  static List<Message> fromJsonList(Map<String, dynamic> json) {
    final List<dynamic> updates = json['result'];
    if (updates.isEmpty) {
      return <Message>[];
    }
    return updates.map((update) {
      if (update.containsKey('message')) {
        return Message.fromJson(update as Map<String, dynamic>);
      } else {
        return null;
      }
    }).where((message) => message != null).cast<Message>().toList();
  }
}
