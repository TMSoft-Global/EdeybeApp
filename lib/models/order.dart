import 'package:edeybe/models/product.dart';
import 'package:edeybe/models/shippingAddress.dart';

class Order {
  Order({
    this.name,
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
  });

  String name;
  String id;
  String orderId;
  Image image;
  List<Image> photos;
  int quantity;
  String productTotal;
  String transactionId;
  String paymentDate;
  String deliveryDate;
  double cartDeliveryCost;
  ShippingAddress shippingAddress;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        name: json["productName"],
        id: json["_id"],
        orderId: json["productId"],
        quantity: json["quantity"],
        shippingAddress: ShippingAddress.fromJson(json["shippingAddress"]),
        productTotal: json["productTotal"],
        cartDeliveryCost: json["cartDeliveryCost"],
        paymentDate: json["paymentDate"],
        deliveryDate: json["paymentDate"],
        transactionId: json["transactionId"],
        image:
            json["photos"] == null ? null : Image.fromJson(json["photos"][0]),
        photos: json["photos"] == null
            ? []
            : (json["photos"] as List<dynamic>)
                .map((image) => Image.fromJson(image))
                .toList(),
      );

  Map<String, dynamic> toJson() =>
      {"name": name, "id": id, "image": image == null ? null : image};
}
