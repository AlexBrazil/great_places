import 'package:Great_Places/providers/great_places.dart';
import 'package:Great_Places/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Lugares'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.PLACE_FORM);
            },
          )
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: Provider.of<GreatPlaces>(context, listen: false).loadPlaces(),
          builder: (ctx, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Consumer<GreatPlaces>(
                      // Child em consumer é para quando builder não devolver nenhum dado
                      child: Center(
                        child: Text("Nenhum lugar cadastrado"),
                      ),
                      builder: (ctx, greatePlaces, child) =>
                          greatePlaces.itemsCount == 0
                              ? child
                              : ListView.builder(
                                  itemCount: greatePlaces.itemsCount,
                                  itemBuilder: (ctx, indice) => ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: FileImage(
                                        greatePlaces.itemByIndex(indice).image,
                                      ),
                                    ),
                                    title: Text(
                                        greatePlaces.itemByIndex(indice).title),
                                    onTap: () {},
                                  ),
                                ),
                    ),
        ),
      ),
    );
  }
}
