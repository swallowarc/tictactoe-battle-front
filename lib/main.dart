import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe_battle_frontend/routes/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ProviderScope(
      child: MaterialApp(
        title: "TicTacToe Battle",
        theme: ThemeData(
          brightness: Brightness.light,
          fontFamily: "PixelMplus12",
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: "PixelMplus12",
        ),
        initialRoute: '/',
        onGenerateRoute: RouteConfiguration.onGenerateRoute,
      ),
    ),
  );
}
