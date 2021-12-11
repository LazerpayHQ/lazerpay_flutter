import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:lazerpay_flutter/src/const/const.dart';
import 'package:lazerpay_flutter/src/utils/colors.dart';
import 'package:lazerpay_flutter/src/widgets/lazerpay_button.dart';
import 'package:lazerpay_flutter/src/widgets/touchable_opacity.dart';

/// LazerPayErrorView States Widget
class LazerPayErrorView extends StatelessWidget {
  final VoidCallback reload;
  final VoidCallback? onClosed;

  const LazerPayErrorView({
    Key? key,
    this.onClosed,
    required this.reload,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 38,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LazerPayHeader(
                onClosed: onClosed,
                showClose: true,
              ),
            ],
          ),
        ),
        Flexible(
          child: ListView(
            padding: const EdgeInsets.all(16),
            physics: const BouncingScrollPhysics(),
            children: [
            
              const Gap(45),
              const Center(
                child: Text(
                  'Something went wrong',
                  style: TextStyle(
                    fontFamily: 'Sohne-Buch',
                    package: package,
                    fontSize: 24,
                    color: lazerpayBoldTextColor,
                  ),
                ),
              ),
              const Gap(14),
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Please check your internet connection',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Sohne-Buch',
                      package: package,
                      fontSize: 15,
                      color: lazerpayTextColor,
                    ),
                  ),
                ),
              ),
              const Gap(32),
              LazerPayButton(
                title: 'Reload',
                buttonColor: Colors.white,
                textColor: lazerpayBlue,
                isUnderlined: true,
                onTap: reload,
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Powered by',
              style: TextStyle(
                fontFamily: 'Sohne-Buch',
                package: package,
                fontSize: 14,
                color: lazerpayLightTextColor,
              ),
            ),
            const Gap(4),
            SvgPicture.asset(
              'assets/images/logo.svg',
              package: package,
              height: 18,
            ),
          ],
        ),
        const Gap(32),
      ],
    );
  }
}

/// LazerPay Header Widget
class LazerPayHeader extends StatelessWidget {
  final bool showClose;
  final VoidCallback? onClosed;

  const LazerPayHeader({
    Key? key,
    this.showClose = false,
    this.onClosed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        TouchableOpacity(
          onTap: onClosed ?? () {},
          child: SizedBox(
            height: 40,
            width: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SvgPicture.asset(
                  'assets/images/close.svg',
                  package: package,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
