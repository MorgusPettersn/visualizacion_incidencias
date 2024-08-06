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
        home: RegisterIncidencias(),
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
        future: incidenciasProvider.fetchIncidencias(),
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
                  title: Text(incidencia.title),
                  subtitle: Text(incidencia.description),
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
        title: Text(incidencia.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(incidencia.description),
            // Aquí puedes agregar la visualización de la foto y el audio
          ],
        ),
      ),
    );
  }
}
