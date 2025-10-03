//view para inserir o ponto no map

import 'package:flutter/material.dart';
import 'package:sa_geolocator_maps/controllers/map_controller.dart';
import 'package:sa_geolocator_maps/models/location_points.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  //atributos
  List<LocationPoints> listaPosicoes = [];
  final _mapController = MapController();

  bool _isLoading = false;
  String? _error;


  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}