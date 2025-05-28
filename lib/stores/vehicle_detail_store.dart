import 'package:mobx/mobx.dart';
import '../models/document.dart';
import '../models/fuel_log.dart';
import '../services/api_service.dart';
import '../services/db_service.dart';

part 'vehicle_detail_store.g.dart';

class VehicleDetailStore = _VehicleDetailStore with _$VehicleDetailStore;

abstract class _VehicleDetailStore with Store {
  final ApiService apiService;
  final DBService dbService = DBService();

  _VehicleDetailStore(this.apiService);

  @observable
  ObservableList<Document> documents = ObservableList<Document>();

  @observable
  ObservableList<FuelLog> fuelLogs = ObservableList<FuelLog>();

  @observable
  bool isLoading = false;

  @action
  Future<void> loadDetails(int vehicleId) async {
    isLoading = true;
    try {
      final docs = await apiService.fetchDocuments(vehicleId);
      final logs = await apiService.fetchFuelLogs(vehicleId);

      documents = ObservableList.of(docs);
      fuelLogs = ObservableList.of(logs);
    } catch (_) {
      documents = ObservableList.of(await dbService.getDocuments(vehicleId));
      fuelLogs = ObservableList.of(await dbService.getFuelLogs(vehicleId));
    } finally {
      isLoading = false;
    }
  }
}
