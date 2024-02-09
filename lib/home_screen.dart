import 'package:flutter/material.dart';
import 'package:tic_tac_toe/board_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> boardState = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];
  int player1score = 0;
  int player2score = 0;

  @override
  Widget build(BuildContext context) {
    GameBoardArgs args =ModalRoute.of(context)?.settings.arguments as GameBoardArgs;
    return Scaffold(
      body:  Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
        image: DecorationImage(
        image: AssetImage('assets/background.jpg'),
        fit: BoxFit.cover,
        ),
        ),
        child:Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          args.player1Name,
                          style: const TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),

                    Text('$player1score', style: const TextStyle(fontSize: 20,color: Colors.white)),
                  ],
                ),
                Image.asset("assets/logo.png",height: 170,width: 170,),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          args.player2Name,
                          style: const TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ),
                    ),
                      const SizedBox(height: 10,),

                    Text(" $player2score ",
                        style: const TextStyle(fontSize: 20,color: Colors.white)),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BoardButton(
                  image: boardState[0],
                  onButtonClick: onButtonClick,
                  index: 0,
                ),
                BoardButton(
                  image: boardState[1],
                  onButtonClick: onButtonClick,
                  index: 1,
                ),
                BoardButton(
                  image: boardState[2],
                  onButtonClick: onButtonClick,
                  index: 2,
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BoardButton(
                  image: boardState[3],
                  onButtonClick: onButtonClick,
                  index: 3,
                ),
                BoardButton(
                  image: boardState[4],
                  onButtonClick: onButtonClick,
                  index: 4,
                ),
                BoardButton(
                  image: boardState[5],
                  onButtonClick: onButtonClick,
                  index: 5,
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BoardButton(
                  image: boardState[6],
                  onButtonClick: onButtonClick,
                  index: 6,
                ),
                BoardButton(
                  image: boardState[7],
                  onButtonClick: onButtonClick,
                  index: 7,
                ),
                BoardButton(
                  image: boardState[8],
                  onButtonClick: onButtonClick,
                  index: 8,
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  int counter = 0;

  void onButtonClick(int index) async {
    if (boardState[index].isNotEmpty) {
      return;
    }
    if (counter % 2 == 0) {
      boardState[index] = 'x';
    } else {
      boardState[index] = 'o';
    }
    counter++;
    setState(() {});

    if (checkWinner('x')) {
      player1score += 5;
      await showSymbolWithDelay('X', 1);
      showWinnerDialog('X');
      initBoard();
    } else if (checkWinner('o')) {
      player2score += 5;
      await showSymbolWithDelay('O', 1);
      showWinnerDialog('O');
      initBoard();
    }

    if (counter == 9) {
      showDrawDialog();
      initBoard();
    }
  }

  Future<void> showSymbolWithDelay(String symbol, int seconds) async {
    await Future.delayed(Duration(seconds: seconds));
    boardState = List<String>.filled(boardState.length, symbol);
    setState(() {});
  }
  void showWinnerDialog(String winnerSymbol) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game Over'),
          content: Text('Player $winnerSymbol wins!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showDrawDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game Over'),
          content: const Text('It\'s a draw!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
  bool checkWinner(String symbol) {
    for (int i = 0; i < 9; i += 3) {
      if (boardState[i] == symbol &&
          boardState[i + 1] == symbol &&
          boardState[i + 2] == symbol) {
        return true;
      }
    }
    for (int i = 0; i < 3; i++) {
      if (boardState[i] == symbol &&
          boardState[i + 3] == symbol &&
          boardState[i + 6] == symbol) {
        return true;
      }
    }
    // diagonal
    if (boardState[0] == symbol &&
        boardState[4] == symbol &&
        boardState[8] == symbol) {
      return true;
    }

    if (boardState[2] == symbol &&
        boardState[4] == symbol &&
        boardState[6] == symbol) {
      return true;
    }
    return false;
  }

  void initBoard() {
    setState(() {
      boardState = [
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
      ];
      counter = 0;
    });
  }
}
class GameBoardArgs{
   String player1Name;
   String player2Name;
   GameBoardArgs({required this.player1Name,required this.player2Name,});
}