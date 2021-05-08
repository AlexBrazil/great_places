import 'package:Great_Places/widgets/image_input.dart';
import 'package:flutter/material.dart';

class PlaceFormScreen extends StatefulWidget {
  @override
  _PlaceFormScreenState createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  final _titleController = TextEditingController();

  void _submitForm() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Lugar'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Isso faz o botão Adicionar ir para o fim da tela
          Expanded(
            // É para garantir que nada fique oculto se a tela for menor
            // O Botão Adicionar fica fora do SingleChildScrollView, por isso
            // estará sempre na tela
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    // Não vamos usar um Form, mas apenas um TextField
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Título',
                      ),
                    ),
                    SizedBox(height: 10),
                    ImageInput(),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            onPressed: _submitForm,
            icon: Icon(Icons.add),
            label: Text('Adicionar'),
            color: Theme.of(context).accentColor,
            elevation: 0,
            // MaterialTapTargetSize.shrinkWrap - Reduz o tamanho do alvo de toque ao mínimo fornecido pela especificação do material
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          )
        ],
      ),
    );
  }
}
