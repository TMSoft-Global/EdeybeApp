
import 'package:flutter/material.dart';

class TileButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const TileButton({Key key, this.title, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).scaffoldBackgroundColor,
        // border: Border.all(width: 0.8, color: Theme.of(context).scaffoldBackgroundColor),
      ),
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(
          title,
          style: TextStyle().copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        onTap: onTap,
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 14,
        ),
      ),
    );
  }
}
