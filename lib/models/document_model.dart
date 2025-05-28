class DocumentModel {
  final int? id;
  final String type;
  final DateTime expirationDate;
  final String filePath; // local o url
  final int vehicleId;

  DocumentModel({
    this.id,
    required this.type,
    required this.expirationDate,
    required this.filePath,
    required this.vehicleId,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      id: json['id'],
      type: json['type'],
      expirationDate: DateTime.parse(json['expiration_date']),
      filePath: json['file_path'],
      vehicleId: json['vehicle_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'expiration_date': expirationDate.toIso8601String(),
      'file_path': filePath,
      'vehicle_id': vehicleId,
    };
  }
}
