import 'package:async_button_builder/async_button_builder.dart';
import 'package:flutter/material.dart';

class CustomAsyncBtn extends StatelessWidget {
  const CustomAsyncBtn({
    Key? key,
    this.icon,
    required this.btntxt,
    this.width = double.infinity,
    this.height = 48.0,
    this.btnColor,
    this.borderRadius = 6.0,
    required this.onPress,
  }) : super(key: key);

  final Icon? icon;
  final String btntxt;
  final double width;
  final double height;
  final Color? btnColor;
  final double borderRadius;
  final dynamic onPress;

  @override
  Widget build(BuildContext context) {
    return AsyncButtonBuilder(
      child: icon == null
          ? Text(
              btntxt,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
                color: Colors.black87,
              ),
            )
          : Row(
              children: [
                icon!,
                const SizedBox(width: 42.0),
                Text(btntxt, style: Theme.of(context).textTheme.bodyText1),
              ],
            ),
      onPressed: onPress == null
          ? null
          : () async {
              await onPress();
            },
      showSuccess: false,
      loadingWidget: const SizedBox(
        height: 16.0,
        width: 16.0,
        child: CircularProgressIndicator(),
      ),
      errorWidget: const Text('Error'),
      builder: (context, child, callback, _) {
        return SizedBox(
          width: width,
          height: height,
          child: ElevatedButton(
            child: child,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                btnColor ?? Colors.white.withOpacity(0.9),
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
            ),
            onPressed: callback,
          ),
        );
      },
    );
  }
}
