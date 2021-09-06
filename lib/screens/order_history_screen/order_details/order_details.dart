import 'package:edeybe/models/order.dart';
import 'package:edeybe/models/product.dart';
import 'package:edeybe/screens/checkout_screen/index.dart';
import 'package:edeybe/utils/helper.dart';
import 'package:edeybe/widgets/Shimmer.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatefulWidget {
  final Order order;
  OrderDetails({Key key, this.order}) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  final formatCurrency = new NumberFormat.simpleCurrency(name: "");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Order Detials ${widget.order.orderId}"),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Shimmer(
              linearGradient: Constants.shimmerGradient,
              child: Column(
                children: [
                  _buildCartSummary,
                  SizedBox(
                    height: 5.w,
                  ),
                  AddressCard(
                      onCardPressed: null,
                      showChangeButton: false,
                      address: widget.order.shippingAddress,
                      onEditAddress: null,
                      onRemoveAddress: null),
                  SizedBox(
                    height: 5.w,
                  ),
                  CartItem(
                    tappable: false,
                    product: Product(
                        name: widget.order.name,
                        sku: widget.order.id,
                        image: widget.order.image,
                        mediaGallery: widget.order.photos,
                        quantity: widget.order.quantity,
                        seller: Seller(name: ""),
                        priceRange: PriceRange(
                            minimumPrice: MinimumPrice(
                                finalPrice: Price(
                                    value: double.parse(
                                        widget.order.productTotal))))),
                    type: CartItemType.Checkout,
                  ),
                  SizedBox(
                    height: 5.w,
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  // build card for cart summary
  Widget get _buildCartSummary {
    return GetBuilder<CartController>(builder: (_) {
      var totalAmonut = widget.order.productTotal;
      var totalDiscount = 0;
      return Container(
        margin: EdgeInsets.fromLTRB(10.w, 20.w, 10.w, 10.w),
        padding: EdgeInsets.all(10.0.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.w),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Constants.boxShadow,
                blurRadius: 3.4.w,
                offset: Offset(0, 3.4.w),
              )
            ]),
        child: Table(
          children: <TableRow>[
            TableRow(children: [
              TableCell(
                child: Text(S.of(context).orderSummary,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 18.w)),
              ),
              TableCell(
                child: Text(""),
              )
            ]),
            TableRow(children: [
              TableCell(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(S.of(context).orderId),
                ),
              ),
              TableCell(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Text(widget.order.orderId,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12.w)),
                ),
              ),
            ]),
            TableRow(children: [
              TableCell(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "${S.of(context).subtotal} (${widget.order.productTotal} ${S.of(context).items})"),
                ),
              ),
              TableCell(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: MoneyWidget(
                    offset: Offset(0, 3.5),
                    fontWeight: FontWeight.w700,
                    currencyFirst: true,
                    children: [
                      TextSpan(
                          text:
                              formatCurrency.format(double.parse(totalAmonut)),
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                              fontSize: 14.w))
                    ],
                  ),
                ),
              ),
            ]),
            TableRow(children: [
              TableCell(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text("${S.of(context).promotionDiscounts}"),
                ),
              ),
              TableCell(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: MoneyWidget(
                    offset: Offset(0, 4),
                    fontWeight: FontWeight.w700,
                    currencyFirst: true,
                    children: [
                      TextSpan(
                          text: formatCurrency.format(totalDiscount),
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                              fontSize: 14.w))
                    ],
                  ),
                ),
              ),
            ]),
            TableRow(children: [
              TableCell(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(""),
                ),
              ),
              TableCell(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Text(""),
                ),
              ),
            ]),
            TableRow(children: [
              TableCell(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text("${S.of(context).deliveryCharges}"),
                ),
              ),
              TableCell(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: widget.order.cartDeliveryCost != null
                      ? MoneyWidget(
                          offset: Offset(0, 4),
                          fontWeight: FontWeight.w700,
                          currencyFirst: true,
                          children: [
                            TextSpan(
                                text: widget.order.cartDeliveryCost.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    fontSize: 14.w))
                          ],
                        )
                      : Helper.textPlaceholder,
                ),
              ),
            ]),
            TableRow(children: [
              TableCell(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text("Est. ${S.of(context).total}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17.w)),
                ),
              ),
              TableCell(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: widget.order.cartDeliveryCost != null
                      ? MoneyWidget(
                          offset: Offset(0, 6),
                          scalefactor: 1,
                          fontWeight: FontWeight.w700,
                          currencyFirst: true,
                          children: [
                            TextSpan(
                                text: formatCurrency.format(double.parse(
                                    "${widget.order.cartDeliveryCost + double.parse(widget.order.productTotal)}")),
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black,
                                    fontSize: 16.w))
                          ],
                        )
                      : Helper.textPlaceholder,
                ),
              ),
            ]),
            TableRow(children: [
              TableCell(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(S.of(context).paymentDate,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15.w)),
                ),
              ),
              TableCell(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      DateFormat.yMEd()
                          .add_jms()
                          .format(DateTime.parse(widget.order.paymentDate)),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12.w)),
                ),
              ),
            ]),
            TableRow(children: [
              TableCell(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(S.of(context).deliveryDate,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15.w)),
                ),
              ),
              TableCell(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      DateFormat.yMEd()
                          .add_jms()
                          .format(DateTime.parse(widget.order.deliveryDate)),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12.w)),
                ),
              ),
            ]),
          ],
        ),
      );
    });
  }
}
