import 'package:flutter/material.dart';

class ContentPage extends StatefulWidget {
  const ContentPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  var listado = [
    Post(1, 'Karen', 'Lorem ipsum dolor sit amet,  tincidunt.'),
    Post(2, 'Kamii', 'Lorem ipsum dolor sit amet, tincidunt.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
          itemCount: listado.length,
          itemBuilder: (context, i) {
            return Card(
                child: Container(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    listado[i].name,
                    style: const TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: const EdgeInsets.all(10.0),
                      padding: const EdgeInsets.all(10.0),
                      color: Colors.deepOrange,
                      alignment: Alignment.center,
                      child: const Text(
                        'First row',
                        style: TextStyle(),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          'assets/imags/img_main.jpg',
                          width: 30,
                        )
                      ],
                    ),
                  ),
                  Text(
                    listado[i].message,
                    style: const TextStyle(fontSize: 11.0),
                  )
                ],
              ),
            ));
          }),
    );
  }
}

class Post {
  late int id;
  late String name;
  late String message;

  Post(this.id, this.name, this.message);
}
