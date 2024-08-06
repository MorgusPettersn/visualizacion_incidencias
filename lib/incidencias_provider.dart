import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Incidencia {
  final String cedulaDirector;
  final String codigoCentro;
  final String motivo;
  final String fotoEvidencia;
  final String comentario;
  final String notaVoz;
  final String latitud;
  final String longitud;
  final String fecha;
  final String hora;
  final String token;

  Incidencia({
    required this.cedulaDirector,
    required this.codigoCentro,
    required this.motivo,
    required this.fotoEvidencia,
    required this.comentario,
    required this.notaVoz,
    required this.latitud,
    required this.longitud,
    required this.fecha,
    required this.hora,
    required this.token,
  });

  factory Incidencia.fromJson(Map<String, dynamic> json) {
    return Incidencia(
      cedulaDirector: json['cedula_director'],
      codigoCentro: json['codigo_centro'],
      motivo: json['motivo'],
      fotoEvidencia: json['foto_evidencia'],
      comentario: json['comentario'],
      notaVoz: json['nota_voz'],
      latitud: json['latitud'],
      longitud: json['longitud'],
      fecha: json['fecha'],
      hora: json['hora'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cedula_director': cedulaDirector,
      'codigo_centro': codigoCentro,
      'motivo': motivo,
      'foto_evidencia': fotoEvidencia,
      'comentario': comentario,
      'nota_voz': notaVoz,
      'latitud': latitud,
      'longitud': longitud,
      'fecha': fecha,
      'hora': hora,
      'token': token,
    };
  }
}

class IncidenciasProvider with ChangeNotifier {
  List<Incidencia> _incidencias = [];
  List<String> _historial = [];

  List<Incidencia> get incidencias => _incidencias;
  List<String> get historial => _historial;

  // URL base de tu API
  final String baseUrl = 'https://example.com/api';

  Future<void> fetchIncidencias(String token, String situacionId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/detalle_visita'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'token': token,
        'situacion_id': situacionId,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['exito']) {
        _incidencias = (data['datos'] as List)
            .map((item) => Incidencia.fromJson(item))
            .toList();
        notifyListeners();
      } else {
        throw Exception('Error fetching incidencias: ${data['mensaje']}');
      }
    } else {
      throw Exception('Failed to load incidencias');
    }
  }

  void addIncidencia(Incidencia incidencia) async {
    final response = await http.post(
      Uri.parse('$baseUrl/reportar_visita'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(incidencia.toJson()),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['exito']) {
        _incidencias.add(incidencia);
        notifyListeners();
      } else {
        throw Exception('Error adding incidencia: ${data['mensaje']}');
      }
    } else {
      throw Exception('Failed to add incidencia');
    }
  }

  void addTokenToHistorial(String token) {
    _historial.add(token);
    notifyListeners();
  }

  Future<void> sendTokenToAPI(String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/enviar_token'),
      body: {'token': token},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to send token');
    }
  }

  void clearAllRecords() {
    _incidencias.clear();
    _historial.clear();
    notifyListeners();
  }
}
