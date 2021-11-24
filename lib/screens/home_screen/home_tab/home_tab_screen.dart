import 'package:edeybe/controllers/category_controller.dart';
import 'package:edeybe/controllers/home_controller.dart';
import 'package:edeybe/controllers/product_controller.dart';
import 'package:edeybe/controllers/search_controller.dart';
import 'package:edeybe/screens/filter/fillter_widget.dart';
import 'package:edeybe/screens/home_screen/category_tab/sub_category_screen.dart';
import 'package:edeybe/screens/products_view/products.dart';
import 'package:edeybe/services/server_operation.dart';
import 'package:edeybe/utils/Debouncer.dart';
import 'package:edeybe/utils/constant.dart';
import 'package:edeybe/utils/helper.dart';
import 'package:edeybe/utils/product_num.dart';
import 'package:edeybe/widgets/ErrorBoundary.dart';
import 'package:edeybe/widgets/Shimmer.dart';
import 'package:edeybe/widgets/ShimmerLoader.dart';
import 'package:edeybe/widgets/airtime_widget.dart';
import 'package:edeybe/widgets/category_widget.dart';
import 'package:edeybe/widgets/products_grid.dart';
import 'package:edeybe/widgets/search_result_widget.dart';
import 'package:flutter/material.dart';
import 'package:edeybe/index.dart';

class HomeScreenTab extends StatefulWidget {
  @override
  _HomeScreenTabState createState() => _HomeScreenTabState();
}

