import 'package:flutter/material.dart';
import 'package:online_shop_app/models/sneakers_model.dart';
import 'package:online_shop_app/services/helper.dart';

class ProductNotifier extends ChangeNotifier {
  int _activepage = 0;
  List<dynamic> _shoeSizes = [];
  List<String> _sizes = [];
  int get activepage => _activepage;

  set activepage(int newIndex) {
    _activepage = newIndex;
    notifyListeners();
  }

  List<dynamic> get shoeSizes => _shoeSizes;
  set shoeSizes(List<dynamic> newSizes) {
    _shoeSizes = newSizes;
    notifyListeners();
  }

  void toggleCheck(int index) {
    for (int i = 0; i < _shoeSizes.length; i++) {
      if (i == index) {
        _shoeSizes[i]['isSelected'] = !_shoeSizes[i]['isSelected'];
      }
    }
    notifyListeners();
  }

  late Future<List<Sneakers>> male;
  late Future<List<Sneakers>> female;
  late Future<List<Sneakers>> kids;
  late Future<Sneakers> sneakers;
  getMale() {
    male = Helper().getMaleSneakers();
  }

  getFemale() {
    female = Helper().getFemaleSneakers();
  }

  getKids() {
    kids = Helper().getKidsSneakers();
  }

  List<String> get sizes => _sizes;
  set sizes(List<String> newSizes) {
    _sizes = newSizes;
    notifyListeners();
  }

  void getShoes(String category, String id) {
    if (category == "Men's Running") {
      sneakers = Helper().getMaleSneakersById(id);
    } else if (category == "Women's Running") {
      sneakers = Helper().getFemaleSneakersById(id);
    } else {
      sneakers = Helper().getKidsSneakersById(id);
    }
  }
}
