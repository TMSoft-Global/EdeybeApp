import 'package:edeybe/controllers/product_controller.dart';
import 'package:edeybe/controllers/user_controller.dart';
import 'package:edeybe/index.dart';
import 'package:edeybe/utils/constant.dart';
import 'package:edeybe/widgets/start_rating.dart';

import 'package:flutter/material.dart';

class WriteReviewScreen extends StatefulWidget {
  WriteReviewScreen({Key key}) : super(key: key);

  @override
  _WriteReviewScreenState createState() => _WriteReviewScreenState();
}

class _WriteReviewScreenState extends State<WriteReviewScreen> {
  final TextEditingController _reviewMessageCtrl = TextEditingController();
  final _userController = Get.find<UserController>();
  final _productController = Get.find<ProductController>();
  final int maxMsg = 100;
  double rating = 0.0;

  _ratingChange(double rate) {
    setState(() {
      rating = rate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Get.theme.iconTheme.copyWith(color: Colors.black),
        automaticallyImplyLeading: true,
        elevation: 0.0,
        centerTitle: true,
        title: Text(S.of(context).writeAReview),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
      ),
      bottomNavigationBar: rating > 0
          ? Container(
              padding: EdgeInsets.all(10.w),
              height: 85.w,
              child: Center(
                widthFactor: 1.w,
                child: Container(
                  width: Get.width,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.w)),
                      backgroundColor: Get.theme.primaryColor,
                      // disabledColor: Constants.themeGreyLight,
                      onSurface: Get.theme.primaryColor.withOpacity(0.5.w),
                    ),
                    child: Text(
                      "${S.of(context).writeReview.toUpperCase()}",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () => _productController.writeReview(
                        rating, _reviewMessageCtrl.text),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      top: BorderSide(
                    color: Colors.grey[200],
                    width: 1.0.w,
                  ))),
            )
          : null,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(bottom: 20.w),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    blurRadius: 3.4.w,
                    offset: Offset(0, 3.4.w),
                    color: Constants.boxShadow)
              ],
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24.w),
                  bottomRight: Radius.circular(24.w))),
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    width: Get.width / 4.5.w,
                    height: Get.width / 4.5.w,
                    child: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                          "https://ae.edeybe.com/en/pub/media/wysiwyg/home-v4/Egypt_slider_mobile_EN-min.jpg"),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      "${_userController.user?.firstname} ${_userController.user?.lastname}",
                      style: TextStyle(
                          fontSize: 20.w, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  StarRating(
                    onRatingChanged: _ratingChange,
                    allowHalfRating: false,
                    rating: rating,
                    size: 30.w,
                    starCount: 5,
                    color: Constants.ratingBG,
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20.w),
                    margin: EdgeInsets.only(bottom: 20.w),
                    width: Get.width,
                    height: Get.height / 4.h,
                    child: TextField(
                      textAlign: TextAlign.start,
                      maxLength: maxMsg,
                      maxLines: 10,
                      minLines: 10,
                      // expands: true,
                      onChanged: (text) {
                        setState(() {});
                      },
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(fontSize: 14.w),
                      decoration: InputDecoration(
                          alignLabelWithHint: true,
                          hintText: S.of(context).enterYourReviewMessage,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                    Constants.themeGreyLight.withOpacity(.2.w),
                              ),
                              borderRadius: BorderRadius.circular(5.w)),
                          contentPadding: EdgeInsets.all(20.w)),
                      controller: _reviewMessageCtrl,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