class _HomeScreenTabState extends State<HomeScreenTab>
    with TickerProviderStateMixin {
  final cartegoryController = Get.find<CategoryController>();
  final searchController = Get.find<SearchController>();
  final homeController = Get.put(HomeController());
  final _searchFieldController = TextEditingController();
  final _productController = Get.find<ProductController>();
  bool showSearch = false;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  Debouncer debounce = Debouncer();
  AnimationController _animationController;
  FocusNode _focus = new FocusNode();
  Animation _animation;
  AnimationController controller;
  Animation<double> animation;
  final String bannersBaseURL = '$domain/api/static/banners/';
  List bannerUrl = [];
  @override
  void initState() {
    super.initState();
    bannerUrl = [
      // "${bannersBaseURL}banner1.png",
      // "${bannersBaseURL}banner2.png",
      // "${bannersBaseURL}banner3.png",
      // "${bannersBaseURL}banner4.png",
      "${bannersBaseURL}7.png",
      "${bannersBaseURL}8.png",
      "${bannersBaseURL}9.png",
      "${bannersBaseURL}8.png",
    ];

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
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _animationController.dispose();
    controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  void _showSearch() {
    setState(() {
      showSearch = _focus.hasFocus ? true : false;
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

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 3));
    print("Refresh");
    bannerUrl = [
      "${bannersBaseURL}banner1.png",
      "${bannersBaseURL}banner2.png",
      "${bannersBaseURL}banner3.png",
      "${bannersBaseURL}banner4.png",
    ];
    homeController.getAvailableSlugs();
    homeController.getAvailableCatsCollection();

    return null;
  }

  void _onFocusChange() {
    if (_focus.hasFocus) {
      controller.forward();
      _animationController.forward();
      _showSearch();
    }
    // else {
    //   _animationController.reverse();
    //   controller.reverse();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refreshList,
      key: refreshKey,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: Row(
            children: <Widget>[
              Expanded(
                  flex: _animation.value,
                  child: Container(
                    // padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.w),
                      color: Colors.white,
                    ),
                    height: 40.w,
                    child: TextField(
                      focusNode: _focus,
                      autofocus: false,
                      onChanged: (text) {
                        if (text.length >= 3) {
                          debounce.run(() {
                            searchController.searchProducts(text);
                          });
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
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          suffixIcon: _searchFieldController.text.length > 0
                              ? FadeTransition(
                                  opacity: Tween<double>(
                                    begin: 0.0,
                                    end: 1.0,
                                  ).animate(_animationController),
                                  child: InkWell(
                                    child: Icon(Icons.close),
                                    onTap: () {
                                      setState(() {
                                        _searchFieldController.text = "";
                                        searchController.clear();
                                      });
                                    },
                                  ))
                              : null),
                      style: TextStyle(fontSize: 14.w),
                    ),
                  )),
              showSearch
                  ? Expanded(
                      flex: 1,
                      child: FadeTransition(
                        opacity: animation,
                        child: TextButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.resolveWith(
                                  (states) => EdgeInsets.all(0))),
                          onPressed: _cancelSearch,
                          child: Text(
                            S.of(context).cancel,
                            style: TextStyle(fontSize: 15.w),
                          ),
                        ),
                      ),
                    )
                  : TextButton(
                      onPressed: () {
                        Get.to<Map<String, String>>(FilterWidget())
                            .then((value) {
                          if (value != null) {
                            _productController.resetProducts();
                            _productController.setQuery('', '',
                                reset: true, data: value, merge: true);
                            Get.to(ProductsView());
                          }
                        });
                      },
                      child: Icon(
                        Icons.filter_list_rounded,
                        size: 30.w,
                        color: Colors.white,
                      ),
                    ),
            ],
          ),
          centerTitle: false,
        ),
        body: Obx(() {
          var children = <Widget>[];
          children.add(SizedBox(
            height: 8.h,
          ));
          children.add(Container(
            height: 150.w,
            width: Get.width.w,
            child: CarouselSlider(
              itemCount: bannerUrl.length,
              autoPlay: true,
              containerHeight: 150.w,
              itemBuilder: (context, ind) => Image(
                width: Get.width.w,
                image: CachedNetworkImageProvider(
                  bannerUrl[ind],
                ),
                alignment: Alignment.center,
                fit: BoxFit.cover,
              ),
            ),
          ));
          children.add(Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                      bottom: 8.w, top: 8.w, left: 10.w, right: 10.w),
                  alignment: Alignment.bottomLeft,
                  child:
                      Text(S.of(context).shopBy + " " + S.of(context).category),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      textStyle: TextStyle(color: Constants.dark),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.transparent))),
                  onPressed: () {
                    cartegoryController
                        .getSubCategories(cartegoryController.categories[0].id);
                    Get.to(SubCategoryScreen());
                  },
                  child: Text(
                    S.current.viewAll,
                  ),
                )
              ],
            ),
          ));
          // Build categories
          children.add(_buildCategoryList());
          children.add(_buildBuyAirtimeComponent());
          children.add(_buildProductCollection());
          children.add(_buildTopCategorySlugsProducts());

          return Shimmer(
            linearGradient: Constants.shimmerGradient,
            child: GetBuilder<HomeController>(
                builder: (hc) => ErrorBoundary(
                    child: Stack(
                      children: <Widget>[
                        SingleChildScrollView(
                          child: Column(children: children),
                        ),
                        if (showSearch)
                          SearchResultWidget(closeSearch: _cancelSearch)
                      ],
                    ),
                    canceled: hc.canceled.value,
                    connectionError: hc.connectionError.value,
                    serverError: hc.serverError.value,
                    onRetry: () => hc.onInit())),
          );
        }),
      ),
    );
  }

  Widget _buildCategoryList() {
    if (cartegoryController.loading.value) {
      return Container(
          color: Colors.white,
          constraints: BoxConstraints(maxHeight: 90.w),
          width: Get.width,
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  8,
                  (e) => Container(
                    // color: Colors.white,
                    margin: EdgeInsets.all(10.w),
                    child: CategoryWidget(
                      item: null,
                      onTap: null,
                    ),
                  ),
                ),
              )));
    } else if (cartegoryController.categories.length > 0) {
      return Container(
          color: Colors.white,
          constraints: BoxConstraints(maxHeight: 90.w),
          width: Get.width,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: cartegoryController.categories
                  .map((e) => Container(
                        margin: EdgeInsets.all(10.w),
                        child: CategoryWidget(
                          item: e,
                          onTap: () {
                            cartegoryController.getSubCategories(e.id);
                            Get.to(SubCategoryScreen());
                          },
                        ),
                      ))
                  .toList(),
            ),
          ));
    } else {
      return Container(
          constraints: BoxConstraints(maxHeight: 90.w),
          width: Get.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(10.w),
                child: Text("No categories available"),
              )
            ],
          ));
    }
  }

  Widget _buildBuyAirtimeComponent() {
    return GestureDetector(
      onTap: _buyAirtime,
      child: Container(
        margin: EdgeInsets.only(bottom: 5.w),
        width: Get.width.w,
        height: 50.w,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Constants.themeGreyDark,
                  spreadRadius: 0.2,
                  offset: Offset(2, 1),
                  blurRadius: 3.0)
            ],
            image: DecorationImage(
                image: AssetImage('assets/images/airtime_btn_background.png'))),
      ),
    );
  }

  Widget _buildProductCollection() {
    List<Widget> segment = [];
    if (homeController.loadingCollections.value) {
      List.generate(3, (value) {
        segment.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(
                    bottom: 8.w, top: 8.w, left: 10.w, right: 10.w),
                alignment: Alignment.bottomLeft,
                child: ShimmerLoading(
                  isLoading: homeController.loadingCollections.value,
                  child: Helper.textPlaceholder,
                )),
            TextButton(
              style: TextButton.styleFrom(
                  textStyle: TextStyle(color: Constants.dark),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.transparent))),
              onPressed: null,
              child: Text(
                S.current.viewAll,
              ),
            )
          ],
        ));
        segment.add(ShimmerLoading(
            isLoading: homeController.loadingCollections.value,
            child: Container(
              width: Get.width.w,
              color: Colors.black,
              height: 80.w,
            )));
        segment.add(ProductsGrid(
          isLoading: homeController.loadingCollections.value,
          products: [],
        ));
      });
    } else if (homeController.productCollection.isEmpty) {
      return Container(
          constraints: BoxConstraints(maxHeight: 90.w),
          width: Get.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(10.w),
                child: Text("Product collections not available"),
              )
            ],
          ));
    } else {
      homeController.productCollection.forEach((value) {
        if (value.products.length > 0) {
          segment.add(Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    bottom: 8.w, top: 8.w, left: 10.w, right: 10.w),
                alignment: Alignment.bottomLeft,
                child: Text(value.name.toUpperCase(),
                    style: Get.textTheme.bodyText1
                        .copyWith(color: Constants.dark)),
              ),
              TextButton(
                style: TextButton.styleFrom(
                    textStyle: TextStyle(color: Constants.dark),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.transparent))),
                onPressed: () {
                  Get.to(ProductsView(type: ProductType.Slugs));
                },
                child: Text(
                  S.current.viewAll,
                ),
              )
            ],
          ));
          if (value.image.isNotEmpty) {
            segment.add(Container(
              width: Get.width.w,
              child: CarouselSlider(
                itemCount: value.image.length,
                autoPlay: true,
                showDots: false,
                showControlButton: true,
                containerHeight: 100.w,
                itemBuilder: (context, ind) => Image(
                  width: Get.width.w,
                  image: CachedNetworkImageProvider(
                    "$bannersBaseURL${value.image[ind]['image']}",
                  ),
                  alignment: Alignment.center,
                  fit: BoxFit.cover,
                ),
              ),
            ));
          }
          segment.add(ProductsGrid(
            scrollDirection: Axis.vertical,
            products: value.products,
          ));
        }
      });
    }
    return Container(
        margin: EdgeInsets.only(bottom: 20.w),
        color: Colors.white,
        child: Wrap(
          children: segment,
        ));
  }

  Widget _buildTopCategorySlugsProducts() {
    List<Widget> children = [];
    if (homeController.loadingCategorySlugsProducts.value) {
      var tabs = <Widget>[];
      var tabViews = <Widget>[];

      tabs.add(Tab(
          child:
              ShimmerLoading(isLoading: true, child: Helper.textPlaceholder)));
      tabViews.add(ProductsGrid(
        isLoading: true,
        products: [],
      ));

      tabs.add(Tab(
          child:
              ShimmerLoading(isLoading: true, child: Helper.textPlaceholder)));
      tabViews.add(ProductsGrid(
        isLoading: true,
        products: [],
      ));

      tabs.add(Tab(
          child:
              ShimmerLoading(isLoading: true, child: Helper.textPlaceholder)));
      tabViews.add(ProductsGrid(
        isLoading: true,
        products: [],
      ));

      children.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding:
                EdgeInsets.only(bottom: 8.w, top: 8.w, left: 10.w, right: 10.w),
            alignment: Alignment.bottomLeft,
            child:
                ShimmerLoading(isLoading: true, child: Helper.textPlaceholder),
          ),
          TextButton(
            style: TextButton.styleFrom(
                textStyle: TextStyle(color: Constants.dark),
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.transparent))),
            onPressed: () {},
            child: Text(
              S.current.viewAll,
            ),
          )
        ],
      ));
      children.add(ShimmerLoading(
        isLoading: true,
        child: Container(
          width: Get.width.w,
          child: CarouselSlider(
            itemCount: 1,
            autoPlay: true,
            showDots: false,
            showControlButton: true,
            containerHeight: 100.w,
            itemBuilder: (context, ind) => Container(
              width: Get.width.w,
              color: Colors.black,
              height: 100.w,
            ),
          ),
        ),
      ));
      if (tabs.isNotEmpty) {
        children.add(DefaultTabController(
          length: tabs.length,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TabBar(
                isScrollable: true,
                labelColor: Get.textTheme.bodyText1.color,
                tabs: tabs,
              ),
              SizedBox(
                  height: 300.w,
                  width: Get.width,
                  child: TabBarView(children: tabViews))
            ],
          ),
        ));
      }
    } else if (homeController.categoryProducts.isEmpty) {
      return Container(
          constraints: BoxConstraints(maxHeight: 90.w),
          width: Get.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(10.w),
                child: Text("Product not available"),
              )
            ],
          ));
    } else {
      homeController.categoryProducts.forEach((value) {
        var tabs = <Widget>[];
        var tabViews = <Widget>[];

        if (value.newArrival != null && value.newArrival.isNotEmpty) {
          tabs.add(Tab(
              child: Text("New Arrivals",
                  style: TextStyle(color: Constants.themeBlue))));
          tabViews.add(ProductsGrid(
            // scrollDirection: Axis.vertical,
            products: value.newArrival,
          ));
        }
        if (value.bestSeller != null && value.bestSeller.isNotEmpty) {
          tabs.add(Tab(
              child: Text("Best Seller",
                  style: TextStyle(color: Constants.themeBlue))));
          tabViews.add(ProductsGrid(
            // scrollDirection: Axis.vertical,
            products: value.bestSeller,
          ));
        }
        if (value.recommended != null && value.recommended.isNotEmpty) {
          tabs.add(Tab(
              child: Text("Recommended for You",
                  style: TextStyle(color: Constants.themeBlue))));
          tabViews.add(ProductsGrid(
            // scrollDirection: Axis.vertical,
            products: value.recommended,
          ));
        }
        if (value.image.isNotEmpty && tabs.isNotEmpty) {
          children.add(Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    bottom: 8.w, top: 8.w, left: 10.w, right: 10.w),
                alignment: Alignment.bottomLeft,
                child: Text(value.name.toUpperCase(),
                    style: Get.textTheme.bodyText1
                        .copyWith(color: Constants.dark)),
              ),
              TextButton(
                style: TextButton.styleFrom(
                    textStyle: TextStyle(color: Constants.dark),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.transparent))),
                onPressed: () {
                  Get.to(ProductsView(
                      type: ProductType.Collection,
                      id: value.image[0]['categoryId']));
                },
                child: Text(
                  S.current.viewAll,
                ),
              )
            ],
          ));

          children.add(Container(
            width: Get.width.w,
            child: CarouselSlider(
              itemCount: value.image.length,
              autoPlay: true,
              showDots: false,
              showControlButton: true,
              containerHeight: 100.w,
              itemBuilder: (context, ind) => Image(
                width: Get.width.w,
                image: CachedNetworkImageProvider(
                  "$bannersBaseURL${value.image[ind]["image"]}",
                ),
                alignment: Alignment.center,
                fit: BoxFit.cover,
              ),
            ),
          ));
        }
        if (tabs.isNotEmpty) {
          children.add(DefaultTabController(
            length: tabs.length,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TabBar(
                  isScrollable: true,
                  labelColor: Get.textTheme.bodyText1.color,
                  tabs: tabs,
                ),
                SizedBox(
                    height: 270.w,
                    width: Get.width,
                    child: TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        children: tabViews))
              ],
            ),
          ));
        }
      });
    }
    return Container(
        margin: EdgeInsets.only(bottom: 20.w),
        color: Colors.white,
        child: Wrap(
          children: children,
        ));
  }

  void _buyAirtime() {
    Get.to(
      AirtimeWiget(),
    );
  }
}
