import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final bool loading;

  const CustomButton({
    super.key,
    this.text = "",
    this.onTap,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading ? null : onTap ?? () {},
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.buttonColors,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: loading
              ? const CircularProgressIndicator()
              : Text(
                  text,
                  style:
                      Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                ),
        ),
      ),
    );
  }
}
