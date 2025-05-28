class Vehicle {
  final int id;
  final String nombre;
  final String placa;
  final String tipo;

  Vehicle({
    required this.id,
    required this.nombre,
    required this.placa,
    required this.tipo,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'],
      nombre: json['name'],
      placa: json['plate'],
      tipo: json['type'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': nombre,
      'plate': placa,
      'type': tipo,
    };
  }

  factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle(
      id: map['id'],
      nombre: map['nombre'],
      placa: map['placa'],
      tipo: map['tipo'],
    );
  }
}
