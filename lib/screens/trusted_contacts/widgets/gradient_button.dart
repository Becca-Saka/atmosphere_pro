import 'package:at_common_flutter/services/size_config.dart';
import 'package:atsign_atmosphere_pro/utils/colors.dart';
import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final Widget child;
  const GradientButton({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 59.toHeight,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          ColorConstants.orangeColor,
          ColorConstants.yellowColor,
        ]),
        borderRadius: BorderRadius.circular(10.toWidth),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.toWidth),
          ),
        ),
        onPressed: () {},
        child: child,
      ),
    );
  }
}
