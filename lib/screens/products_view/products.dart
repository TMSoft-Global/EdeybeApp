import 'package:edeybe/controllers/app_controller.dart';
import 'package:edeybe/controllers/product_controller.dart';
import 'package:edeybe/controllers/search_controller.dart';
import 'package:edeybe/controllers/wishlist_controller.dart';
import 'package:edeybe/models/category.dart';
import 'package:edeybe/models/product.dart';
import 'package:edeybe/models/subcategory.dart';
import 'package:edeybe/screens/checkout_screen/index.dart';
import 'package:edeybe/screens/product_details_screen/product_details_screen.dart';
import 'package:edeybe/screens/filter/index.dart';
import 'package:edeybe/screens/wishlist_screen/wishlist_screen.dart';
import 'package:edeybe/utils/Debouncer.dart';
import 'package:edeybe/utils/helper.dart';
import 'package:edeybe/utils/product_num.dart';
import 'package:edeybe/widgets/ErrorBoundary.dart';
import 'package:edeybe/widgets/Shimmer.dart';
import 'package:edeybe/widgets/ShimmerLoader.dart';
import 'package:edeybe/widgets/action_sheet_dialog.dart';
import 'package:edeybe/widgets/back_to_top.dart';
import 'package:edeybe/widgets/cart_dialog.dart';
import 'package:edeybe/widgets/empty_list_widget.dart';
import 'package:edeybe/widgets/product_card.dart';
import 'package:edeybe/widgets/product_card_landscape.dart';
import 'package:edeybe/widgets/search_result_widget.dart';
import 'package:edeybe/widgets/see_more.dart';
import 'package:flutter/material.dart';
import 'package:edeybe/index.dart';

class ProductsView extends StatefulWidget {
  final dynamic type;
  final String id;
  ProductsView({Key key, this.type, this.id}) : super(key: key);

  @override
  _ProductsViewState createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView>
    with TickerProviderStateMixin {
  final _productController = Get.find<ProductController>();
  final appController = Get.put(AppController());
  final searchController = Get.find<SearchController>();
  final _wishlistController = Get.find<WishlistController>();
  final _searchFieldController = TextEditingController();
  final formatCurrency = new NumberFormat.simpleCurrency(name: "");
  bool showSearch = false;
  bool showGrid = true;
  Debouncer debounce = Debouncer();
  AnimationController _animationController;
  FocusNode _focus = new FocusNode();
  Animation _animation;
  AnimationController controller;
  Animation<double> animation;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    _animation = IntTween(begin: 5, end: 3).animate(_animationController);
    controller =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(controller);
    _animation.addListener(() => setState(() {}));
    // _scrollController = ScrollController()..addListener(scrollingBehavior);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var sort = await appController.getStore();
      if (sort != '') {
        _productController.setQuery("sort", sort);
      }
      loadData();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    controller.dispose();
    if (widget.type is Seller) {
      _productController.resetMerchantProducts();
    } else {
      _productController.resetProducts();
    }
    _focus.dispose();
    super.dispose();
  }

  /// Define the scrolling behavior of the customListView
  void scrollingBehavior() {
    if (!_productController.loadingMore.value &&
        _scrollController.position.extentAfter < 20 &&
        _productController.hasMore.value) {
      _productController.setNextPage();
      loadData();
    }
  }

  void loadMore() {
    _productController.setNextPage(isMerchant: widget.type is Seller);
    loadData();
  }

  void loadData() {
    if (widget.type is SubCategory) {
      _productController.setQuery('subcategory', widget.type.id);
    }
    if (widget.type is Category) {
      _productController.setQuery('category', widget.type.id);
    } else if (widget.type is ProductType) {
      if (ProductType.Collection == widget.type) {
        _productController.setQuery('category', widget.id);
      }
      // else if (ProductType.Slugs == widget.type)
      //   _productController.getAllProducts();
    }
    widget.type is Seller
        ? _productController.getMerchantProducts(widget.type.id)
        : _productController.getAllProducts();
  }

  void _showSearch() {
    setState(() {
      showSearch = true;
      controller.forward();
      _animationController.forward();
    });
  }

  void _toggleListView() {
    setState(() {
      showGrid = !showGrid;
    });
  }

