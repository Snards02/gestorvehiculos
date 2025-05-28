import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddFuelLogScreen extends StatefulWidget {
  final int vehicleId;

  const AddFuelLogScreen({super.key, required this.vehicleId});

  @override
  State<AddFuelLogScreen> createState() => _AddFuelLogScreenState();
}

class _AddFuelLogScreenState extends State<AddFuelLogScreen> {
  final _formKey = GlobalKey<FormState>();
  double? _monto;
  DateTime? _fecha;
  File? _imagen;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.camera);

    if (picked != null) {
      setState(() {
        _imagen = File(picked.path);
      });
    }
  }

  Future<void> _guardarTanqueo() async {
    if (_formKey.currentState!.validate() &&
        _fecha != null &&
        _imagen != null) {
      _formKey.currentState!.save();

      // Aquí se guarda en SQLite y se sincroniza con backend si aplica

      Navigator.pop(context, true); // Indica éxito
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Completa todos los campos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registrar Tanqueo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Monto (COP)'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || double.tryParse(value) == null
                        ? 'Monto inválido'
                        : null,
                onSaved: (value) => _monto = double.parse(value!),
              ),
              SizedBox(height: 12),
              ListTile(
                title: Text(_fecha == null
                    ? 'Seleccionar fecha'
                    : 'Fecha: ${_fecha!.toLocal()}'.split(' ')[0]),
                trailing: Icon(Icons.calendar_today),
                onTap: () async {
                  final f = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2023),
                    lastDate: DateTime(2030),
                  );
                  if (f != null) setState(() => _fecha = f);
                },
              ),
              SizedBox(height: 12),
              ElevatedButton.icon(
                icon: Icon(Icons.photo),
                label: Text(_imagen == null
                    ? 'Tomar foto recibo'
                    : 'Foto seleccionada'),
                onPressed: _pickImage,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _guardarTanqueo,
                child: Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
