import 'package:edeybe/index.dart';
import 'package:flutter/material.dart';

class TermAndConditonScreen extends StatelessWidget {
  const TermAndConditonScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        iconTheme: Get.theme.iconTheme.copyWith(color: Colors.white),
        automaticallyImplyLeading: true,
        title: Text(S.of(context).tnc, style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text("Product Terms",
                  style:
                      TextStyle(fontSize: 17.w, fontWeight: FontWeight.bold)),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.w),
              child: Text(
                  """Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation.
""",
                  style: TextStyle(fontSize: 14.w)),
            ),
            Container(
              child: Text("1. Use of the Site",
                  style:
                      TextStyle(fontSize: 17.w, fontWeight: FontWeight.bold)),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.w),
              child: Text(
                  """Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation.
\nTHESE TERMS AND CONDITIONS DO NOT AFFECT YOUR STATUTORY RIGHTS.""",
                  style: TextStyle(fontSize: 14.w)),
            ),
            Container(
              child: Text("2. Amendments",
                  style:
                      TextStyle(fontSize: 17.w, fontWeight: FontWeight.bold)),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.w),
              child: Text(
                  """We may revise the terms and conditions from time to time without notice to you.Lorem ipsum dolor sit """,
                  style: TextStyle(fontSize: 14.w)),
            ),
          ],
        ),
      )),
    );
  }
}
