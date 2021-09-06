import 'package:edeybe/index.dart';
import 'package:edeybe/utils/constant.dart';
import 'package:flutter/material.dart';

class SetCurrencyScreen extends StatefulWidget {
  SetCurrencyScreen({Key key}) : super(key: key);

  @override
  _SetCurrencyScreenState createState() => _SetCurrencyScreenState();
}

class _SetCurrencyScreenState extends State<SetCurrencyScreen> {
  final List currency = [
    {"name": "GHS", "desc": "Ghana Cedis"},
    {"name": "USD", "desc": "United States Dollar"}
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Get.theme.iconTheme.copyWith(color: Colors.white),
        automaticallyImplyLeading: true,
        elevation: 0.0,
        centerTitle: true,
        title:
            Text(S.of(context).currency, style: TextStyle(color: Colors.white)),
        brightness: Brightness.dark,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.w),
          alignment: Alignment.topCenter,
          child: Wrap(
            spacing: 20.w,
            runSpacing: 20.w,
            runAlignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            children: currency.map(_buildCurrencyCard).toList(),
          ),
        ),
      ),
    );
  }

  // currency builder
  Widget _buildCurrencyCard(data) {
    return InkWell(
      child: Container(
          width: Get.width.w / 2.4.w,
          height: Get.height.h / 3.0.h,
          padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 8.w),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    blurRadius: 3.4.w,
                    offset: Offset(0, 3.4.w),
                    color: Constants.boxShadow)
              ],
              borderRadius: BorderRadius.all(Radius.circular(10.w))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                    alignment: Alignment.center,
                    // margin: EdgeInsets.only(bottom: 20.w),
                    child: Icon(Icons.check_circle,
                        size: 60.w, color: Get.theme.primaryColor)),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Container(
                        // margin: EdgeInsets.only(bottom: 8.w),
                        child: Text(
                      data["name"],
                      style: TextStyle(
                          fontSize: 20.w, fontWeight: FontWeight.bold),
                    )),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Text(
                          data["desc"],
                          style: TextStyle(
                              fontSize: 15.w,
                              color: Constants.themeGreyDark,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        )),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
