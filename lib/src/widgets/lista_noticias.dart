import 'package:flutter/material.dart';
import 'package:new_provider/src/theme/tema.dart';

import '../models/news_model.dart';

class ListaNoticias extends StatelessWidget {

  final List<Article> noticias;

  const ListaNoticias({Key? key, required this.noticias}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: noticias.length,
        itemBuilder: (BuildContext context, int index) {
          return _Noticia(noticia: noticias[index],index: index,);

        },
    );
  }
}

class _Noticia extends StatelessWidget {

  final Article noticia;
  final int index;

  const _Noticia({Key? key, required this.noticia, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _TarjetaTopBar(noticia: noticia, index: index),
        _TarjetaTitulo(noticia: noticia),
        _TarjetaImagen(noticia: noticia),
        _TarjetaBody(noticia: noticia),
        _TarjetaBotones(),
        const SizedBox(height: 10,),
        const Divider(),
      ],
    );
  }
}

class _TarjetaBotones extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: () {

            },
            fillColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ),
            child: const Icon(
              Icons.star_border
            ),
          ),
          const SizedBox(width: 10,),

          RawMaterialButton(
            onPressed: () {

            },
            fillColor: Colors.blue,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
            ),
            child: const Icon(
                Icons.more
            ),
          ),
        ],
      ),
    );
  }
}

class _TarjetaBody extends StatelessWidget{

  final Article noticia;

  const _TarjetaBody({super.key, required this.noticia});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text((noticia.description! != null)
          ? noticia.description!
          : ''
      ),
    );
  }
}

class _TarjetaImagen extends StatelessWidget{
  final Article noticia;

  const _TarjetaImagen({super.key, required this.noticia});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
        child: Container(
          child: (noticia.urlToImage != null)
            ? FadeInImage(
              placeholder: const AssetImage('assets/img/giphy.gif'),
              image: NetworkImage(noticia.urlToImage!),
            )
            : const Image(image: AssetImage('assets/img/no-image.png'))
        ),
      ),
    );
  }
}

class _TarjetaTitulo extends StatelessWidget{

  final Article noticia;

  const _TarjetaTitulo({super.key, required this.noticia});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(noticia.title!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700), ),
    );
  }
}

class _TarjetaTopBar extends StatelessWidget {

  final Article noticia;
  final int index;

  const _TarjetaTopBar({Key? key, required this.noticia, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 10),

      child: Row(
        children: [
          Text('${index + 1}. ', style: const TextStyle(color: Colors.red),),
          Text('${noticia.source?.name} ', style: const TextStyle(color: Colors.white),),

        ],
      ),

    );
  }
}