  void _cancelSearch() {
    FocusScope.of(context).requestFocus(new FocusNode());
    searchController.cancel();
    setState(() {
      showSearch = false;
    });
    _animationController.reverse();
    controller.reverse();
    _searchFieldController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: !showSearch,
            titleSpacing: 0.0,
            elevation: 1,
            brightness: Brightness.dark,
            title: showSearch
                ? Row(
                    children: <Widget>[
                      Expanded(
                          flex: _animation.value,
                          child: Container(
                            margin: EdgeInsets.only(
                              left: 8.w,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.w),
                              color: Colors.white,
                            ),
                            height: 40.w,
                            child: TextField(
                              focusNode: _focus,
                              autofocus: false,
                              onChanged: (text) {
                                setState(() {});
                                if (text.length >= 3) {
                                  debounce.run(() =>
                                      searchController.searchProducts(text));
                                }
                              },
                              controller: _searchFieldController,
                              decoration: InputDecoration(
                                  isDense: true,
                                  border: InputBorder.none,
                                  labelText: S.of(context).searchOnedeybe,
                                  hintText: S.of(context).searchOnedeybe,
                                  hintStyle: TextStyle(fontSize: 14.w),
                                  hintMaxLines: 1,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  ),
                                  suffixIcon:
                                      _searchFieldController.text.length > 0
                                          ? FadeTransition(
                                              opacity: Tween<double>(
                                                begin: 0.0,
                                                end: 1.0,
                                              ).animate(_animationController),
                                              child: InkWell(
                                                child: Icon(Icons.close),
                                                onTap: () {
                                                  setState(() {
                                                    _searchFieldController
                                                        .text = "";
                                                    searchController.clear();
                                                  });
                                                },
                                              ))
                                          : null),
                              style: TextStyle(fontSize: 14.w),
                            ),
                          )),
                      Expanded(
                        flex: 1,
                        child: FadeTransition(
                          opacity: animation,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.all(0),
                            ),
                            onPressed: _cancelSearch,
                            child: Text(
                              S.of(context).cancel,
                              style: TextStyle(fontSize: 15.w),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                : Container(
                    height: kToolbarHeight,
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 12.w,
                        ),
                        Expanded(
                          child: Text(S.of(context).products,
                              style: Get.textTheme.bodyText1.copyWith(
                                  color: Colors.white,
                                  fontSize: 20.w,
                                  fontWeight: FontWeight.bold)),
                        ),
                        IconButton(
                          padding: EdgeInsets.all(0),
                          onPressed: _showSearch,
                          icon: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
            centerTitle: false,
            bottom: !showSearch && !(widget.type is Seller)
                ? PreferredSize(
                    child: Filter(
                        switchListView: _toggleListView,
                        sortBy: _sortBy,
                        onApply: (val) {
                          _productController.resetProducts();
                          _productController.setQuery('', '',
                              reset: true, data: val, merge: true);
                          _productController.getAllProducts();
                        },
                        viewType: showGrid),
                    preferredSize: Size.fromHeight(50))
                : null),
        body: GetBuilder<ProductController>(
          builder: (c) => ErrorBoundary(
            canceled: c.canceled.value,
            serverError: c.serverError.value,
            connectionError: c.connectionError.value,
            onRetry: loadData,
            child: Shimmer(
              linearGradient: Constants.shimmerGradient,
              child: Stack(
                children: <Widget>[
                  SingleChildScrollView(
                    controller: _scrollController,
                    child: Obx(
                      () => Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        alignment: WrapAlignment.start,
                        runAlignment: WrapAlignment.center,
                        spacing: 0,
                        runSpacing: 0,
                        children: [if (widget.type is Seller) _storeDetails(c)]
                          ..addAll(_buildProducts(c)),
                      ),
                    ),
                  ),
                  BackToTopWidget(
                    scrollController: _scrollController,
                  ),
                  if (showSearch) SearchResultWidget(closeSearch: _cancelSearch)
                ],
              ),
            ),
          ),
        ));
  }

