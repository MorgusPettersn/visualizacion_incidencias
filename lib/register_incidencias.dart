import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'incidencias_provider.dart';

// Pantalla para registrar una nueva incidencia
class RegisterIncidenciaScreen extends StatefulWidget {
  @override
  _RegisterIncidenciaScreenState createState() => _RegisterIncidenciaScreenState();
}
  // Método para guardar el formulario
class _RegisterIncidenciaScreenState extends State<RegisterIncidenciaScreen> {
  final _formKey = GlobalKey<FormState>();
  String _cedulaDirector = '';
  String _codigoCentro = '';
  String _motivo = '';
  String _fotoEvidencia = '';
  String _comentario = '';
  String _notaVoz = '';
  String _latitud = '';
  String _longitud = '';
  String _fecha = '';
  String _hora = '';
  String _token = '';

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Aquí se guarda la incidencia
      Provider.of<IncidenciasProvider>(context, listen: false).addIncidencia(
        Incidencia(
          cedulaDirector: _cedulaDirector,
          codigoCentro: _codigoCentro,
          motivo: _motivo,
          fotoEvidencia: _fotoEvidencia,
          comentario: _comentario,
          notaVoz: _notaVoz,
          latitud: _latitud,
          longitud: _longitud,
          fecha: _fecha,
          hora: _hora,
          token: _token,
        ),
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
                decoration: InputDecoration(labelText: 'Cédula Director'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la cédula del director';
                  }
                  return null;
                },
                onSaved: (value) {
                  _cedulaDirector = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Código Centro'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el código del centro';
                  }
                  return null;
                },
                onSaved: (value) {
                  _codigoCentro = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Motivo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el motivo';
                  }
                  return null;
                },
                onSaved: (value) {
                  _motivo = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Foto Evidencia'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la foto de evidencia';
                  }
                  return null;
                },
                onSaved: (value) {
                  _fotoEvidencia = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Comentario'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un comentario';
                  }
                  return null;
                },
                onSaved: (value) {
                  _comentario = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Nota de Voz'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una nota de voz';
                  }
                  return null;
                },
                onSaved: (value) {
                  _notaVoz = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Latitud'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la latitud';
                  }
                  return null;
                },
                onSaved: (value) {
                  _latitud = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Longitud'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la longitud';
                  }
                  return null;
                },
                onSaved: (value) {
                  _longitud = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Fecha'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la fecha';
                  }
                  return null;
                },
                onSaved: (value) {
                  _fecha = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Hora'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la hora';
                  }
                  return null;
                },
                onSaved: (value) {
                  _hora = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Token'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el token';
                  }
                  return null;
                },
                onSaved: (value) {
                  _token = value!;
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
