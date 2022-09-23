import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

import '../models/category_model.dart';
import '../models/news_model.dart';

const _URL_NEWS = 'https://newsapi.org/v2';
const _APIKEY = '5ab1e9082eb14b60a3ad92f748ca2dd5';

class NewsService with ChangeNotifier {


  List<Article> headlines = [];
  String _selectedCategory = 'business';
  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyball, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};


  NewsService() {
    getTopHeadLines();

    categories.forEach((element) {
      categoryArticles[element.name] = [];
    });
  }

  String get selectedCategory => _selectedCategory;

  set selectedCategory (String valor) {
    _selectedCategory = valor;
    getArticlesByCategory(valor);
    notifyListeners();
  }

  List<Article> get getArticulosCategoriaSeleccionada => categoryArticles[selectedCategory]!;

  getTopHeadLines() async {
    var uri = Uri.https('newsapi.org', '/v2/top-headlines',
        {'country': 'ar', 'apiKey': _APIKEY});

    final resp = await http.get(uri);
    final newsResponse = newsResponseFromJson(resp.body);
    headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  getArticlesByCategory(String categoria) async {
    if(categoryArticles[categoria]!.isNotEmpty) {
      return categoryArticles[categoria];
    }
    var uri = Uri.https('newsapi.org', '/v2/top-headlines',
        {'country': 'ar', 'apiKey': _APIKEY, 'category': categoria});

    final resp = await http.get(uri);
    final newsResponse = newsResponseFromJson(resp.body);

    categoryArticles[categoria]!.addAll(newsResponse.articles);

    notifyListeners();
  }
}