import 'package:edeybe/controllers/user_controller.dart';
import 'package:edeybe/index.dart';
import 'package:edeybe/utils/ratingStars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RationgDialog extends StatefulWidget {
  final String productname;
  final String productID;
  final String transID;
  RationgDialog({this.productname, this.productID, this.transID});

  @override
  _RationgDialogState createState() => _RationgDialogState();
}

class _RationgDialogState extends State<RationgDialog> {
  UserController _userController = Get.find<UserController>();
  final commentController = TextEditingController();

  bool isShowComment = false;
  double rateNumber = 0.0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:8.0),
          child: Text(
            "${widget.productname}",
            textAlign:TextAlign.center ,
            style: Get.theme.textTheme.subtitle1,
          ),
        ),
        Divider(),
        SizedBox(
          height: 10,
        ),
        ratingStar(
          rate: 0,
          function: (v) {
            setState(() {
              isShowComment = true;
              rateNumber = v;
            });
          },
          size: 25,
        ),
        SizedBox(
          height: 5,
        ),
        Text("$rateNumber"),
        SizedBox(
          height: 5,
        ),
        Visibility(
          visible: isShowComment,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text("Comment"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: commentController,
                          // focusNode: commentFocus,
                          maxLines: 2,
                          minLines: 2,
                          decoration: InputDecoration(
                              //  hintText: "Optional Comment",
                              // labelText: "Optional Comment",
                              border: InputBorder.none),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: SizedBox(
                  width: double.infinity,
                  // ignore: deprecated_member_use
                  child: OutlineButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel",
                        style: TextStyle(color: Get.theme.primaryColor)),
                    borderSide: BorderSide(color: Get.theme.primaryColorDark),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: double.infinity,
                  child: CupertinoButton(
                    onPressed: () {
                      _userController.postCommentAndRate(
                        widget.productID,
                        commentController.text,
                        rateNumber,
                        widget.transID);
                    },
                    child: Text("Save", style: TextStyle(color: Colors.white)),
                    color: Get.theme.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

Future<void> androidSelectCity({var title, BuildContext context}) async {
  switch (await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: <Widget>[
            RationgDialog(
              productname: title.productName,
              productID: title.productId,
              transID: title.transactionId,
            )
          ],
        );
      })) {
  }
}

String ratintStars = "0";
Future<void> ratingDialog({
  @required BuildContext context,
  @required String star,
  @required Function(double rate) submit,
  @required TextEditingController commentController,
  @required FocusNode commentFocus,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return RationgDialog();
    },
  );
}

Future<void> iosRatingDialog({
  @required BuildContext context,
  @required String star,
  @required String rate,
  @required Function(double rate) submit,
  @required TextEditingController commentController,
  @required FocusNode commentFocus,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text('Why $star Stars?'),
        content: CupertinoTextField(
          controller: commentController,
          focusNode: commentFocus,
          placeholder: "Optional Comment",
          placeholderStyle: TextStyle(color: Colors.grey),
          // labelText: "Optional Comment",
          minLines: 4,
          maxLines: 4,
          // inputType: TextInputType.text,
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text('Skip'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          CupertinoDialogAction(
            child: Text('Save'),
            onPressed: () => submit(double.parse(star)),
          ),
        ],
      );
    },
  );
}
