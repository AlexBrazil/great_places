import 'package:Great_Places/models/place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isReafyOnly;

  MapScreen({
    // Vamos usar como coornenadas padrão da sede da Google
    // Um valor definido em tempo de compilação precisa ser uma constante
    this.initialLocation = const PlaceLocation(
      latitude: 37.419857,
      longitude: -122.078827,
    ),
    this.isReafyOnly = false,
  });
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedPosition;

  void _selectPosition(LatLng position) {
    setState(() {
      _pickedPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Selecione..."),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: 13.0,
        ),
        onTap: widget.isReafyOnly ? null : _selectPosition,
        // Aqui usamos uma coleção do tipo SET, a qual não aceita repetição
        markers: _pickedPosition == null
            ? null
            : {
                Marker(
                  markerId: MarkerId('p1'),
                  position: _pickedPosition,
                ),
              },
      ),
    );
  }
}
