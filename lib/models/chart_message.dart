class ChatMessage {
  final String? id;
  final String messageContent;
  final String messageSender;
  final DateTime sendDate;
  final String? imageUrl;
  final String? voiceNote;

  ChatMessage({
     this.id,
    required this.messageContent,
    required this.messageSender,
    required this.sendDate,
    this.imageUrl,
    this.voiceNote,
  });

  
}
