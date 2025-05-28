import 'dart:convert';
import 'package:gestorvh/models/document.dart';
import 'package:gestorvh/models/fuel_log.dart';
import 'package:http/http.dart' as http;
import '../models/vehicle.dart';

class ApiService {
  final String baseUrl;
  final String token;

  ApiService({required this.baseUrl, required this.token});

  /// Fetches a list of vehicles from the API.
  ///
  /// Sends a GET request to the endpoint at `$baseUrl/api/vehicles` with an
  /// Authorization header containing the Bearer token.
  ///
  /// Returns a `Future` that resolves to a `List<Vehicle>` if the request
  /// is successful (HTTP status code 200). If the request fails, an
  /// `Exception` is thrown.

  Future<List<Vehicle>> fetchVehicles() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/vehicles'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      List<Vehicle> vehicles = data.map((e) => Vehicle.fromJson(e)).toList();
      if (vehicles.isNotEmpty) {}
      return vehicles;
    } else {
      throw Exception('Error al obtener vehículos');
    }
  }

  Future<bool> addVehicle(String nombre, String placa, String tipo) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/vehicles'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': nombre,
        'plate': placa,
        'type': tipo,
      }),
    );
    return response.statusCode == 201;
  }

  Future<List<Document>> fetchDocuments(int vehicleId) async {
    final res = await http.get(
      Uri.parse('$baseUrl/api/vehicles/$vehicleId/documents'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return (data as List).map((e) => Document.fromJson(e)).toList();
    }
    throw Exception('Error al obtener documentos');
  }

  Future<List<FuelLog>> fetchFuelLogs(int vehicleId) async {
    final res = await http.get(
      Uri.parse('$baseUrl/api/vehicles/$vehicleId/fuel_logs'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return (data as List).map((e) => FuelLog.fromJson(e)).toList();
    }
    throw Exception('Error al obtener tanqueos');
  }
}
