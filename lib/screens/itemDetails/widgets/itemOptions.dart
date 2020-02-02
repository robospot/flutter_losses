import 'package:flutter/material.dart';
import 'package:custom_switch/custom_switch.dart';

class ItemOptions extends StatefulWidget {
  final String title;
  final bool value;
  final bool isEditing;
  final String contact;
  final Function(bool) callback;
  ItemOptions(
      {this.title,
      this.value,
      this.contact,
      this.isEditing,
      this.callback,
      Key key})
      : super(key: key);

  @override
  _ItemOptionsState createState() => _ItemOptionsState();
}

class _ItemOptionsState extends State<ItemOptions> {
  TextEditingController editController = TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    editController.text = widget.contact;
    return Container(
        child: ((widget.isEditing) || (widget.value))
            ? Column(
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
                          ? 
                        //   Container(
                        //   child: CustomSwitch(
                        //     activeColor: Color(0xFFF1F3F6),
                        //     value: widget.value,
                        //     onChanged: (bool value) => widget.callback(value),
                        //   ),
                        // )
                         

                          Switch(
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
                    child: Container(
                        child: TextField(
                      controller: editController,
                      enabled: widget.isEditing,
                    )),
                  ),
                ],
              )
            : Container());
  }
}
