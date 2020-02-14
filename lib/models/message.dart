class Message {
  final String senderName;
  final String content;
  final DateTime date;

  const Message(this.senderName, this.content, this.date);

  Map<String, dynamic> toJson() => {
        'senderName': senderName,
        'content': content,
        'date': date.toString(),
      };

  static Message fromJson(Map<String, dynamic> data) {
    return Message(
      data['senderName'],
      data['content'],
      DateTime.parse(data['date']),
    );
  }
}
