//gerenciar o relacionamento do modelo firestore (firebase)

import 'dart:io';

import 'package:cinefavorite/models/movie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class MovieFirestoreController {
  //atributos
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  Stream<List<Movie>> getFavoriteMovies() {
    if(currentUser == null) return Stream.value([]);

    return _db
    .collection("usuarios")
    .doc(currentUser!.uid)
    .collection("Favorite Movies")
    .snapshots()
    .map((snapshot) => snapshot.docs.map((doc)=>Movie.fromMap(doc.data())).toList());

  }

  //path e path_provider ( bibliotecas que permiotem acesso as pastas do dispositivo)
  void addFavoriteMovie(Map<String,dynamic> movieData) async{
    //verificar se o filme tem poster (img da capa)
    if(movieData["poster_path"] == null) return;

    final imageUrl = "https://image.tmdb.org/t/p/w500${movieData["poster_path"]}";
    final responseImg = await http.get(Uri.parse(imageUrl));

    //armazenar a img no diretorio do app
    final imgDir = await getApplicationDocumentsDirectory();
    final file = File("${imgDir.path}/${movieData["id"]}.jpg");
    await file.writeAsBytes(responseImg.bodyBytes);

    final movie = Movie(
      id: movieData["id"],
      title: movieData["title"],
      posterPath: file.toString()
    );

   //adc o filme na filestore
   await _db
   .collection("usuarios")
   .doc(currentUser!.uid)
   .collection("favorite_movies")
   .doc(movie.id.toString())
   .set(movie.toMap());
  }

  //delete 

  //update (modificar a nota)
}