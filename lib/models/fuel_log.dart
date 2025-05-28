class FuelLog {
  final int id;
  final int vehicleId;
  final String fecha;
  final double monto;
  final String imagen;

  FuelLog({
    required this.id,
    required this.vehicleId,
    required this.fecha,
    required this.monto,
    required this.imagen,
  });

  factory FuelLog.fromJson(Map<String, dynamic> json) => FuelLog(
        id: json['id'],
        vehicleId: json['vehicle_id'],
        fecha: json['fecha'],
        monto: json['monto'].toDouble(),
        imagen: json['imagen'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'vehicleId': vehicleId,
        'fecha': fecha,
        'monto': monto,
        'imagen': imagen,
      };

  factory FuelLog.fromMap(Map<String, dynamic> map) => FuelLog(
        id: map['id'],
        vehicleId: map['vehicleId'],
        fecha: map['fecha'],
        monto: map['monto'],
        imagen: map['imagen'],
      );
}