  List<Widget> _buildProducts(ProductController c) {
    if (c.loading.value && !c.loadingMore.value) {
      return List.generate(
          10,
          (index) => Container(
                padding: EdgeInsets.symmetric(vertical: 5.w),
                // height: showGrid ? 310.w : null,
                child: showGrid
                    ? ProductCard(
                        isLoading: true,
                        width: Get.width / 2.1,
                        padding: ((1 + index) % 2 != 0 ? 10 : 0).w,
                        title: null,
                        image: null,
                        discount: 0,
                        price: 0,
                        oldPrice: 0,
                        onAddToWishList: () => null,
                        onViewDetails: () {},
                        hasDiscount: false,
                        isFav: false,
                        rating: 0,
                        raters: 0,
                      )
                    : ProductCardLandscape(
                        isLoading: true,
                        width: Get.width,
                        title: null,
                        image: null,
                        discount: 0,
                        price: 0,
                        oldPrice: 0,
                        onAddToWishList: () => null,
                        onViewDetails: () {},
                        isFav: false,
                        rating: 0,
                        raters: 0,
                      ),
              ));
    } else if (c.products != null &&
        (c.products.isNotEmpty ||
            (widget.type is Seller && c.merchantProducts.isNotEmpty))) {
      List<Widget> prods =
          ((widget.type is Seller) ? c.merchantProducts : c.products)
              .map<Widget>(
        (p) {
          var index =
              ((widget.type is Seller) ? c.merchantProducts : c.products)
                  .indexOf(p);
          return Container(
            padding: EdgeInsets.symmetric(vertical: 5.w),
            // height: showGrid ? 310.w : null,
            child: showGrid
                ? ProductCard(
                    width: Get.width / 2.1,
                    padding: ((1 + index) % 2 != 0 ? 10 : 0).w,
                    title: p.name,
                    image: p.image,
                    discount: p.priceRange.minimumPrice.discount.percentOff,
                    price: p.priceRange.minimumPrice.finalPrice.value,
                    oldPrice: p.priceRange.minimumPrice.regularPrice.value,
                    onAddToWishList: () => _addToWishlist(p),
                    onViewDetails: () {
                      _productController.setInViewProduct(p);

                      Get.to(ProductDetailsScreen());
                    },
                    hasDiscount: p.priceRange.minimumPrice.hasDiscount,
                    isFav: Helper.isFavourite(p.sku, _wishlistController),
                    rating: 5.0,
                    raters: 23,
                  )
                : ProductCardLandscape(
                    title: p.name,
                    image: p.image,
                    discount: p.priceRange.minimumPrice.discount.percentOff,
                    price: p.priceRange.minimumPrice.finalPrice.value,
                    oldPrice: p.priceRange.minimumPrice.regularPrice.value,
                    onAddToWishList: () => _addToWishlist(p),
                    onViewDetails: () {
                      _productController.setInViewProduct(p);

                      Get.to(ProductDetailsScreen());
                    },
                    isFav: Helper.isFavourite(p.sku, _wishlistController),
                    rating: 5.0,
                    raters: 23,
                  ),
          );
        },
      ).toList();
      prods.add(SeeMoreWidget(
        canSeeMore: c.hasMore.value,
        loading: c.loading.value,
        onPress: loadMore,
      ));

      return prods;
    } else {
      return <Widget>[
        ListEmptyWidget(
            message: S.of(context).productsEmpty, child: SizedBox.shrink())
      ];
    }
  }

  Widget _storeDetails(ProductController c) {
    return Container(
      height: 100.w,
      width: Get.width.w,
      padding: EdgeInsets.all(5.w),
      child: Row(
        children: [
          CircleAvatar(
            child: ShimmerLoading(
              isLoading: c.loading.value,
              child: c.seller.value.photo != null
                  ? CachedNetworkImage(imageUrl: c.seller.value.photo)
                  : SizedBox.shrink(),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Wrap(
              children: [
                ShimmerLoading(
                    isLoading: c.loading.value,
                    child: Container(
                      child: Text(c.seller.value.name ?? ""),
                    )),
                ShimmerLoading(
                    isLoading: c.loading.value,
                    child: Container(
                      child: Text(c.seller.value.details ?? ""),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }

  _addToWishlist(p) {
    _wishlistController.addToWishlist(p, ({String title}) {
      setState(() {});
      Get.dialog(
        CartDialog(
            title: title,
            type: CartItemType.Wishlist,
            onGoForward: () => Get.to(WishlistScreen()),
            productTitle: p.name,
            cartTotal: formatCurrency.format(
                _wishlistController.wishlistItems
                    .fold(
                        0,
                        (previousValue, element) =>
                            element.priceRange.minimumPrice.finalPrice.value +
                            previousValue))),
        barrierDismissible: true,
      );
    });
  }

  // sort by dialog
  void _sortBy() async {
    final sortByOptions = [
      {"name": "Popularity", "value": "popularity"},
      // {"name": "Top Rated", "value": "toprated"},
      {"name": "New Arrivals", "value": "newarrivals"},
      {"name": "Price: Low to High", "value": "pricelow"},
      {"name": "Price High to Low", "value": "pricehigh"},
    ];
    await actionSheetDialog(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 12.w,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              S.current.sort,
              textAlign: TextAlign.center,
              style: Get.textTheme.headline6.copyWith(fontSize: 20.w),
            ),
          ),
          Expanded(
            child: ListView(
                padding: EdgeInsets.all(0),
                shrinkWrap: true,
                children: sortByOptions
                    .map(
                      (e) => Obx(
                        () => Container(
                          color: Colors.white,
                          child: RadioListTile(
                            dense: true,
                            controlAffinity: ListTileControlAffinity.trailing,
                            value: e['value'],
                            title: AutoSizeText(
                              e["name"],
                              maxLines: 1,
                              style: Get.textTheme.subtitle1.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            activeColor: Get.theme.primaryColor,
                            groupValue: appController.store.value,
                            onChanged: (value) {
                              appController.setStore(value);
                              _productController.setQuery(
                                "sort",
                                "$value",
                              );
                              _productController.resetPage();
                              loadData();
                              Get.back();
                            },
                          ),
                        ),
                      ),
                    )
                    .toList()),
          ),
          Container(
            width: Get.width,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Constants.themeGreyLight,
              ),
              onPressed: () {
                Get.back();
              },
              child: Text(
                S.current.cancel,
              ),
            ),
          ),
        ],
      ),
      height: .5,
    );
  }
}
