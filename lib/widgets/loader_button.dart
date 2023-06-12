import 'package:flutter/material.dart';

class LoaderButton extends StatelessWidget {
  final void Function()? onPressed;
  final bool loading;
  final String text;
  final IconData? trailingIcon;
  const LoaderButton({
    super.key,
    required this.onPressed,
    required this.loading,
    required this.text,
    this.trailingIcon,
  });

  Widget getButtonContent() {
    if (loading) {
      return const SizedBox(
        height: 20.0,
        width: 20.0,
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      );
    }
    if (trailingIcon != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text),
          const SizedBox(
            width: 12.0,
          ),
          Icon(trailingIcon),
        ],
      );
    }
    return Text(text);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: loading ? () {} : onPressed,
      child: getButtonContent(),
    );
  }
}
