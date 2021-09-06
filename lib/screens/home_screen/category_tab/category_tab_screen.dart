import 'package:edeybe/controllers/category_controller.dart';
import 'package:edeybe/controllers/product_controller.dart';
import 'package:edeybe/controllers/search_controller.dart';
import 'package:edeybe/index.dart';
import 'package:edeybe/screens/checkout_screen/index.dart';
import 'package:edeybe/screens/filter/fillter_widget.dart';
import 'package:edeybe/screens/products_view/products.dart';
import 'package:edeybe/widgets/Shimmer.dart';
import 'package:edeybe/widgets/category_widget.dart';
import 'package:edeybe/widgets/search_result_widget.dart';
import 'package:flutter/material.dart';

import 'sub_category_screen.dart';

class CategoryTabScreen extends StatefulWidget {
  @override
  _CategoryTabScreenState createState() => _CategoryTabScreenState();
}

class _CategoryTabScreenState extends State<CategoryTabScreen>
    with TickerProviderStateMixin {
  final cartegoryController = Get.find<CategoryController>();
  final searchController = Get.find<SearchController>();
  final _searchFieldController = TextEditingController();
  final _productController = Get.find<ProductController>();
  bool showSearch = false;
  AnimationController _animationController;
  FocusNode _focus = new FocusNode();
  Animation _animation;
  AnimationController controller;
  Animation<double> animation;
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(milliseconds: 100), vsync: this);
    _animation = IntTween(begin: 5, end: 3).animate(_animationController);
    controller =
        AnimationController(duration: Duration(milliseconds: 100), vsync: this);
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
    searchController.clear();
    setState(() {
      showSearch = false;
    });
    _animationController.reverse();
    controller.reverse();
    _searchFieldController.text = "";
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
    return Shimmer(
      linearGradient: Constants.shimmerGradient,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: Row(
            children: <Widget>[
              Expanded(
                  flex: _animation.value,
                  child: Container(
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
                          searchController.searchProducts(text);
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
        body: Obx(() => Stack(children: [
              GridView.count(
                padding: EdgeInsets.all(10.w),
                crossAxisCount: 3,
                // mainAxisSpacing: 20,
                children: cartegoryController.categories
                    .map((item) => CategoryWidget(
                          item: item,
                          onTap: () {
                            cartegoryController.getSubCategories(item.id);
                            Get.to(SubCategoryScreen());
                          },
                        ))
                    .toList(),
              ),
              if (showSearch) SearchResultWidget(closeSearch: _cancelSearch)
            ])),
      ),
    );
  }
}
