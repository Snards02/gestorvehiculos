import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gestorvh/screen/add_document_screen.dart';
import 'package:gestorvh/screen/add_fuel_log_screen.dart';
import '../models/vehicle.dart';
import '../stores/vehicle_detail_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class VehicleDetailScreen extends StatefulWidget {
  final Vehicle vehicle;
  final VehicleDetailStore store;

  const VehicleDetailScreen({required this.vehicle, required this.store});

  @override
  _VehicleDetailScreenState createState() => _VehicleDetailScreenState();
}

class _VehicleDetailScreenState extends State<VehicleDetailScreen> {
  @override
  void initState() {
    super.initState();
    widget.store.loadDetails(widget.vehicle.id);
  }

  @override
  Widget build(BuildContext context) {
    int tabbar = 1;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.vehicle.nombre),
      ),
      body: Observer(
        builder: (_) => widget.store.isLoading
            ? Center(child: CircularProgressIndicator())
            : DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    TabBar(tabs: [
                      Tab(text: "Documentos"),
                      Tab(text: "Tanqueos"),
                    ]),
                    Expanded(
                      child: TabBarView(
                        children: [
                          _buildDocuments(),
                          _buildFuelLogs(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildDocuments() {
    return Scaffold(
      body: ListView.builder(
        itemCount: widget.store.documents.length,
        itemBuilder: (_, i) {
          final doc = widget.store.documents[i];
          final vencido =
              DateTime.parse(doc.vencimiento).isBefore(DateTime.now());
          return ListTile(
            title: Text(doc.tipo),
            subtitle: Text('Vence: ${doc.vencimiento}'),
            trailing: Icon(Icons.picture_as_pdf,
                color: vencido ? Colors.red : Colors.green),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AddDocumentScreen(vehicleId: widget.vehicle.id),
          ),
        ),
      ),
    );
  }

  Widget _buildFuelLogs() {
    return Scaffold(
      body: ListView.builder(
        itemCount: widget.store.fuelLogs.length,
        itemBuilder: (_, i) {
          final log = widget.store.fuelLogs[i];
          return ListTile(
            title: Text('Monto: \$${log.monto}'),
            subtitle: Text('Fecha: ${log.fecha}'),
            trailing: Image.file(File(log.imagen), width: 40, height: 40),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AddFuelLogScreen(vehicleId: widget.vehicle.id),
          ),
        ),
      ),
    );
  }
}
