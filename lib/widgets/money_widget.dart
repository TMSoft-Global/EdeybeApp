import 'package:flutter/material.dart';
import 'package:edeybe/index.dart';

class MoneyWidget extends StatelessWidget {
  final String currency;
  final double scalefactor;
  final double fontSize;
  final Offset offset;
  final Color color;
  final FontWeight fontWeight;
  final bool currencyFirst;
  final List<TextSpan> children;
  const MoneyWidget(
      {Key key,
      this.currency,
      this.scalefactor,
      this.fontSize,
      this.offset,
      this.fontWeight,
      this.color,
      this.currencyFirst = false,
      this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        if (currencyFirst)
          WidgetSpan(
            child: Transform.translate(
              transformHitTests: true,
              offset: offset ?? Offset(0, 0),
              child: Text(
                "${currency ?? 'GHS'}" + " ",
                //superscript is usually smaller in size
                textScaleFactor: scalefactor ?? 1.0,
                style: TextStyle(
                    fontSize: fontSize ?? 13.w,
                    color: color,
                    fontWeight: fontWeight ?? FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        if (children != null) ...children,
        if (!currencyFirst)
          WidgetSpan(
            child: Transform.translate(
              transformHitTests: true,
              offset: offset ?? Offset(0, 0),
              child: Text(
                "${currency ?? 'GHS'}" + " ",
                //superscript is usually smaller in size
                textScaleFactor: scalefactor ?? 1.0,
                style: TextStyle(
                    fontSize: fontSize ?? 13.w,
                    color: color,
                    fontWeight: fontWeight ?? FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
      ]),
    );
  }
}
