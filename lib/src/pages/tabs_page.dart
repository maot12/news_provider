import 'package:flutter/material.dart';
import 'package:new_provider/src/pages/pages.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {

  const TabsPage({super.key});

    @override
    Widget build (BuildContext context) {
        return ChangeNotifierProvider(
          create: (_) => _NavegacionModel(),
          child: const Scaffold (
              body: _Paginas(),
              bottomNavigationBar: _Navegacion(),
          ),
        ); //Scaffold
    }
}

class _Navegacion extends StatelessWidget {
  const _Navegacion({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final navegacionModel  = Provider.of<_NavegacionModel>(context);

    return BottomNavigationBar(
      currentIndex: navegacionModel.paginaActual,
      onTap: (value) => navegacionModel.paginaActual = value,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
          label: 'Noticias'
        ),

        BottomNavigationBarItem(
            icon: Icon(Icons.public),
            label: 'Categorías'
        ),
      ],
    );
  }
}

class _Paginas extends StatelessWidget {
  const _Paginas({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);
    return PageView(
      //physics: const BouncingScrollPhysics(),
      controller: navegacionModel.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: const <Widget>[

        Tab1Page(),

        Tab2Page(),

      ],
    );
  }
}

class _NavegacionModel with ChangeNotifier {

  int _paginaActual = 0;
  final PageController _pageController = PageController(initialPage: 0);

  int get paginaActual => _paginaActual;

  set paginaActual( int valor) {
    _paginaActual = valor;
    _pageController.animateToPage(
        valor,
        duration: const Duration(microseconds: 250),
        curve: Curves.easeInOut);
    notifyListeners();
  }

  PageController get pageController => _pageController;

}