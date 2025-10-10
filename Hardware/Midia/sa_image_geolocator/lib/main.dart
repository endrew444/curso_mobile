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
              padding: EdgeInsets.all(8),
              itemCount: controller.photos.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (context, i) {
                final photo = controller.photos[i];
                print('Mostrando foto: ${photo.file.path}');
                return Card(
                  child: Column(
                    children: [
                      Expanded(child: Image.file(photo.file, fit: BoxFit.cover)),
                      Padding(
                        padding: EdgeInsets.all(4),
                        child: Text(photo.date, style: TextStyle(fontSize: 12)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(4),
                        child: Text(photo.coords, style: TextStyle(fontSize: 11)),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}