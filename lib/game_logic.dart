//!هذا المشروع في المجلد tic_tac_game_smart
//!هو امتداد لنفس المشروع في المجلد tic_tac_game
//!هنا سوف نستمر من حيث توقفنا هناك
//!----------------------------------------------------------------------------

//!هذا درس من دورة فلاتر ل حسن فليح بعنوان Making auto player smart
/*

!الان نريد جعل الجهاز يكون ذكي في اختياراته
حاليا الجهاز غبي في اختياراته لانه يختار مربعات عشوائية
لذلك ممكن ان نضيف شروط كثيرة للعبة في الدالة اوتو بلاي
------------------------------------------------------
!اولا هذي الدالة اوتو بلاي قبل اضافة شروط اليها
  Future autoPlay(activePlayer) async {
    int index = 0;

    List<int> emptyCells = [];
    for (var i = 0; i < 9; i++) {
      if ((Player.playrX.contains(i) || Player.playrO.contains(i))) {
        emptyCells.add(i);
      }
    }

    Random random = Random();
    int randomIndex = random.nextInt(emptyCells.length);

    index = emptyCells[randomIndex];
    playGame(index, activePlayer);

  }
-------------------------------------------------------


!الان سوف نواصل شرح باقي الدرس من بعد الدقيقة 10 وماقبلها شرحناه في مجلد المشروع
! tic_tac_game

وضعنا الشروط كلها في الاسفل مع شرحها

*/
//!------------------------------------------------------------------------------

//! الدرس القادم سوف نجعله في مجلد مشروع مستقل اسمه
//! tic_tac_game_responsive
//! وهو جعل التطبيق متجاوب مع الوضع الافقي

import 'dart:math';

class Player {
  static const x = 'X';
  static const o = 'O';
  static const empty = '';

  static List<int> playrX = [];
  static List<int> playrO = [];
}

class Game {
  void playGame(int index, String activePlayer) {
    if (activePlayer == 'X') {
      Player.playrX.add(index);
    } else {
      Player.playrO.add(index);
    }
  }

