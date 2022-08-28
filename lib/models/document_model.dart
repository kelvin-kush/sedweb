
class DocumentModel {
  String? docID;
  String? title;
  String? information;
  String? docType;

  DocumentModel({
    this.title,
    this.docID,
    this.information,
    this.docType,
  });

  factory DocumentModel.fromMap(map) {
    return DocumentModel(
        docID: map['docID'],
        docType: map['docType'],
        title: map['title'],
        information: map['information']);
  }

  Map<String, dynamic> toMap() {
    return {
      'docID': docID,
      'docType': docType ?? '',
      'title': title ?? '',
      'information': information ?? "",
    };
  }
}
