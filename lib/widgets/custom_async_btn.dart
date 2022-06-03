import 'package:async_button_builder/async_button_builder.dart';
import 'package:flutter/material.dart';

class CustomAsyncBtn extends StatelessWidget {
  const CustomAsyncBtn({
    Key? key,
    required this.btnTxt,
    this.width = double.infinity,
    this.height = 48.0,
    this.btnColor = Colors.indigo,
    this.borderRadius = 6.0,
    required this.onPress,
    this.isDisabled = false,
  }) : super(key: key);

  final String btnTxt;
  final double width;
  final double height;
  final Color btnColor;
  final double borderRadius;
  final Function() onPress;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return AsyncButtonBuilder(
      onPressed: () async {
        await onPress();
      },
      showSuccess: false,
      loadingWidget: const SizedBox(
        height: 16.0,
        width: 16.0,
        child: CircularProgressIndicator(),
      ),
      disabled: isDisabled,
      errorWidget: const Text('Error'),
      builder: (context, child, callback, _) {
        return SizedBox(
          width: width,
          height: height,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(isDisabled ? Colors.grey : btnColor),
              elevation: MaterialStateProperty.all(0.0),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
            ),
            onPressed: callback,
            child: child,
          ),
        );
      },
      child: Text(
        btnTxt,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16.0,
          color: btnColor == Colors.white ? Colors.black87 : Colors.white,
        ),
      ),
    );
  }
}
