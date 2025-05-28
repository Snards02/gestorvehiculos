// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DocumentStore on _DocumentStore, Store {
  late final _$documentsAtom =
      Atom(name: '_DocumentStore.documents', context: context);

  @override
  ObservableList<DocumentModel> get documents {
    _$documentsAtom.reportRead();
    return super.documents;
  }

  @override
  set documents(ObservableList<DocumentModel> value) {
    _$documentsAtom.reportWrite(value, super.documents, () {
      super.documents = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_DocumentStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$loadDocumentsAsyncAction =
      AsyncAction('_DocumentStore.loadDocuments', context: context);

  @override
  Future<void> loadDocuments(int vehicleId) {
    return _$loadDocumentsAsyncAction.run(() => super.loadDocuments(vehicleId));
  }

  late final _$addDocumentAsyncAction =
      AsyncAction('_DocumentStore.addDocument', context: context);

  @override
  Future<void> addDocument(DocumentModel doc) {
    return _$addDocumentAsyncAction.run(() => super.addDocument(doc));
  }

  @override
  String toString() {
    return '''
documents: ${documents},
isLoading: ${isLoading}
    ''';
  }
}
