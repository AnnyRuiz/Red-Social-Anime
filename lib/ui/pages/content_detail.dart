// Ejecutar en DartPad
// https://www.dartpad.dev/
import 'package:flutter/material.dart';

// Metodo principal de una Aplicacion en Flutter
void main() {
  // Declaracion de Lista
  var listado = ["Tarjeta 1", "Tarjeta 2", "Tarjeta 3", "Tarjeta 4"];
  // Un metodo utilizado por un boton
  void _noHaceNada() {}
  // Metodo que inicia un Widget (Componente)
  var scaffold = Scaffold(
    // Atributo Barra superior del Widget Scaffold
    appBar: AppBar(
      title: const Text("Hola Munto Titulo"),
    ),
    // Atributo Contenido del Widget Scaffold
    body: ListView.builder(
        itemCount: listado.length,
        itemBuilder: (context, i) {
          return Card(
              color: Colors.white10,
              child: Padding(
                  padding: const EdgeInsets.all(20), child: Text(listado[i])));
        }),

    // Atributo Boton Flotante del Widget Scaffold
    floatingActionButton: FloatingActionButton(
      onPressed: _noHaceNada,
      tooltip: 'Hola Mundo Boton Flotante',
      child: const Icon(Icons.add),
    ),
  );
  runApp(
      // Widget raiz de toda la aplicacion
      MaterialApp(
    debugShowCheckedModeBanner: true,
    // Widget con la estructura base de una app
    home: scaffold,
  ));
}
