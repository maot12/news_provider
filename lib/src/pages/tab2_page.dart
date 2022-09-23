import 'package:flutter/material.dart';
import 'package:new_provider/src/models/category_model.dart';
import 'package:new_provider/src/services/news_service.dart';
import 'package:new_provider/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {

  const Tab2Page({super.key});

    @override
    Widget build (BuildContext context) {
      final newsService = Provider.of<NewsService>(context);
        return SafeArea(
          child: Scaffold (
              body: (newsService == null)
              ? const Center(
                child: CircularProgressIndicator(),
              )
              : Column(
                children:  <Widget> [
                  const _ListaCategorias(),

                  Expanded(
                      child: ListaNoticias(noticias: newsService.getArticulosCategoriaSeleccionada)
                  )

                ],
              ) //Center
          ),
        ); //Scaffold
    }
}

class _ListaCategorias extends StatelessWidget {
  const _ListaCategorias({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;
    return Container(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
          itemBuilder: (context, index) {

          final cName = categories[index].name;
            return Padding(
                padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  _CategoryButton(category: categories[index] ),
                  const SizedBox(height: 5,),
                  Text('${cName[0].toUpperCase()}${cName.substring(1)}')
                ],
              ),
            );
          },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {

  final Category category;

  const _CategoryButton({
    Key? key,
    required this.category
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return GestureDetector(
      onTap: () {
        //print(category.name);
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = category.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(
          category.icon,
          color: (newsService.selectedCategory == category.name)
              ? Colors.red
              :Colors.black54,
        ),
      ),
    );
  }
}