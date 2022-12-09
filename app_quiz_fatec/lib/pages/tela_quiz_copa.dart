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

class TelaQuizCopa extends StatefulWidget {
  const TelaQuizCopa({Key? key}) : super(key: key);

  @override
  State<TelaQuizCopa> createState() => _TelaQuizCopaState();
}

class _TelaQuizCopaState extends State<TelaQuizCopa> {
  // ignore: prefer_final_fields
  List<Question> _questions = [
    Question(
      id: '1',
      title: 'Onde será a copa do mundo 2022 ?',
      options: {
        'EUA': false,
        'Coréia do Sul': false,
        'Austrália': false,
        'Catar': true
      },
    ),
    Question(
      id: '2',
      title: 'Qual será o primeiro jogo ?',
      options: {
        'Catar x Equador': true,
        'Inglaterra x Irã': false,
        'Argentina x Arábia Saudita': false,
        'França x Austrália': false
      },
    ),
    Question(
      id: '3',
      title: 'Qual grupo o Brasil está ?',
      options: {
        'Grupo A': false,
        'Grupo G': false,
        'Grupo H': false,
        'Grupo D': true
      },
    ),
    Question(
      id: '4',
      title: 'Qual desses jogadores não é atacante da seleção brasileira ?',
      options: {
        'Neymar': false,
        'Richarlison': false,
        'Daniel Alves': true,
        'Gabriel Jesus': false
      },
    ),
    Question(
      id: '5',
      title: 'Qual seleção não pertence ao grupo G ?',
      options: {
        'Brasil': false,
        'Sérvia': false,
        'Suiça': false,
        'Portugal': true
      },
    ),
    Question(
      id: '6',
      title: 'Qual desses dias o Brasil tem jogo marcado ?',
      options: {
        '24/11/2022': true,
        '25/11/2022': false,
        '27/11/2022': false,
        '01/12/2022': false
      },
    ),
    Question(
      id: '7',
      title: 'Que dia inicou a copa do mundo 2022 ?',
      options: {
        '18/11/2022': false,
        '22/11/2022': false,
        '20/11/2022': true,
        '24/11/2022': false
      },
    ),
    Question(
      id: '8',
      title: 'Que dia será a final da copa do mundo ?',
      options: {
        '12/12/2022': false,
        '18/12/2022': true,
        '20/12/2022': false,
        '03/12/2022': false
      },
    ),
    Question(
      id: '9',
      title: 'Qual é a premiação para o campeão ?',
      options: {
        'Um trofeu apenas': false,
        '30 milhoes de dólares': false,
        '30 milhoes de dólares e o troféu': false,
        '42 milhoes de dólares e o troféu': true
      },
    ),
    Question(
      id: '10',
      title: 'Quando foi decidido onde seria a copa do mundo 2022 ?',
      options: {
        '02/12/2020': false,
        '13/11/2011': false,
        '02/12/2010': true,
        '15/11/2017': false
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
          child: NextButton(
              ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
