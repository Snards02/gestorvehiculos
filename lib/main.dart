import 'package:flutter/material.dart';
import 'package:gestorvh/screen/login_screen.dart';
import 'package:provider/provider.dart';
import 'stores/auth_store.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.linux ||
      defaultTargetPlatform == TargetPlatform.macOS) {
    // Inicializar SQLite para desktop
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authStore = AuthStore();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthStore>(create: (_) => authStore),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gestión Transporte',
        home: LoginScreen(),
      ),
    );
  }
}
