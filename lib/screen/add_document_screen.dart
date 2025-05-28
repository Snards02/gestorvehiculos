import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddDocumentScreen extends StatefulWidget {
  final int vehicleId;

  const AddDocumentScreen({super.key, required this.vehicleId});

  @override
  State<AddDocumentScreen> createState() => _AddDocumentScreenState();
}

class _AddDocumentScreenState extends State<AddDocumentScreen> {
  final _formKey = GlobalKey<FormState>();
  String _tipo = '';
  DateTime? _fechaVencimiento;
  File? _archivo;

  Future<void> _pickFile() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        _archivo = File(picked.path);
      });
    }
  }

  Future<void> _guardarDocumento() async {
    if (_formKey.currentState!.validate() &&
        _fechaVencimiento != null &&
        _archivo != null) {
      _formKey.currentState!.save();

      // Aquí se insertaría el documento en SQLite y/o se sincroniza con el backend

      Navigator.pop(context, true); // Volver indicando éxito
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor completa todos los campos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Agregar Documento')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Tipo de documento'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Requerido' : null,
                onSaved: (value) => _tipo = value!,
              ),
              SizedBox(height: 12),
              ListTile(
                title: Text(_fechaVencimiento == null
                    ? 'Seleccionar fecha de vencimiento'
                    : 'Vence: ${_fechaVencimiento!.toLocal()}'.split(' ')[0]),
                trailing: Icon(Icons.calendar_today),
                onTap: () async {
                  final fecha = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(Duration(days: 30)),
                    lastDate: DateTime.now().add(Duration(days: 365 * 5)),
                  );
                  if (fecha != null) {
                    setState(() => _fechaVencimiento = fecha);
                  }
                },
              ),
              SizedBox(height: 12),
              ElevatedButton.icon(
                icon: Icon(Icons.upload_file),
                label: Text(_archivo == null
                    ? 'Subir archivo'
                    : 'Archivo seleccionado'),
                onPressed: _pickFile,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _guardarDocumento,
                child: Text('Guardar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
