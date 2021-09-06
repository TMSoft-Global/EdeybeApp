import 'package:edeybe/utils/cart_item_type.dart';
import 'package:edeybe/widgets/cart_item.dart';
import 'package:edeybe/widgets/empty_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:edeybe/index.dart';

class TrackOrderScreen extends StatefulWidget {
  TrackOrderScreen({Key key}) : super(key: key);

  @override
  _TrackOrderScreenState createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  List orders = [];
  @override
  void initState() {
    super.initState();
  }

  // build card items i.e. wishlist , selected items
  Widget _buildOrderItem(CartItemType type) {
    return orders.length > 0
        ? Column(
            children: orders // <-- should be a list of user selected items
                .map<Widget>((e) => CartItem(
                      product: e,
                      type: type,
                      onTrackOrder: () => null,
                    ))
                .toList())
        : ListEmptyWidget(
            message: type == CartItemType.Wishlist
                ? S.of(context).wishlistEmpty
                : S.of(context).noOrdersFound,
            child: TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Get.theme.primaryColor),
                    borderRadius: BorderRadius.circular(4.w)),
              ),
              child: Text(
                "${S.of(context).continueShopping}",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(color: Get.theme.primaryColor, fontSize: 15.w),
              ),
              onPressed: () {
                // navigator.pop();
              },
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          titleSpacing: 0.0,
          elevation: 1,
          brightness: Brightness.dark,
          title: Text(S.of(context).trackOrders,
              textAlign: TextAlign.center,
              style: Get.textTheme.bodyText1.copyWith(
                  color: Colors.white,
                  fontSize: 20.0.w,
                  fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _buildOrderItem(CartItemType.Track),
            ],
          ),
        ));
  }
}
