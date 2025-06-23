import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapaHectarea extends StatelessWidget {
  const MapaHectarea({super.key});

  @override
  Widget build(BuildContext context) {
    final List<LatLng> posicionesTap = [
      LatLng(-35.4264 + 0.03, -71.6554 + 0.03),
      LatLng(-35.4264 - 0.03, -71.6554 + 0.035),
      LatLng(-35.4264 + 0.035, -71.6554 - 0.035),

      LatLng(-35.0710 + 0.03, -71.2636 + 0.03),
      LatLng(-35.0710 - 0.035, -71.2636 - 0.035),
      LatLng(-35.0710 + 0.035, -71.2636 - 0.04),

      LatLng(-35.8430 + 0.03, -71.5917 + 0.03),
      LatLng(-35.8430 - 0.035, -71.5917 - 0.04),
      LatLng(-35.8430 + 0.04, -71.5917 - 0.035),
    ];
    final List<CircleMarker> zonasCirculares = [
      CircleMarker(
        point: LatLng(-35.4264 + 0.03, -71.6554 + 0.03),
        color: Colors.red.withOpacity(0.4),
        borderStrokeWidth: 2,
        borderColor: Colors.red,
        radius: 30,
      ),
      CircleMarker(
        point: LatLng(-35.4264 - 0.03, -71.6554 + 0.035),
        color: Colors.red.withOpacity(0.4),
        borderStrokeWidth: 2,
        borderColor: Colors.red,
        radius: 30,
      ),
      CircleMarker(
        point: LatLng(-35.4264 + 0.035, -71.6554 - 0.035),
        color: Colors.red.withOpacity(0.4),
        borderStrokeWidth: 2,
        borderColor: Colors.red,
        radius: 30,
      ),

      CircleMarker(
        point: LatLng(-35.0710 + 0.03, -71.2636 + 0.03),
        color: Colors.red.withOpacity(0.4),
        borderStrokeWidth: 2,
        borderColor: Colors.red,
        radius: 30,
      ),
      CircleMarker(
        point: LatLng(-35.0710 - 0.035, -71.2636 - 0.035),
        color: Colors.red.withOpacity(0.4),
        borderStrokeWidth: 2,
        borderColor: Colors.red,
        radius: 30,
      ),
      CircleMarker(
        point: LatLng(-35.0710 + 0.035, -71.2636 - 0.04),
        color: Colors.red.withOpacity(0.4),
        borderStrokeWidth: 2,
        borderColor: Colors.red,
        radius: 30,
      ),
      CircleMarker(
        point: LatLng(-35.8430 + 0.03, -71.5917 + 0.03),
        color: Colors.red.withOpacity(0.4),
        borderStrokeWidth: 2,
        borderColor: Colors.red,
        radius: 30,
      ),
      CircleMarker(
        point: LatLng(-35.8430 - 0.035, -71.5917 - 0.04),
        color: Colors.red.withOpacity(0.4),
        borderStrokeWidth: 2,
        borderColor: Colors.red,
        radius: 30,
      ),
      CircleMarker(
        point: LatLng(-35.8430 + 0.04, -71.5917 - 0.035),
        color: Colors.red.withOpacity(0.4),
        borderStrokeWidth: 2,
        borderColor: Colors.red,
        radius: 30,
      ),
    ];
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xFF708070)),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(-35.5, -71.5), // Centro aproximado Región del Maule
          zoom: 10.0,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: const ['a', 'b', 'c'],
          ),
          CircleLayer(circles: zonasCirculares),
          MarkerLayer(
            markers: posicionesTap.map((pos) {
              return Marker(
                point: pos,
                width: 60,
                height: 60,
                builder: (context) {
                  return GestureDetector(
                    onTap: () {
                      print(
                        'Tap detectado en zona: ${pos.latitude}, ${pos.longitude}',
                      );
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Precaución'),
                          content: Text(
                            'Zona de riesgo. Se recomienda no plantar cultivos aquí.',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Cerrar'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(
                          0.1,
                        ), // Color muy tenue para ver el área
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.circle,
                        size: 20,
                        color: Colors.redAccent,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