  Future<void> autoPlay(activePlayer) async {
    int index = 0; //هذا المتغير فيه اندكس المربع الذي يختاره الجهاز

    List<int> emptyCells = []; //هذي اللستة لوضع اندكسات المربعات الفارغة
    for (var i = 0; i < 9; i++) {
      if (!(Player.playrX.contains(i) || Player.playrO.contains(i))) {
        emptyCells.add(i);
      }
    }
    //الان تمت تعبئة اللستة امبتي سيلس باندكسات المربعات الفارغة

    //!سوف نضيف هذي الشروط لجعل الجهاز ذكي في الاختيار
    //سوف نضيف له عقلية الدفاع اي يقفل اذا قرب المنافس يفوز
    //وعقلية الهجوم اي يهجم لكي يفوز ويجعل المنافس هو اللي يدافع

    //هذا مثال لاول شرط دفاعي اذا كان لستة المنافس فيها الاندكس رقم 0و1 اي انه باقي له
    //مربع رقم 2 ويفوز باللعبة و ان لستة امبتي سيلس تحتوي على الاندكس 2
    //اي ان الاندكس 2 فارغ اذا تحقق كل هذا الشرط
    //اذا اجعل الاندكس يساوي 2 اي ان الجهاز يختار المربع رقم 2
    //وهذا مثال لاول شرط هجومي اذا كانت اللستة اوه اللي هي لستة الجهاز تحتوي على
    //الاندكس 0 و 1 اي ان الجهاز باقي له الاندكس رقم 2 ويفوز واذا كانت
    //ايضا لستة الامبتي سيلس تحتوي على الاندكس 2 اي ان المربع 2 فارغ
    //اذا اذهب واختار المربع رقم 2 لانه عندها سوف يفوز الجهاز

    //وخلاف ذلك اي ايلس اختار اي مكان عشوائي فارغ
    //وهكذا قيس عليه كل الاسطر والاعمدة والزوايا سوف نعمل نفس الشرط مع كل
    //صف وكل عمود وكل زاوية

    //!الان هذي الشروط المسؤولة عن الهجوم
    //start-center
    if (Player.playrO.containsAll(0, 1) && emptyCells.contains(2)) {
      index = 2;
    } else if (Player.playrO.containsAll(3, 4) && emptyCells.contains(5)) {
      index = 5;
    } else if (Player.playrO.containsAll(6, 7) && emptyCells.contains(8)) {
      index = 8;
    } else if (Player.playrO.containsAll(0, 3) && emptyCells.contains(6)) {
      index = 6;
    } else if (Player.playrO.containsAll(1, 4) && emptyCells.contains(7)) {
      index = 7;
    } else if (Player.playrO.containsAll(2, 5) && emptyCells.contains(8)) {
      index = 8;
    } else if (Player.playrO.containsAll(0, 4) && emptyCells.contains(8)) {
      index = 8;
    } else if (Player.playrO.containsAll(2, 4) && emptyCells.contains(6)) {
      index = 6;
    }
    //start-end

    else if (Player.playrO.containsAll(0, 2) && emptyCells.contains(1)) {
      index = 1;
    } else if (Player.playrO.containsAll(3, 5) && emptyCells.contains(4)) {
      index = 4;
    } else if (Player.playrO.containsAll(6, 8) && emptyCells.contains(7)) {
      index = 7;
    } else if (Player.playrO.containsAll(0, 6) && emptyCells.contains(3)) {
      index = 3;
    } else if (Player.playrO.containsAll(1, 7) && emptyCells.contains(4)) {
      index = 4;
    } else if (Player.playrO.containsAll(2, 8) && emptyCells.contains(5)) {
      index = 5;
    } else if (Player.playrO.containsAll(0, 8) && emptyCells.contains(4)) {
      index = 4;
    } else if (Player.playrO.containsAll(2, 6) && emptyCells.contains(4)) {
      index = 4;
    }
    //center-end

    else if (Player.playrO.containsAll(1, 2) && emptyCells.contains(0)) {
      index = 0;
    } else if (Player.playrO.containsAll(4, 5) && emptyCells.contains(3)) {
      index = 3;
    } else if (Player.playrO.containsAll(7, 8) && emptyCells.contains(6)) {
      index = 6;
    } else if (Player.playrO.containsAll(3, 6) && emptyCells.contains(0)) {
      index = 0;
    } else if (Player.playrO.containsAll(4, 7) && emptyCells.contains(1)) {
      index = 1;
    } else if (Player.playrO.containsAll(5, 8) && emptyCells.contains(2)) {
      index = 2;
    } else if (Player.playrO.containsAll(4, 8) && emptyCells.contains(0)) {
      index = 0;
    } else if (Player.playrO.containsAll(4, 6) && emptyCells.contains(2)) {
      index = 2;
    }
    //!الان هذي الشروط المسؤولة عن الدفاع
    //start-center------------------------------------------------------

    else if (Player.playrX.containsAll(0, 1) && emptyCells.contains(2)) {
      index = 2;
    } else if (Player.playrX.containsAll(3, 4) && emptyCells.contains(5)) {
      index = 5;
    } else if (Player.playrX.containsAll(6, 7) && emptyCells.contains(8)) {
      index = 8;
    } else if (Player.playrX.containsAll(0, 3) && emptyCells.contains(6)) {
      index = 6;
    } else if (Player.playrX.containsAll(1, 4) && emptyCells.contains(7)) {
      index = 7;
    } else if (Player.playrX.containsAll(2, 5) && emptyCells.contains(8)) {
      index = 8;
    } else if (Player.playrX.containsAll(0, 4) && emptyCells.contains(8)) {
      index = 8;
    } else if (Player.playrX.containsAll(2, 4) && emptyCells.contains(6)) {
      index = 6;
    }
    //start-end

    else if (Player.playrX.containsAll(0, 2) && emptyCells.contains(1)) {
      index = 1;
    } else if (Player.playrX.containsAll(3, 5) && emptyCells.contains(4)) {
      index = 4;
    } else if (Player.playrX.containsAll(6, 8) && emptyCells.contains(7)) {
      index = 7;
    } else if (Player.playrX.containsAll(0, 6) && emptyCells.contains(3)) {
      index = 3;
    } else if (Player.playrX.containsAll(1, 7) && emptyCells.contains(4)) {
      index = 4;
    } else if (Player.playrX.containsAll(2, 8) && emptyCells.contains(5)) {
      index = 5;
    } else if (Player.playrX.containsAll(0, 8) && emptyCells.contains(4)) {
      index = 4;
    } else if (Player.playrX.containsAll(2, 6) && emptyCells.contains(4)) {
      index = 4;
    }
    //center-end

    else if (Player.playrX.containsAll(1, 2) && emptyCells.contains(0)) {
      index = 0;
    } else if (Player.playrX.containsAll(4, 5) && emptyCells.contains(3)) {
      index = 3;
    } else if (Player.playrX.containsAll(7, 8) && emptyCells.contains(6)) {
      index = 6;
    } else if (Player.playrX.containsAll(3, 6) && emptyCells.contains(0)) {
      index = 0;
    } else if (Player.playrX.containsAll(4, 7) && emptyCells.contains(1)) {
      index = 1;
    } else if (Player.playrX.containsAll(5, 8) && emptyCells.contains(2)) {
      index = 2;
    } else if (Player.playrX.containsAll(4, 8) && emptyCells.contains(0)) {
      index = 0;
    } else if (Player.playrX.containsAll(4, 6) && emptyCells.contains(2)) {
      index = 2;
    } else {
      //الان سوف نختار رقم اندكس عشوائي من اللستة امبتي سيلس لكي نجعله اختيار الكمبيوتر
      Random random = Random();
      int randomIndex = random.nextInt(emptyCells.length);

      index = emptyCells[randomIndex];
    }

    playGame(index, activePlayer);
  }

  String checkWinner() {
    String winner = '';

    //الان سوف نستدعي الدالة كونتينس اول على اللستة بلاير اكس بعدد احتمالات الفوز كلها
    if (Player.playrX.containsAll(0, 1, 2) ||
        Player.playrX.containsAll(3, 4, 5) ||
        Player.playrX.containsAll(6, 7, 8) ||
        Player.playrX.containsAll(0, 3, 6) ||
        Player.playrX.containsAll(1, 4, 7) ||
        Player.playrX.containsAll(2, 5, 8) ||
        Player.playrX.containsAll(0, 4, 8) ||
        Player.playrX.containsAll(2, 4, 6)) {
      winner = 'X';
    }
    //الان سوف اكرر هذي الشروط كلها للست بلاير اوه
    else if (Player.playrO.containsAll(0, 1, 2) ||
        Player.playrO.containsAll(3, 4, 5) ||
        Player.playrO.containsAll(6, 7, 8) ||
        Player.playrO.containsAll(0, 3, 6) ||
        Player.playrO.containsAll(1, 4, 7) ||
        Player.playrO.containsAll(2, 5, 8) ||
        Player.playrO.containsAll(0, 4, 8) ||
        Player.playrO.containsAll(2, 4, 6)) {
      winner = 'O';
    } else {
      winner = ''; //في حالة التعادل يرجع فراغ
    }

    return winner;
  }
}

extension ContainsAll on List {
  bool containsAll(int x, int y, [z]) {
    if (z == null) {
      return contains(x) && contains(y);
    } else {
      return contains(x) && contains(y) && contains(z);
    }
  }
}
