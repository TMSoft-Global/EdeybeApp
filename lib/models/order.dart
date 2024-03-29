import 'package:edeybe/models/deliveryModel.dart';
import 'package:edeybe/models/productModel.dart';

class Order {
  String sId;
  List<Photos> photos;
  String productId;
  String productName;
  int quantity;
  String productTotal;
  String transactionId;
  DeliveryAddress deliveryAddress;
  ShippingAddress shippingAddress;
  String paymentDate;
  double cartDeliveryCost;
  List<Variants> variants;
  bool hasVariants =false;
  bool hasDiscount = false;
  bool canRate;

  String selectedVariant;
  bool availableForHirePurchasing = false;


  Order({
    this.hasDiscount = false,
    this.sId,
    this.photos,
    this.productId,
    this.productName,
    this.quantity,
    this.productTotal,
    this.transactionId,
    this.deliveryAddress,
    this.shippingAddress,
    this.paymentDate,
    this.cartDeliveryCost,
    this.variants,
    this.hasVariants = false,
    this.canRate = false,
    this.availableForHirePurchasing = false,
    this.selectedVariant,
  });

  Order.fromJson(Map<String, dynamic> json) {
    print(json['canRate']);
    sId = json['_id'];
    if (json['photos'] != null) {
      photos = <Photos>[];
      json['photos'].forEach((v) {
        photos.add(new Photos.fromJson(v));
      });
    }
    productId = json['productId'];
    productName = json['productName'];
    hasDiscount = false;
    canRate = json['canRate'];
    selectedVariant = json['selectedVariant'];
    quantity = json['quantity'];
    productTotal = json['productTotal'];
    transactionId = json['transactionId'];
    deliveryAddress = json['deliveryAddress'] != null
        ? new DeliveryAddress.fromJson(json['deliveryAddress'])
        : DeliveryAddress();
    shippingAddress = json['shippingAddress'] != null
        ? new ShippingAddress.fromJson(json['shippingAddress'])
        : ShippingAddress();
    paymentDate = json['paymentDate'];
    cartDeliveryCost = json['cartDeliveryCost'];
     if (json['variants'] != null) {
      variants = <Variants>[];
      json['variants'].forEach((v) {
        variants.add(new Variants.fromJson(v));
      });
    }
    hasVariants = false;
    availableForHirePurchasing = json['availableForHirePurchasing'] == null ? false : json['availableForHirePurchasing'];

   
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = sId;
    if (photos != null) {
      data['photos'] = photos.map((v) => v.toJson()).toList();
    }
    data['availableForHirePurchasing'] = availableForHirePurchasing;
    data['canRate'] = canRate;
    data['productId'] = productId;
    data['productName'] = productName;
    data['quantity'] = quantity;
    data['productTotal'] = productTotal;
    data['transactionId'] = transactionId;
    if (deliveryAddress != null) {
      data['deliveryAddress'] = deliveryAddress.toJson();
    }
    if (shippingAddress != null) {
      data['shippingAddress'] = shippingAddress.toJson();
    }
    data['paymentDate'] = paymentDate;
    data['cartDeliveryCost'] = cartDeliveryCost;
    return data;
  }
}
