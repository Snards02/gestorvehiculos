import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gestorvh/screen/vehicle_detail_screen.dart';
import 'package:gestorvh/services/api_service.dart';
import 'package:gestorvh/stores/vehicle_detail_store.dart';
import 'package:provider/provider.dart';
import '../stores/vehicle_store.dart';
import '../stores/auth_store.dart';
import '../models/vehicle.dart';

class VehicleListScreen extends StatefulWidget {
  @override
  _VehicleListScreenState createState() => _VehicleListScreenState();
}

class _VehicleListScreenState extends State<VehicleListScreen> {
  late VehicleStore _vehicleStore;
  late VehicleDetailStore _detailStore;
  @override
  void didChangeDependencies() {
    final auth = Provider.of<AuthStore>(context);
    _vehicleStore = VehicleStore(
      ApiService(baseUrl: 'http://10.0.2.2:8000', token: auth.token!),
    );
    _detailStore = VehicleDetailStore(
        ApiService(baseUrl: 'http://10.0.2.2:8000', token: auth.token!));
    _vehicleStore.loadVehicles();
    super.didChangeDependencies();
  }

  void _showAddVehicleDialog() {
    final nameController = TextEditingController();
    final plateController = TextEditingController();
    final typeController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Agregar Vehículo'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Nombre')),
            TextField(
                controller: plateController,
                decoration: InputDecoration(labelText: 'Placa')),
            TextField(
                controller: typeController,
                decoration: InputDecoration(labelText: 'Tipo')),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              final success = await _vehicleStore.addVehicle(
                nameController.text,
                plateController.text,
                typeController.text,
              );
              if (success) Navigator.pop(context);
            },
            child: Text('Guardar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehículos'),
        actions: [
          IconButton(
            icon: Icon(Icons.sync),
            onPressed: () => _vehicleStore.loadVehicles(),
          ),
        ],
      ),
      body: Observer(
        builder: (_) {
          if (_vehicleStore.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (_vehicleStore.error != null) {
            return Center(child: Text('Error: ${_vehicleStore.error}'));
          } else if (_vehicleStore.vehicles.isEmpty) {
            return Center(child: Text('No hay vehículos'));
          }

          return ListView.builder(
            itemCount: _vehicleStore.vehicles.length,
            itemBuilder: (_, i) {
              final v = _vehicleStore.vehicles[i];
              return ListTile(
                title: Text('${v.nombre} (${v.placa})'),
                subtitle: Text('Tipo: ${v.tipo}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          VehicleDetailScreen(vehicle: v, store: _detailStore),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _showAddVehicleDialog,
      ),
    );
  }
}
