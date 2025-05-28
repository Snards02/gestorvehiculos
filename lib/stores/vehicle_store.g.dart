// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$VehicleStore on _VehicleStore, Store {
  late final _$vehiclesAtom =
      Atom(name: '_VehicleStore.vehicles', context: context);

  @override
  ObservableList<Vehicle> get vehicles {
    _$vehiclesAtom.reportRead();
    return super.vehicles;
  }

  @override
  set vehicles(ObservableList<Vehicle> value) {
    _$vehiclesAtom.reportWrite(value, super.vehicles, () {
      super.vehicles = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_VehicleStore.isLoading', context: context);

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

  late final _$errorAtom = Atom(name: '_VehicleStore.error', context: context);

  @override
  String? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$loadVehiclesAsyncAction =
      AsyncAction('_VehicleStore.loadVehicles', context: context);

  @override
  Future<void> loadVehicles() {
    return _$loadVehiclesAsyncAction.run(() => super.loadVehicles());
  }

  late final _$addVehicleAsyncAction =
      AsyncAction('_VehicleStore.addVehicle', context: context);

  @override
  Future<bool> addVehicle(String nombre, String placa, String tipo) {
    return _$addVehicleAsyncAction
        .run(() => super.addVehicle(nombre, placa, tipo));
  }

  @override
  String toString() {
    return '''
vehicles: ${vehicles},
isLoading: ${isLoading},
error: ${error}
    ''';
  }
}
