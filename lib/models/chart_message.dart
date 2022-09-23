class ChatMessage {
  final String? id;
  final String? message;
  final String sender;
  final DateTime sendDate;
  final String? fileUrl;
  final String messageType;
  //final String profile;

  ChatMessage({
    this.id,
    this.message,
    required this.sender,
    // required this.profile,
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
      //  'profile':profile,
      'messageType': messageType,
    };
  }

  ChatMessage.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        message = json['message'] ?? "",
        sender = json['sender'],
        sendDate = json['sendDate'],
        //  profile = json['profile'],
        fileUrl = json['fileUrl'] ?? "",
        messageType = json['messageType'];
}
