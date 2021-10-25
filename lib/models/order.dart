import 'package:edeybe/models/deliveryModel.dart';
import 'package:edeybe/models/productModel.dart';

class Order {
  Order(
      {this.name,
      this.id,
      this.image,
      this.orderId,
      this.quantity,
      this.productTotal,
      this.shippingAddress,
      this.cartDeliveryCost,
      this.paymentDate,
      this.photos,
      this.deliveryDate,
      this.transactionId,
      this.deliveryAddress});

  String name;
  String id;
  String orderId;
  Photos image;
  List<Photos> photos;
  int quantity;
  String productTotal;
  String transactionId;
  String paymentDate;
  String deliveryDate;
  double cartDeliveryCost;
  ShippingAddress shippingAddress;
  DeliveryAddress deliveryAddress;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        name: json["productName"],
        id: json["_id"],
        orderId: json["productId"],
        quantity: json["quantity"],
        shippingAddress: ShippingAddress(
          lastName: json['shippingAddress']['lastName'],
          firstName: json['shippingAddress']['firstName'],
          email: json['shippingAddress']['email'],
          phone: json['shippingAddress']['phone'],
        ),
        deliveryAddress: DeliveryAddress(
          type: json['deliveryAddress']['type'],
          id: json['deliveryAddress']['_id'],
          lat: json['deliveryAddress']['lat'],
          long: json['deliveryAddress']['long'],
          displayText: json['deliveryAddress']['displayText'],
          placeName: json['deliveryAddress']['placeName'],
          // digitalAddress: "GA3316235"
        ),
        productTotal: json["productTotal"],
        cartDeliveryCost: json["cartDeliveryCost"],
        paymentDate: json["paymentDate"],
        deliveryDate: json["paymentDate"],
        transactionId: json["transactionId"],
        image:
            json["photos"] == null ? null : Photos.fromJson(json["photos"][0]),
        photos: json["photos"] == null
            ? []
            : (json["photos"] as List<dynamic>)
                .map((image) => Photos.fromJson(image))
                .toList(),
      );

  Map<String, dynamic> toJson() =>
      {"name": name, "id": id, "image": image == null ? null : image};
}
