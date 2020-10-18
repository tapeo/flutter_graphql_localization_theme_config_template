import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  Function onPressed;
  String text;
  Color backgroundColor;
  Icon icon;

  Button(
      {@required this.text,
      @required this.onPressed,
      this.backgroundColor,
      this.icon});

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    if (widget.backgroundColor == null) {
      widget.backgroundColor = Theme.of(context).primaryColor;
    }

    return Row(
      children: <Widget>[
        Expanded(
          child: Material(
            borderRadius: BorderRadius.circular(16),
            clipBehavior: Clip.hardEdge,
            color: widget.backgroundColor,
            child: InkWell(
              splashColor: Colors.white.withOpacity(0.5),
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onTap: () {
                widget.onPressed();
              },
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    iconWidget(),
                    Container(width: 8),
                    Flexible(
                      child: Text(
                        widget.text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).accentColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget iconWidget() {
    if (widget.icon == null) return Container();

    return widget.icon;
  }
}
