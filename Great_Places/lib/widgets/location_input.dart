import 'package:Great_Places/Screens/map_screen.dart';
import 'package:Great_Places/utils/location_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  // Quem vai fornecer a _previewImageUrl é a API do Google
  String _previewImageUrl;

  Future<void> _getCurrentUserLocation() async {
    final locData = await Location().getLocation();

    final staticMapImageUrl = LocationUtil.generateLocationPreviewImage(
      latitude: locData.latitude,
      longitude: locData.longitude,
    );
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _selectOnMap() async {
    // Quando fazemosum pop, conseguimos pegar o objeto retornado
    // O objeto retornado é do tipo LatLng e o Dart não consegue inferir,
    // temos que fazer isso
    final LatLng selectedPosition = await Navigator.of(context).push(
      // context é um objeto acessível neste contexto
      // Criando uma rota
      // Se não passarmos os parâmetros de MapScreen ele usaurá os valores
      // padrão do construtor
      MaterialPageRoute(
        // Tira a seta e coloca o "X" para fechar a página
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(),
      ),
    );

    if (selectedPosition == null) return;

    print(selectedPosition.latitude);
    print(selectedPosition.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _previewImageUrl == null
              ? Text('Localização não identificada')
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: Icon(Icons.location_on),
              label: Text("Localização Atual"),
              textColor: Theme.of(context).primaryColor,
            ),
            FlatButton.icon(
              onPressed: _selectOnMap,
              icon: Icon(Icons.map),
              label: Text("Selecione no Mapa"),
              textColor: Theme.of(context).primaryColor,
            )
          ],
        )
      ],
    );
  }
}
