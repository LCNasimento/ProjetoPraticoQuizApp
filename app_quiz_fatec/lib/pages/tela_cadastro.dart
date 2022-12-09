// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/login_controller.dart';
import '../util.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({Key? key}) : super(key: key);

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  var txtNome = TextEditingController();
  var txtDoc = TextEditingController();
  var txtTel = TextEditingController();
  var txtEmail = TextEditingController();
  var txtSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 25, 0, 25),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      'Criar conta',
                      style: GoogleFonts.roboto(
                        fontSize: 30,
                        color: Colors.blueAccent.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            campoTexto('Nome', Icons.person, txtNome),
            campoTexto('CPF', Icons.document_scanner_outlined, txtDoc),
            campoTexto('Telefone', Icons.phone_android, txtTel),
            campoTexto('E-mail', Icons.email, txtEmail),
            campoTexto('Senha', Icons.lock, txtSenha, senha: true),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                LoginController().criarConta(context, txtNome.text,
                    txtEmail.text, txtSenha.text, txtDoc.text, txtTel.text);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent.shade700,
                minimumSize: Size(MediaQuery.of(context).size.width * 0.9, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: Text(
                'Salvar',
                style: GoogleFonts.roboto(fontSize: 22),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: Text(
                    "Cancelar",
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      color: Colors.blueAccent.shade700,
                    ),
                  ),
                  onPressed: () => {Navigator.pop(context)},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
