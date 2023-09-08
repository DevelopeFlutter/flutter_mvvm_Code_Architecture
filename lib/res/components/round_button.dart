import 'package:flutter/material.dart';
import 'package:flutter_mvvm/res/color.dart';

class RoundButton extends StatelessWidget {
  const RoundButton(
      {required this.title,
      this.loading = false,
      required this.onPress,
      Key? key})
      : super(key: key);
  final String title;
  final bool loading;
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 40,
        width: 200,
        decoration: BoxDecoration(
            color: AppColor.buttonColor,
            borderRadius: BorderRadius.circular(10)),
        child: Center(
            child: loading
                ? const CircularProgressIndicator(color: Colors.white,)
                : Text(
                    title,
                    style: const TextStyle(color: AppColor.whiteColor),
                  )),
      ),
    );
  }
}
