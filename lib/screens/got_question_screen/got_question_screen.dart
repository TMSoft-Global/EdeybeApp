import 'package:edeybe/index.dart';
import 'package:edeybe/screens/got_question_screen/post_question_screen/post_question_screen.dart';
import 'package:edeybe/utils/constant.dart';
import 'package:flutter/material.dart';

class GotQuestionScreen extends StatefulWidget {
  GotQuestionScreen({Key key}) : super(key: key);

  @override
  _GotQuestionScreenState createState() => _GotQuestionScreenState();
}

class _GotQuestionScreenState extends State<GotQuestionScreen> {
  final List questionList = [
    "Do you charge any extra delivery costs? If so, how much ?",
    "To complete my order, I have to use my credit card. How secure is my information ?",
    "Can I make an online order by using HSBC visa card without being register with \"Verified By Visa\" ?",
    "What happens if you make the delivery to the incorrect address?",
  ];
  int expandedTile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        iconTheme: Get.theme.iconTheme.copyWith(color: Colors.white),
        automaticallyImplyLeading: true,
        title: Text(S.of(context).QNA, style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Get.to(PostQuestionScreen());
            },
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) => _buildQuestionCard(
            questionList[index],
            """Your Visa, Master and American Express payments are going through secure payment gateways operated by the respective banks. Your card details will be securely transmitted to the Bank for transaction authorization using SSL 128bit encryption."""),
        itemCount: questionList.length,
      ),
    );
  }

  // build question card
  Widget _buildQuestionCard(String title, String content) {
    return Container(
      padding: EdgeInsets.all(10.w),
      margin: EdgeInsets.all(10.w),
      decoration: BoxDecoration(boxShadow: <BoxShadow>[
        BoxShadow(
            blurRadius: 3.4.w,
            offset: Offset(0, 3.4.w),
            color: Constants.boxShadow)
      ], borderRadius: BorderRadius.circular(8.w), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.w),
              )),
          Padding(
            padding: EdgeInsets.all(10.w),
            child: Text(
              content,
              overflow: TextOverflow.ellipsis,
              maxLines: 6,
              style: TextStyle(fontSize: 13.w, color: Constants.disabledColor),
            ),
          ),
        ],
      ),
    );
  }
}
