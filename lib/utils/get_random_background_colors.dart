import 'dart:math';

import '../theme/colors.dart';

getRandomBackgroundColor() {
  Random random = Random();

  return backgroundColors[random.nextInt(backgroundColors.length)];
}
