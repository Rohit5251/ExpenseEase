import 'package:flutter/material.dart';
import 'package:expence_tracker/widget/expenses.dart';

var kColorScheme=ColorScheme.fromSeed(seedColor: Colors.redAccent);

var kDarkColorScheme=ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: Colors.red,
);

void main(){
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        ),

        elevatedButtonTheme:
        ElevatedButtonThemeData(style:
        ElevatedButton.styleFrom(backgroundColor: kDarkColorScheme.primaryContainer,
          foregroundColor: kDarkColorScheme.onPrimaryContainer
        ),
        ),
      ),
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onPrimaryContainer,
            foregroundColor: kColorScheme.primaryContainer,

        ),
          cardTheme: const CardTheme().copyWith(
            color: kColorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),

      ),
          elevatedButtonTheme:
          ElevatedButtonThemeData(style:
          ElevatedButton.styleFrom(backgroundColor: kColorScheme.primaryContainer),),

        textTheme: ThemeData().textTheme.copyWith(
          titleLarge:  TextStyle(
              fontWeight: FontWeight.bold,
              color: kColorScheme.onSecondaryContainer,

          ),
        )
      ),
      themeMode: ThemeMode.system,//default
      home:const Expenses(),
    ),
  );
}