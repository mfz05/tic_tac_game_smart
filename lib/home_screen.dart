//!هذا المشروع في المجلد tic_tac_game_smart
//!هو امتداد لنفس المشروع في المجلد tic_tac_game
//!هنا سوف نستمر من حيث توقفنا هناك
//!----------------------------------------------------------------------------

//!هذا درس من دورة فلاتر ل حسن فليح بعنوان Making auto player smart
/*

!الان نريد جعل الجهاز يكون ذكي في اختياراته
حاليا الجهاز غبي في اختياراته لانه يختار مربعات عشوائية
لذلك ممكن ان نضيف شروط كثيرة للعبة في الدالة اوتو بلاي

!الان سوف نواصل شرح باقي الدرس من بعد الدقيقة 10 وماقبلها شرحناه في مجلد المشروع
! tic_tac_game


*/
//!--------------------------------------------------------------------------------

//! الدرس القادم سوف نجعله في مجلد مشروع مستقل اسمه
//! tic_tac_game_responsive
//! وهو جعل التطبيق متجاوب مع الوضع الافقي

import 'package:flutter/material.dart';
import 'game_logic.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String activePlayer = 'X';
  bool gameOver = false;
  int turn = 0;
  String result = '';
  Game game = Game();
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            SwitchListTile.adaptive(
                title: const Text(
                  'Turn on/off two players',
                  style: TextStyle(color: Colors.white, fontSize: 28),
                  textAlign: TextAlign.center,
                ),
                value: isSwitched,
                onChanged: (bool newValue) {
                  setState(() {
                    isSwitched = newValue;
                  });
                }),
            Text(
              "It's $activePlayer turn",
              style: const TextStyle(color: Colors.white, fontSize: 52),
              textAlign: TextAlign.center,
            ),
            Expanded(
                child: GridView.count(
              padding: EdgeInsets.all(16),
              mainAxisSpacing: 8.0,
              childAspectRatio: 1.0,
              crossAxisCount: 3,
              crossAxisSpacing: 8.0,
              children: List.generate(
                  9,
                  (index) => InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: gameOver ? null : () => onTap(index),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).shadowColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: Text(
                                Player.playrX.contains(index)
                                    ? 'X'
                                    : Player.playrO.contains(index)
                                        ? 'O'
                                        : '',
                                style: TextStyle(
                                    color: Player.playrX.contains(index)
                                        ? Colors.blue
                                        : Colors.red,
                                    fontSize: 52)),
                          ),
                        ),
                      )),
            )),
            Text(
              result,
              style: const TextStyle(color: Colors.white, fontSize: 42),
              textAlign: TextAlign.center,
            ),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  Player.playrX = [];
                  Player.playrO = [];
                  activePlayer = 'X';
                  gameOver = false;
                  turn = 0;
                  result = '';
                });
              },
              icon: const Icon(Icons.replay),
              label: const Text('Repeat the game'),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Theme.of(context).splashColor)),
            ),
          ],
        ),
      ),
    );
  }

  onTap(int index) async {
    if ((Player.playrX.isEmpty || !Player.playrX.contains(index)) &&
        (Player.playrO.isEmpty || !Player.playrO.contains(index))) {
      game.playGame(index, activePlayer);
      updateState();

      //هذا شرط استدعاء دالة اوتو بلاي ان از سويتشد لايساوي ترو وجيم اوفر لايساوي ترو التورن لايساوي 9
      //لانه اذا كان ازسويتشد ترو فان اللعب مع منافس اخر وليس مع الجهاز
      //واذا القيم اوفر ترو فان اللعبة انتهت واذا التورن يساوي 9 فان اللعبة انتهت ايضا
      if (!isSwitched && !gameOver && turn != 9) {
        await game.autoPlay(activePlayer);
        updateState();
      }
    }
  }

  void updateState() {
    //الابديت استيت تقوم بتحديث القيم واول خطوة تقوم بتغيير اللاعبين ثم زيادة التيرن بواحد
    setState(() {
      activePlayer = (activePlayer == 'X') ? 'O' : 'X';
      turn++;

      String winnerPlayer = game.checkWinner();
      if (winnerPlayer != '') {
        gameOver = true;
        result = '$winnerPlayer is the winner';
      } else if (!gameOver && turn == 9) {
        result = "It's Draw!";
      }
    });
  }
}
