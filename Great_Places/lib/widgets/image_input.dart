import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;
  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  // Faz a captura da câmera
  _takePicture() async {
    final ImagePicker _picker = ImagePicker();
    PickedFile imageFile = await _picker.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    // Se o usuário retornar sem tirar foto
    if (imageFile == null) return;

    setState(() {
      _storedImage = File(imageFile.path);
    });

    // Aqui pegamos a pasta do sistema onde são armazenados os arquivos
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    // Aqui pegaos apenas o nome do arquivo de imagem
    String fileName = path.basename(_storedImage.path);
    // Vamos fazer uma cópia da imagem e gravar no diretório (appDir)
    final savedImage = await _storedImage.copy('${appDir.path}/$fileName');

    // Por meio deste método comunicamos com o formulário em places_form_screen
    // Comunicação indireta. A direta seria pelo construtor da classe
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            alignment: Alignment.center,
            width: 180,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
            ),
            child: _storedImage != null
                ? Image.file(
                    _storedImage,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Text('Nenhuma Imagem!!')),
        SizedBox(width: 10),
        Expanded(
          child: FlatButton.icon(
            onPressed: _takePicture,
            icon: Icon(Icons.camera),
            label: Text('Tirar Foto'),
            textColor: Theme.of(context).primaryColor,
          ),
        )
      ],
    );
  }
}
