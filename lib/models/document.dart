class Document {
  final int id;
  final int vehicleId;
  final String tipo;
  final String vencimiento;
  final String archivo;

  Document({
    required this.id,
    required this.vehicleId,
    required this.tipo,
    required this.vencimiento,
    required this.archivo,
  });

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        id: json['id'],
        vehicleId: json['vehicle_id'],
        tipo: json['tipo'],
        vencimiento: json['vencimiento'],
        archivo: json['archivo'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'vehicleId': vehicleId,
        'tipo': tipo,
        'vencimiento': vencimiento,
        'archivo': archivo,
      };

  factory Document.fromMap(Map<String, dynamic> map) => Document(
        id: map['id'],
        vehicleId: map['vehicleId'],
        tipo: map['tipo'],
        vencimiento: map['vencimiento'],
        archivo: map['archivo'],
      );
}
