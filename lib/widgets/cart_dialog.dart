import 'package:edeybe/index.dart';
import 'package:edeybe/utils/cart_item_type.dart';
import 'package:edeybe/utils/constant.dart';
import 'package:flutter/material.dart';

class CartDialog extends StatefulWidget {
  CartDialog(
      {Key key,
      this.productTitle,
      this.cartTotal,
      this.type,
      this.onGoForward,
      this.title})
      : super(key: key);
  final String productTitle;
  final String title;
  final String cartTotal;
  final CartItemType type;
  final VoidCallback onGoForward;
  @override
  _CartDialogState createState() => _CartDialogState();
}

class _CartDialogState extends State<CartDialog>
    with SingleTickerProviderStateMixin {
  AnimationController _animation;
  Animation<Offset> offset;
  @override
  void initState() {
    super.initState();

    _animation = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    offset = Tween<Offset>(
      begin: Offset(0.0, -3.0),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _animation,
      curve: Curves.easeInOut,
    ));
    _animation.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: offset,
      child: GestureDetector(
        onTap: () {
          if (Get.isDialogOpen) Get.back();
        },
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              iconTheme: Get.theme.iconTheme.copyWith(color: Colors.black),
              backgroundColor: Constants.themeGreyLight,
              automaticallyImplyLeading: true,
              excludeHeaderSemantics: true,
              titleSpacing: 0.0,
              elevation: 0.0,
              centerTitle: true,
              brightness: Brightness.dark,
              title: Container(
                height: kToolbarHeight.h,
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                decoration: BoxDecoration(
                  color: Constants.themeGreyLight,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 12.w,
                    ),
                    Expanded(
                      child: Text(widget.title ?? S.of(context).cartDialogTitle,
                          style: Get.textTheme.bodyText1.copyWith(
                              fontSize: 20.0.w, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
            body: Container(
              padding: EdgeInsets.fromLTRB(20.w, 10.w, 20.w, 10.w),
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (widget.type != CartItemType.Message)
                    Row(children: <Widget>[
                      Icon(
                        Icons.check_circle,
                        color: Get.theme.primaryColor,
                        size: 40.w,
                      ),
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.0.w, right: 8.0.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  widget.productTitle,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.w),
                                ),
                              ),
                              Container(
                                  child: Text(
                                widget.type == CartItemType.Wishlist
                                    ? S.of(context).addedToWishlist
                                    : S.of(context).addedToCart,
                                style: TextStyle(fontSize: 12.w),
                              )),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                                child: Text(
                                    "${widget.type == CartItemType.Wishlist ? S.of(context).wishlist : S.of(context).cart} ${S.of(context).total}")),
                            Container(
                                child: Text(
                              widget.cartTotal,
                              style: TextStyle(
                                  color: Get.theme.primaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13.w),
                            )),
                          ],
                        ),
                      )
                    ]),
                  if (widget.type == CartItemType.Message)
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding:
                                  EdgeInsets.only(left: 8.0.w, right: 8.0.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      widget.productTitle,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.w),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: 8.0.w, top: 8.0.w),
                            child: ButtonTheme(
                              height: 40.w,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Get.theme.primaryColor),
                                      borderRadius: BorderRadius.circular(8.w)),
                                ),
                                child: Text(
                                  widget.type == CartItemType.Message
                                      ? S.of(context).ok
                                      : S.of(context).continueShopping,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Get.theme.primaryColor,
                                      fontSize: 13.w),
                                ),
                                onPressed: () {
                                  navigator.pop();
                                },
                              ),
                            ),
                          ),
                        ),
                        if (widget.type != CartItemType.Message)
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 8.0.w, top: 8.0.w),
                              child: ButtonTheme(
                                height: 40.w,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.w)),
                                    backgroundColor: Get.theme.primaryColor,
                                    onSurface: Get.theme.primaryColor
                                        .withOpacity(0.5),
                                  ),
                                  child: Text(
                                    widget.type == CartItemType.Wishlist
                                        ? S.of(context).goToWishlist
                                        : S.of(context).checkout,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 13.w),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  onPressed: () {
                                    if (navigator.canPop()) navigator.pop();
                                    if (widget.onGoForward != null)
                                      widget.onGoForward();
                                  },
                                ),
                              ),
                            ),
                          ),
                      ])
                ],
              ),
            )),
      ),
    );
  }
}
