import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../stores/document_store.dart';
import '../../../models/document_model.dart';
import 'package:image_picker/image_picker.dart';

class DocumentsTab extends StatelessWidget {
  final int vehicleId;
  final DocumentStore store;

  DocumentsTab({required this.vehicleId, required this.store});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Column(
        children: [
          ElevatedButton.icon(
            icon: Icon(Icons.add),
            label: Text('Agregar documento'),
            onPressed: () => _addDocument(context),
          ),
          store.isLoading
              ? CircularProgressIndicator()
              : Expanded(
                  child: ListView.builder(
                    itemCount: store.documents.length,
                    itemBuilder: (_, index) {
                      final doc = store.documents[index];
                      final isExpired =
                          doc.expirationDate.isBefore(DateTime.now());
                      return ListTile(
                        title: Text(doc.type),
                        subtitle:
                            Text('Vence: ${doc.expirationDate.toLocal()}'),
                        trailing: Icon(
                          isExpired ? Icons.warning : Icons.check,
                          color: isExpired ? Colors.red : Colors.green,
                        ),
                        onTap: () {
                          // abrir imagen/pdf
                        },
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }

  Future<void> _addDocument(BuildContext context) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final newDoc = DocumentModel(
        type: 'SOAT',
        expirationDate: DateTime.now().add(Duration(days: 365)),
        filePath: picked.path,
        vehicleId: vehicleId,
      );
      await store.addDocument(newDoc);
    }
  }
}
