import 'package:flutter/material.dart';

class ItemOptions extends StatefulWidget {
  final String title;
  final bool value;
  final bool isEditing;
  final Function(bool) callback;
  ItemOptions({this.title, this.value, this.isEditing, this.callback, Key key})
      : super(key: key);

  @override
  _ItemOptionsState createState() => _ItemOptionsState();
}

class _ItemOptionsState extends State<ItemOptions> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: 
        ((widget.isEditing)||(widget.value)) ?
        Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // AnimatedOpacity(
            //   // If the widget is visible, animate to 0.0 (invisible).
            //   // If the widget is hidden, animate to 1.0 (fully visible).
            //   opacity: (widget.value) ? 1.0 : 0.0,
            //   duration: Duration(milliseconds: 500),

            //   child: 
              Container(
                child: Text(widget.title),
              ),
            // ),
            widget.isEditing
                ? Switch(
                    value: widget.value,
                    onChanged: (bool value) => widget.callback(value),
                  )
                : Container()
          ],
        ),
        AnimatedOpacity(
          opacity: widget.value ? 1.0 : 0.0,
          duration: Duration(milliseconds: 500),
          // The green box must be a child of the AnimatedOpacity widget.
          child: Container(child: Text("+79533571303")),
        ),
      ],
    )
    : Container()
    );
  }
}
