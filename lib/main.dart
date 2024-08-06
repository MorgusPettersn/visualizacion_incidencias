import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'incidencias_provider.dart';
import 'register_incidencias.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => IncidenciasProvider()),
      ],
      child: MaterialApp(
        home: RegisterIncidenciaScreen(),
      ),
    );
  }
}

class IncidenciasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final incidenciasProvider = Provider.of<IncidenciasProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Incidencias'),
      ),
      body: FutureBuilder(
        future: incidenciasProvider.fetchIncidencias('example_token', 'example_situacion_id'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: incidenciasProvider.incidencias.length,
              itemBuilder: (context, index) {
                final incidencia = incidenciasProvider.incidencias[index];
                return ListTile(
                  title: Text(incidencia.motivo),
                  subtitle: Text(incidencia.comentario),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IncidenciaDetailScreen(incidencia),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class IncidenciaDetailScreen extends StatelessWidget {
  final Incidencia incidencia;

  IncidenciaDetailScreen(this.incidencia);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(incidencia.motivo),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(incidencia.comentario),
            // Aquí puedes agregar la visualización de la foto y el audio
          ],
        ),
      ),
    );
  }
}
