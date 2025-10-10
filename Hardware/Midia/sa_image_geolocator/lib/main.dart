import 'package:flutter/material.dart';
import 'models/photo_model.dart';
import 'controllers/photo_controller.dart';

void main() {
  runApp(MaterialApp(home: MyHomePage()));
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PhotoController controller = PhotoController();

  void _addPhoto(PhotoInfo photo) {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fotos com Localização')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final photo = await controller.takePhoto();
          if (photo != null) setState(() {});
        },
        child: Icon(Icons.camera_alt),
      ),
      body: controller.photos.isEmpty
          ? Center(child: Text('Nenhuma foto ainda'))
          : GridView.builder(
              itemCount: controller.photos.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // ou 1, como preferir
              ),
              itemBuilder: (context, i) {
                final photo = controller.photos[i]; 
                return Card(
                  child: Column(
                    children: [
                      Expanded(child: Image.file(photo.file)),
                      Text(photo.date),
                      Text(photo.coords),
                    ],
                  ),
                );
              },
            ),
    );
  }
}