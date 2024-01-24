import 'dart:math';

import 'package:note_app/constants/colors.dart';

getRandomBackgroundColor() {
  Random random = Random();

  return backgroundColors[random.nextInt(backgroundColors.length)];
}
