import 'package:flutter/material.dart';
import 'package:new_provider/src/pages/pages.dart';
import 'package:new_provider/src/services/news_service.dart';
import 'package:new_provider/src/theme/tema.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => NewsService(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        theme: miTema,
        home: const TabsPage(),
      ),
    );
  }
}
