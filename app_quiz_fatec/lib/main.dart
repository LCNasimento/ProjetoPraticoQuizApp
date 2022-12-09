// ignore_for_file: prefer_const_constructors

import 'package:app_quiz_fatec/pages/tela_assunto.dart';
import 'package:app_quiz_fatec/pages/tela_boas_vindas.dart';
import 'package:app_quiz_fatec/pages/tela_cadastro.dart';
import 'package:app_quiz_fatec/pages/tela_login.dart';
import 'package:app_quiz_fatec/pages/tela_quiz_copa.dart';
import 'package:app_quiz_fatec/pages/tela_quiz_viagens.dart';
import 'package:app_quiz_fatec/pages/tela_sobre.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Quiz FatecRP',
    initialRoute: 't1',
    routes: {
      't1': (context) => TelaBoasVindas(),
      't2': (context) => TelaLogin(),
      't3': (context) => TelaCadastro(),
      't4': (context) => TelaAssunto(),
      't5': (context) => TelaQuizCopa(),
      't6': (context) => TelaQuizViagens(),
      't7': (context) => TelaSobre(),
    },
  ));
}
