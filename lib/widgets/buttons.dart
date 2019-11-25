import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final VoidCallback _onPressed;
  final String caption;

  MainButton({Key key, VoidCallback onPressed, String caption})
      : _onPressed = onPressed,
      caption = caption,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      onPressed: _onPressed,
      child: Text(caption),
    );
  }
}
