import 'package:edeybe/index.dart';
import 'package:edeybe/utils/constant.dart';
import 'package:flutter/material.dart';

class HelpScreen extends StatefulWidget {
  HelpScreen({Key key}) : super(key: key);

  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final List helpList = [
    "How to Shop?",
    "How to register your Andriod Mobile Token Card on App ?",
    "How to edit your information?",
    "How to save your shopping cart?",
    "How to view your saved shop carts?",
    "How to retrieve your password?"
  ];
  int expandedTile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        iconTheme: Get.theme.iconTheme.copyWith(color: Colors.white),
        automaticallyImplyLeading: true,
        title: Text(S.of(context).help, style: TextStyle(color: Colors.white)),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) => ExpansionTile(
          onExpansionChanged: (isExpanded) {
            setState(() {
              if (isExpanded)
                expandedTile = index;
              else
                expandedTile = null;
            });
          },
          leading: Icon(
            expandedTile == index ? Icons.remove_circle : Icons.add_circle,
            color: Constants.mainColor,
          ),
          title: Text(helpList[index]),
          trailing: SizedBox.shrink(),
          children: <Widget>[
            Container(
              child: Text("""Your Visa, Master and American Express
payments are going through secure payment
gateways operated by the respective banks.
Your card details will be securely transmitted
to the Bank for transaction authorization
using SSL 128bit encryption."""),
            )
          ],
        ),
        itemCount: helpList.length,
      ),
    );
  }
}
