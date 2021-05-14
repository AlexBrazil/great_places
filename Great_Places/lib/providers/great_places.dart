import 'dart:io';
import 'dart:math';

import 'package:Great_Places/utils/db_util.dart';
import 'package:flutter/cupertino.dart';
import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  Future<void> loadPlaces() async {
    // Aqui receberemos uma lista de Map's com os dados de SQLite
    final dataList = await DbUtil.getData('places');
    // Aqui converteremos a lista de Map's em uma lista de Places
    _items = dataList
        .map((itemDeMap) => Place(
              id: itemDeMap['id'],
              title: itemDeMap['title'],
              image: File(itemDeMap['image']),
              location: null,
            ))
        .toList();
    notifyListeners();
  }

  List<Place> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Place itemByIndex(int index) {
    return _items[index];
  }

  void addPlace(String title, File image) {
    final newPlace = Place(
      id: Random().nextDouble().toString(),
      title: title,
      image: image,
      location: null,
    );
    _items.add(newPlace);
    DbUtil.insert(
      'places',
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path,
      },
    );
    notifyListeners();
  }
}
