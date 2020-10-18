import 'package:flutter_graphql_localization_theme_config_template/theme/theme.dart';
import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  Input(
      {Key key,
      this.title,
      this.subtitle,
      @required this.controller,
      @required this.hint,
      @required this.keyboardType,
      @required this.textCapitalization,
      @required this.maxLines,
      @required this.onValue,
      this.enableValidation,
      this.isValid,
      this.icon,
      this.iconCallback,
      this.backgroundColor,
      this.fontSize,
      this.autofocus,
      this.bold})
      : super(key: key);

  String title;
  String subtitle;
  final TextEditingController controller;
  final String hint;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final int maxLines;
  final IconData icon;
  final Function iconCallback, onValue;
  bool enableValidation, isValid, bold;
  Color backgroundColor;
  double fontSize;
  bool autofocus;

  @override
  Widget build(BuildContext context) {
    FontWeight isBold;
    if (bold == null) {
      isBold = FontWeight.bold;
    } else {
      if (bold) {
        isBold = FontWeight.bold;
      } else {
        isBold = FontWeight.normal;
      }
    }

    if (backgroundColor == null) {
      backgroundColor = Theme.of(context).primaryColor.withOpacity(0.1);
    }

    if (autofocus == null) {
      autofocus = true;
    }

    Widget titleWidget;

    if (title != null) {
      titleWidget = Text(
        title,
        style: TextStyle(
            fontWeight: isBold,
            fontSize: 16,
            color: Theme.of(context).primaryColor),
      );
    } else {
      titleWidget = Container();
    }

    if (fontSize == null) {
      fontSize = 16;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        titleWidget,
        subtitleWidget(),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: new BoxDecoration(
                      color: backgroundColor,
                      borderRadius: new BorderRadius.all(
                          Radius.circular(AppTheme.cardRadius))),
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: controller,
                          onChanged: (value) {
                            onValue(value);
                          },
                          autofocus: autofocus,
                          style: TextStyle(
                              fontSize: fontSize,
                              color: Theme.of(context).primaryColor),
                          keyboardType: keyboardType,
                          maxLines: maxLines,
                          textCapitalization: textCapitalization,
                          decoration: InputDecoration(
                              hintText: hint,
                              hintStyle: TextStyle(
                                  fontSize: fontSize,
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.5)),
                              contentPadding:
                                  EdgeInsets.only(top: 8, bottom: 8),
                              border: InputBorder.none),
//                          decoration: InputDecoration.collapsed(hintText: hint)
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              icon != null
                  ? RawMaterialButton(
                      constraints: BoxConstraints(minWidth: 0),
                      onPressed: () {
                        if (iconCallback != null) {
                          iconCallback();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Icon(
                          icon,
                          size: 24.0,
                        ),
                      ),
                      shape: new CircleBorder(),
                      elevation: 0,
                      highlightElevation: 0,
                      fillColor: Colors.white,
                    )
                  : Container()
            ],
          ),
        ),
      ],
    );
  }

  Widget subtitleWidget() {
    if (subtitle == null) {
      return Container();
    }

    return Text(
      subtitle,
      style: TextStyle(fontSize: 14),
    );
  }
}
