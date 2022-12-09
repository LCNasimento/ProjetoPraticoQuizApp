// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/login_controller.dart';

class TelaAssunto extends StatefulWidget {
  const TelaAssunto({Key? key}) : super(key: key);

  @override
  State<TelaAssunto> createState() => _TelaAssuntoState();
}

class _TelaAssuntoState extends State<TelaAssunto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Row(
          children: [
            Expanded(
              child: Text(
                'Quiz Time Fatec',
                style: GoogleFonts.kanit(
                  fontSize: 25,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.account_box,
                  size: 14,
                ),

                //
                // TODO: Retornar usuário logado
                //
                FutureBuilder<String>(
                  future: LoginController().retornarUsuarioLogado(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      if (snapshot.hasError) {
                        return const Text('Error');
                      } else if (snapshot.hasData) {
                        return Text(
                          snapshot.data.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                          ),
                        );
                      } else {
                        return const Text('Empty data');
                      }
                    } else {
                      return Text('State: ${snapshot.connectionState}');
                    }
                  },
                ),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            tooltip: 'sair',
            onPressed: () {
              LoginController().logout();
              Navigator.pushNamedAndRemoveUntil(
                context,
                't2',
                (Route<dynamic> route) => false,
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 158, 154, 163),
      body: Padding(
          padding: const EdgeInsets.all(60),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                    Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Temas disponíveis:', style: TextStyle(fontSize: 50))),
                ElevatedButton(
                  onPressed: () {
                    print('pressionado 1');
                    Navigator.pushNamed(context, 't6');
                  },
                  child: Text('Viagens', style: TextStyle(fontSize: 30)),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 16, 0, 19),
                    padding: EdgeInsets.fromLTRB(100, 20, 100, 20),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    print('pressionado 2');
                    Navigator.pushNamed(context, 't5');
                  },
                  child: Text('Copa do Mundo 2022',
                      style: TextStyle(fontSize: 30)),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 16, 0, 19),
                    padding: EdgeInsets.fromLTRB(100, 20, 100, 20),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  //child: ElevatedButton(
                  //  onPressed: () {
                   //   print('pressionado 5');
                  //    Navigator.popAndPushNamed(context, 't2');
                  //  },
                  //  child: Text('Voltar', style: TextStyle(fontSize: 10)),
                 //   style: ElevatedButton.styleFrom(
                   //   primary: Color.fromARGB(255, 16, 0, 19),
                    //  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                   // ),
                  //),
                ),
                
              ],
            ),
          ),
        ),
    );
  }
}
