import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'incidencias_provider.dart';

class RegisterIncidenciaScreen extends StatefulWidget {
  @override
  _RegisterIncidenciaScreenState createState() => _RegisterIncidenciaScreenState();
}

class _RegisterIncidenciaScreenState extends State<RegisterIncidenciaScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Aquí se guarda la incidencia
      Provider.of<IncidenciasProvider>(context, listen: false).addIncidencia(
        Incidencia(title: _title, description: _description),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Incidencia'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un título';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Descripción'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una descripción';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveForm,
                child: Text('Guardar Incidencia'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
