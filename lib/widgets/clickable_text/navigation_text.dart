import 'package:flutter/material.dart';
import 'package:note_app/theme/colors.dart';

class NavigationText extends StatelessWidget {
  final String normalText;
  final String linkText;
  final void Function()? onTap;
  const NavigationText({
    super.key,
    required this.normalText,
    required this.linkText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Center(
          child: RichText(
              text: TextSpan(
        children: [
          TextSpan(
            text: normalText,
            style: Theme.of(context)
                .primaryTextTheme
                .bodySmall!
                .copyWith(color: AppColors.white),
          ),
          TextSpan(
            text: ' $linkText',
            style: Theme.of(context)
                .primaryTextTheme
                .bodySmall!
                .copyWith(color: Colors.blue),
          ),
        ],
      ))),
    );
  }
}
