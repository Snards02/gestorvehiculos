// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_detail_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$VehicleDetailStore on _VehicleDetailStore, Store {
  late final _$documentsAtom =
      Atom(name: '_VehicleDetailStore.documents', context: context);

  @override
  ObservableList<Document> get documents {
    _$documentsAtom.reportRead();
    return super.documents;
  }

  @override
  set documents(ObservableList<Document> value) {
    _$documentsAtom.reportWrite(value, super.documents, () {
      super.documents = value;
    });
  }

  late final _$fuelLogsAtom =
      Atom(name: '_VehicleDetailStore.fuelLogs', context: context);

  @override
  ObservableList<FuelLog> get fuelLogs {
    _$fuelLogsAtom.reportRead();
    return super.fuelLogs;
  }

  @override
  set fuelLogs(ObservableList<FuelLog> value) {
    _$fuelLogsAtom.reportWrite(value, super.fuelLogs, () {
      super.fuelLogs = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_VehicleDetailStore.isLoading', context: context);

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

  late final _$loadDetailsAsyncAction =
      AsyncAction('_VehicleDetailStore.loadDetails', context: context);

  @override
  Future<void> loadDetails(int vehicleId) {
    return _$loadDetailsAsyncAction.run(() => super.loadDetails(vehicleId));
  }

  @override
  String toString() {
    return '''
documents: ${documents},
fuelLogs: ${fuelLogs},
isLoading: ${isLoading}
    ''';
  }
}
