import 'package:edeybe/controllers/user_controller.dart';
import 'package:edeybe/models/order.dart';
import 'package:edeybe/screens/checkout_screen/index.dart';
import 'package:edeybe/screens/order_history_screen/order_details/order_details.dart';
import 'package:edeybe/utils/cart_item_type.dart';
import 'package:edeybe/utils/constant.dart';
import 'package:edeybe/widgets/Shimmer.dart';
import 'package:edeybe/widgets/cart_item.dart';
import 'package:edeybe/widgets/custom_divider.dart';
import 'package:edeybe/widgets/empty_list_widget.dart';
import 'package:edeybe/widgets/see_more.dart';

import 'package:flutter/material.dart';
import 'package:edeybe/index.dart';

class OrderHistoryScreen extends StatefulWidget {
  OrderHistoryScreen({Key key}) : super(key: key);

  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen>
    with TickerProviderStateMixin {
  List<Order> orders = [];
  UserController _userController = Get.find<UserController>();
  
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _userController.getUserOrders();
      _userController.addItems();
      _userController.getUserOrders(completed: true);
    });
  }

  // build card items i.e. wishlist , selected items
  Widget _buildOrderItem(
      CartItemType type, Map<String, List<Order>> orders, Widget loadMore) {
    return orders.isNotEmpty
        ? SingleChildScrollView(
          controller: _userController.controller,
            child: Column(
                children: orders
                    .map((key, value) => MapEntry<String, Widget>(
                        key,
                        Wrap(
                          children: [
                            _buildSectionHeader(key),
                            CustomDivider(
                              height: 3.0,
                              thickness: 2.0,
                            )
                          ]..addAll(value
                              .map<Widget>((e) => CartItem(
                                    product: e,
                                    type: type,
                                    onViewDetails: () =>
                                        Get.to(OrderDetails(order: e)),
                                  ))
                              .toList()),
                        )))
                    .values
                    .toList()
                      ..add(loadMore)),
          )
        : ListEmptyWidget(
            message: S.of(context).noOrdersFound,
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
                navigator.pop();
              },
            ));
  }

  // biuld section header
  Widget _buildSectionHeader(String date) {
    return Container(
      // decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Constants.themeGreyLight,width: 2.0.w))),
      width: Get.width,
      child: Text(
        date,
        style: Get.textTheme.bodyText1
            .copyWith(fontSize: 15.w, fontWeight: FontWeight.bold),
      ),
      padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 20.w),
      color: Colors.white,
    );
  }

  Map<String, List<Order>> groupOrders(List<Order> data, int type) =>
      data.groupBy((order) {
        return DateFormat("E d MMM, yyyy").format(
            DateTime.parse(type == 2 ? order.deliveryDate : order.paymentDate));
      });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: (ctl) {
      return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            titleSpacing: 0.0,
            elevation: 1,
            brightness: Brightness.dark,
            title: Text("Orders",
                textAlign: TextAlign.center,
                style: Get.textTheme.bodyText1.copyWith(
                    color: Colors.white,
                    fontSize: 20.0.w,
                    fontWeight: FontWeight.bold)),
            centerTitle: true,
            bottom: (ctl.orders.isNotEmpty || ctl.ordersHistory.isNotEmpty)
                ? TabBar(
                    indicatorColor: Constants.themeBlueLight,
                    controller: _tabController,
                    tabs: <Widget>[
                      Tab(
                          child: Text(
                        "New",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.w,
                            fontWeight: FontWeight.w600),
                      )),
                      Tab(
                          child: Text(
                        S.of(context).completed,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.w,
                            fontWeight: FontWeight.w600),
                      )),

                      // Tab(
                      //     child: Text(
                      //   S.of(context).cancelled,
                      //   overflow: TextOverflow.ellipsis,
                      //   style: TextStyle(
                      //       color: Colors.white,
                      //       fontSize: 16.w,
                      //       fontWeight: FontWeight.w600),
                      // )),
                    ],
                  )
                : null,
          ),
          body: Shimmer(
              linearGradient: Constants.shimmerGradient,
              child: (ctl.orders.isNotEmpty || ctl.ordersHistory.isNotEmpty)
                  ? TabBarView(
                      controller: _tabController,
                      children: <Widget>[
                        _buildOrderItem(
                            CartItemType.Orders,
                            groupOrders(ctl.orders, 1),
                            SeeMoreWidget(
                              canSeeMore: ctl.orderHasMore.value,
                              loading: ctl.orderLoading.value,
                              onPress: () {
                                ctl.setNextPage();
                                ctl.getUserOrders();
                              },
                            )),
                        _buildOrderItem(
                            CartItemType.Orders,
                            groupOrders(ctl.ordersHistory, 2),
                            SeeMoreWidget(
                              canSeeMore: ctl.historyHasMore.value,
                              loading: ctl.historyLoading.value,
                              onPress: () {
                                ctl.setNextPage(order: false);
                                ctl.getUserOrders(completed: true);
                              },
                            )),
                        // _buildOrderItem(CartItemType.Orders, ctl.orders),
                      ],
                    )
                  : ListEmptyWidget(
                      message: S.of(context).noOrdersFound,
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
                          style: TextStyle(
                              color: Get.theme.primaryColor, fontSize: 15.w),
                        ),
                        onPressed: () {
                          navigator.pop();
                        },
                      ))));
    });
  }
}
