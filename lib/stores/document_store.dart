import 'package:mobx/mobx.dart';
import '../models/document_model.dart';
import '../services/document_service.dart';

part 'document_store.g.dart';

class DocumentStore = _DocumentStore with _$DocumentStore;

abstract class _DocumentStore with Store {
  @observable
  ObservableList<DocumentModel> documents = ObservableList<DocumentModel>();

  @observable
  bool isLoading = false;

  @action
  Future<void> loadDocuments(int vehicleId) async {
    isLoading = true;
    final result = await DocumentService.getDocuments(vehicleId);
    documents = ObservableList.of(result);
    isLoading = false;
  }

  @action
  Future<void> addDocument(DocumentModel doc) async {
    await DocumentService.saveDocument(doc);
    documents.add(doc);
  }
}
