import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import '../models/photo_model.dart';

class PhotoController {
  final List<PhotoInfo> photos = [];
  final picker = ImagePicker();

  Future<PhotoInfo?> takePhoto() async {
    final XFile? img = await picker.pickImage(source: ImageSource.camera);
    if (img == null) return null;

    // Permissão de localização
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return null;
    }
    if (permission == LocationPermission.deniedForever) return null;

    Position pos = await Geolocator.getCurrentPosition();
    String coords = "${pos.latitude.toStringAsFixed(4)}, ${pos.longitude.toStringAsFixed(4)}";
    String date = DateTime.now().toString().substring(0, 19); // data e hora

    final photo = PhotoInfo(File(img.path), date, coords);
    photos.add(photo);
    
    print('Foto salva: ${img.path}');

    return photo;
  }
}