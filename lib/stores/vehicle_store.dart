import 'package:mobx/mobx.dart';
import '../models/vehicle.dart';
import '../services/api_service.dart';
import '../services/db_service.dart';

part 'vehicle_store.g.dart';

class VehicleStore = _VehicleStore with _$VehicleStore;

abstract class _VehicleStore with Store {
  final ApiService apiService;
  final DBService dbService = DBService();

  _VehicleStore(this.apiService);

  @observable
  ObservableList<Vehicle> vehicles = ObservableList<Vehicle>();

  @observable
  bool isLoading = false;

  @observable
  String? error;

  @action
  Future<void> loadVehicles() async {
    isLoading = true;
    error = null;
    try {
      final data = await apiService.fetchVehicles();

      vehicles = ObservableList.of(data);
    } catch (e) {
      error = e.toString();
      vehicles = ObservableList.of(await dbService.getVehicles());
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool> addVehicle(String nombre, String placa, String tipo) async {
    final success = await apiService.addVehicle(nombre, placa, tipo);
    if (success) await loadVehicles();
    return success;
  }
}
