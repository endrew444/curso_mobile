import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapaView extends StatelessWidget {
  final double latitude;
  final double longitude;

  const MapaView({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    final ponto = LatLng(-22.5796, -47.4014);

    return Scaffold(
      appBar: AppBar(title: const Text("Mapa - Localização Atual")),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: ponto,
          initialZoom: 17,
        ),
        children: [
          TileLayer(
            urlTemplate:
                "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: const ['a', 'b', 'c'],
            userAgentPackageName: 'com.example.registro_ponto',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: ponto,
                width: 40,
                height: 40,
                child: const Icon(
                  Icons.location_pin,
                  color: Colors.red,
                  size: 40,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
