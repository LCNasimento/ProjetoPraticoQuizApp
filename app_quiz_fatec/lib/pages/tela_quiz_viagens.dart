// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';
import '../controller/login_controller.dart';
import '../models/questions_model.dart';
import '../widgets/next_button.dart';
import '../widgets/option_card.dart';
import '../widgets/question_widget.dart';
import '../widgets/result_box.dart';

class TelaQuizViagens extends StatefulWidget {
  const TelaQuizViagens({Key? key}) : super(key: key);

  @override
  State<TelaQuizViagens> createState() => _TelaQuizViagensState();
}

class _TelaQuizViagensState extends State<TelaQuizViagens> {
  // ignore: prefer_final_fields
  List<Question> _questions = [
    Question(
      id: '1',
      title: 'Qual o destino mais procurado no Brasil ?',
      options: {
        'Rio de Janeiro': true,
        'Fernando de Noronha': false,
        'Gramado': false,
        'São Paulo': false
      },
    ),
    Question(
      id: '2',
      title: 'Quantas visitas o cristo redentor recebe anualmente ?',
      options: {
        'cerca de 1milhão': false,
        'cerca de 500 mil': false,
        'cerca de 4 milhões': false,
        'cerca de 2 milhões': true
      },
    ),
    Question(
      id: '3',
      title: 'Qual a cidade mineira do século 18 que mais recebe turistas ?',
      options: {
        'São Thomé das Letras': false,
        'Ouro Preto': true,
        'Tiradentes': false,
        'Poços de Caldas': false
      },
    ),
    Question(
      id: '4',
      title: 'O parque Cataratas do Iguaçu fica na divisa de qual país ?',
      options: {
        'Brasil e Argentina': true,
        'Brasil e Paraguai': false,
        'Brasil e Uruguai': false,
        'Brasil e Bolivia': false
      },
    ),
    Question(
      id: '5',
      title: 'Qual a montanha mais alta do mundo ?',
      options: {
        'Dhaulagirir': false,
        'Mauna Kea': false,
        'Monte Everest': true,
        'Pico da Neblina': false
      },
    ),
    Question(
      id: '6',
      title: 'Onde Fica Machu Picchu ?',
      options: {
        'Colômbia': false,
        'Peru': true,
        'Bolívia': false,
        'Chile': false
      },
    ),
    Question(
      id: '7',
      title: 'Que pais tem formato de uma bota ?',
      options: {
        'Portugal': false,
        'Suécia': false,
        'México ': false,
        'Itália': true
      },
    ),
    Question(
      id: '8',
      title: 'Quantos continentes existem ?',
      options: {'5': false, '4': false, '2': false, '6': true},
    ),
    Question(
      id: '9',
      title: 'Qual a maior floresta tropical do mundo ?',
      options: {
        'Mata atlantica': false,
        'Pampas': false,
        'Floresta Amazônica': true,
        'Pantanal': false
      },
    ),
    Question(
      id: '10',
      title: 'Quais as duas linguas mais faladas no mundo?',
      options: {
        'Inglês e Espanhol': false,
        'Inglês e Alemão': false,
        'Espanhol e Frances': false,
        'Inglês e Mandarim Chinês': true
      },
    ),
  ];

  int index = 0;
  int score = 0;
  bool isPressed = false;
  bool isAlreadySelected = false;
  void nextQuestion(int questionLength) {
    if (index == questionLength - 1) {
    
      showDialog(
          context: context,
          barrierDismissible:
              false, 
          builder: (ctx) => ResultBox(
                result: score, 
                questionLength: questionLength, 
                onPressed: startOver,
              ));
    } else {
      if (isPressed) {
        setState(() {
          index++; 
          isPressed = false;
          isAlreadySelected = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Por favor, selecione uma opção'),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(vertical: 20.0),
        ));
      }
    }
  }


  void checkAnswerAndUpdate(bool value) {
    if (isAlreadySelected) {
      return;
    } else {
      if (value == true) {
        score++;
      }
      setState(() {
        isPressed = true;
        isAlreadySelected = true;
      });
    }
  }


  void startOver() {
    setState(() {
      index = 0;
      score = 0;
      isPressed = false;
      isAlreadySelected = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.black,
        actions: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              'Score: $score',
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
        ],
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
                // Retornar usuário logado
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
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            QuestionWidget(
              indexAction: index, 
              question: _questions[index]
                  .title, 
              totalQuestions: _questions.length, 
            ),
            const Divider(color: neutral),
            const SizedBox(height: 25.0),
            for (int i = 0; i < _questions[index].options.length; i++)
              GestureDetector(
                onTap: () => checkAnswerAndUpdate(
                    _questions[index].options.values.toList()[i]),
                child: OptionCard(
                  option: _questions[index].options.keys.toList()[i],
                  color: isPressed
                      ? _questions[index].options.values.toList()[i] == true
                          ? correct
                          : incorrect
                      : neutral,
                ),
              ),
          ],
        ),
      ),

      
      floatingActionButton: GestureDetector(
        onTap: () => nextQuestion(_questions.length),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: NextButton(// the above function
              ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
