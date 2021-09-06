import 'package:edeybe/controllers/home_controller.dart';
import 'package:edeybe/controllers/product_controller.dart';
import 'package:edeybe/controllers/wishlist_controller.dart';
import 'package:edeybe/index.dart';
import 'package:edeybe/models/product.dart' as ProductModel;
import 'package:edeybe/screens/checkout_screen/index.dart';
import 'package:edeybe/screens/product_details_screen/product_details_screen.dart';
import 'package:edeybe/screens/wishlist_screen/wishlist_screen.dart';
import 'package:edeybe/utils/helper.dart';
import 'package:edeybe/widgets/cart_dialog.dart';
import 'package:edeybe/widgets/product_card.dart';
import 'package:flutter/material.dart';

class ProductsGrid extends StatelessWidget {
  final Widget heading;
  final bool isLoading;
  final List<ProductModel.Product> products;
  final Axis scrollDirection;
  final Function onshowMorePressed;
  final formatCurrency = new NumberFormat.simpleCurrency(name: "");
  ProductsGrid(
      {Key key,
      this.products,
      this.scrollDirection = Axis.horizontal,
      this.heading,
      this.isLoading = false,
      this.onshowMorePressed})
      : super(key: key);
  final _productController = Get.find<ProductController>();
  final _wishlistController = Get.find<WishlistController>();
  @override
  Widget build(BuildContext context) {
    return _buildFeaturedCards(products);
  }

  Widget _buildFeaturedCards(List<ProductModel.Product> products) {
    final cards = <ProductCard>[];
    // ignore: non_constant_identifier_names
    Widget FeautredCards;
    if (isLoading) {
      List.generate(
          3,
          (index) => cards.add(ProductCard(
                isLoading: isLoading,
                price: 0,
                image: null,
                oldPrice: 0,
                onAddToWishList: () => null,
                raters: 0,
                discount: 0,
                rating: 0,
                title: "",
                isFav: false,
                onViewDetails: () => null,
              )));
      FeautredCards = GetBuilder<HomeController>(
          builder: (w) => Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: cards),
                ),
              ));
    } else if (products.isNotEmpty) {
      for (int i = 0; i < products.length; i++) {
        var product = products[i];
        var price = product.priceRange.minimumPrice;
        cards.add(ProductCard(
          onViewDetails: () {
            _productController.setInViewProduct(product);
            Get.to(ProductDetailsScreen());
          },
          onAddToWishList: () => _wishlistController.addToWishlist(
              product,
              ({String title}) => Get.dialog(
                    CartDialog(
                        title: title,
                        type: CartItemType.Wishlist,
                        onGoForward: () => Get.to(WishlistScreen()),
                        productTitle: product.name,
                        cartTotal: formatCurrency.format(
                            _wishlistController.wishlistItems.fold(
                                0,
                                (previousValue, element) =>
                                    element.priceRange.minimumPrice.finalPrice
                                        .value +
                                    previousValue))),
                    barrierDismissible: true,
                  )),
          image: product.image,
          isFav: Helper.isFavourite(product.sku, _wishlistController),
          discount: product.priceRange.minimumPrice.discount.percentOff,
          price: price?.finalPrice?.value,
          oldPrice: price?.regularPrice?.value,
          title: product?.name,
          hasDiscount: price.hasDiscount,
          rating: 5.0,
          raters: 23,
        ));
      }
      FeautredCards = GetBuilder<HomeController>(
          builder: (w) => Container(
                // color: Colors.white,
                child: scrollDirection == Axis.horizontal
                    ? SingleChildScrollView(
                        scrollDirection: scrollDirection,
                        child: Row(
                          children: cards,
                        ),
                      )
                    : Align(
                        alignment: Alignment.topCenter,
                        child: SingleChildScrollView(
                          scrollDirection: scrollDirection,
                          child: Wrap(
                              spacing: 15.w,
                              runSpacing: 10.w,
                              runAlignment: WrapAlignment.spaceEvenly,
                              alignment: WrapAlignment.spaceBetween,
                              children: cards),
                        ),
                      ),
              ));
    } else {
      FeautredCards = Container();
    }
    return FeautredCards;
  }
}
