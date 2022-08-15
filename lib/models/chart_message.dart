class ChatMessage {
  final String? id;
  final String? message;
  final String sender;
  final DateTime sendDate;
  final String? fileUrl;
  final String messageType;

  ChatMessage({
    this.id,
    this.message,
    required this.sender,
    required this.sendDate,
    this.fileUrl,
    required this.messageType,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'sender': sender,
      'sendDate': sendDate,
      'fileUrl': fileUrl,
      'messageType': messageType,
    };
  }

  ChatMessage.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        message = json['message'] ?? "",
        sender = json['sender'],
        sendDate = json['sendDate'],
        fileUrl = json['fileUrl'] ?? "",
        messageType = json['messageType'];
}
