import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../stores/auth_store.dart';
import 'vehicle_list_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late AuthStore _authStore;

  @override
  void initState() {
    super.initState();
    _authStore = Provider.of<AuthStore>(context, listen: false);
    _checkSession();
  }

  Future<void> _checkSession() async {
    await _authStore.loadToken();
    if (_authStore.token != null) {
      _goToMain();
    }
  }

  void _goToMain() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => VehicleListScreen()),
    );
  }

  void _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    final success = await _authStore.login(email, password);
    if (success) {
      _goToMain();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Credenciales inválidas o error en conexión')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Iniciar Sesión')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Observer(
          builder: (_) => Column(
            children: [
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Correo electrónico'),
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              _authStore.isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _handleLogin,
                      child: Text('Ingresar'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
