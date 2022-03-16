import 'package:flutter/material.dart';
import 'package:lazerpay_flutter/src/const/const.dart';
import 'package:lazerpay_flutter/src/utils/colors.dart';

import 'package:lazerpay_flutter/src/widgets/touchable_opacity.dart';

/// LazerPay Button Widget
class LazerPayButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final bool enabled, isUnderlined;
  final Color? textColor, buttonColor;

  const LazerPayButton({
    required this.title,
    Key? key,
    this.enabled = true,
    this.isUnderlined = false,
    this.onTap,
    this.textColor,
    this.buttonColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: onTap,
      disabled: enabled == false,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Container(
          color: (buttonColor ?? lazerpayBlue)
              .withOpacity(enabled == true ? 1 : 0.3),
          padding: const EdgeInsets.all(18),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontFamily: 'Sohne-Buch',
                package: package,
                fontSize: 16,
                color: textColor ?? Colors.white,
                decoration: isUnderlined ? TextDecoration.underline : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
