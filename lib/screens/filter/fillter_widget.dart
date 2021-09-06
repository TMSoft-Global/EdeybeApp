import 'package:edeybe/controllers/category_controller.dart';
import 'package:edeybe/controllers/product_controller.dart';
import 'package:edeybe/index.dart';
import 'package:edeybe/models/category.dart';
import 'package:edeybe/models/subcategory.dart';
import 'package:edeybe/screens/filter/apply_filter.dart';
import 'package:edeybe/screens/home_screen/category_tab/sub_category_screen.dart';
import 'package:edeybe/utils/Debouncer.dart';
import 'package:edeybe/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FilterWidget extends StatefulWidget {
  FilterWidget({Key key}) : super(key: key);

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  final _productController = Get.find<ProductController>();
  final _categoryController = Get.find<CategoryController>();
  final List helpList = [
    "Category",
    "Price",
    "Sort Order",
    // "Brand",
    // "Color",
    // "Seller",
    // "Shipping Options",
    // "Title",
  ];
  int expandedTile;
  int totalPossible;
  String sortValue;
  double _minPrice = 0;
  double _maxPrice = 10000;
  Debouncer debounce = Debouncer();
  RangeValues price = RangeValues(0, 10000);
  TextEditingController _maxPriceCtrl = TextEditingController();
  TextEditingController _minPriceCtrl = TextEditingController();
  SubCategory selectedSubCat;
  Category selectedCat;
  List<DropdownMenuItem<String>> sortByOptions = [
    DropdownMenuItem(child: Text("Popularity"), value: "popularity"),
    DropdownMenuItem(child: Text("New Arrivals"), value: "newarrivals"),
    DropdownMenuItem(child: Text("Price: Low to High"), value: "pricelow"),
    DropdownMenuItem(child: Text("Price High to Low"), value: "pricehigh"),
  ];
  @override
  void initState() {
    _minPriceCtrl.text = price.start.ceil().toString();
    _maxPriceCtrl.text = price.end.ceil().toString();
    super.initState();
  }

  void setTotal() {
    debounce.run(() => setState(() {
          _productController.getTotalPossible(
              queryOption: buildFilterQuery(),
              then: (total) => setState(() {
                    totalPossible = total;
                  }));
        }));
  }

  void setSort(String sort) {
    setState(() {
      sortValue = sort;
    });
    setTotal();
  }

  void clearFilter() {
    setState(() {
      totalPossible = 0;
      price = RangeValues(0, 10000);
      _maxPriceCtrl.text = price.end.toString();
      _minPriceCtrl.text = price.start.toString();
      selectedCat = null;
    });
  }

  Map<String, String> buildFilterQuery() {
    Map<String, String> result = {};
    if (_maxPriceCtrl.text != _minPrice.toString() ||
        _maxPriceCtrl.text != _maxPrice.toString()) {
      result['price'] = '${_minPriceCtrl.text}-${_maxPriceCtrl.text}';
    }

    if (selectedCat != null) {
      result['subcategory'] = selectedSubCat.id;
    }
    if (sortValue != null) {
      result['sort'] = sortValue;
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ApplyFillterBottomBar(
        totalPossible: totalPossible,
        onApply: () {
          Get.back(result: buildFilterQuery());
        },
      ),
      appBar: AppBar(
        centerTitle: false,
        brightness: Brightness.dark,
        iconTheme: Get.theme.iconTheme.copyWith(color: Colors.white),
        automaticallyImplyLeading: true,
        title:
            Text(S.of(context).filter, style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          GestureDetector(
            child: Container(
              padding: EdgeInsets.all(10.w),
              alignment: Alignment.center,
              child: Text(
                "${S.of(context).reset}",
                maxLines: 1,
                style: TextStyle(color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            onTap: () {
              _productController.setQuery("", "", reset: true);
              clearFilter();
            },
          ),
        ],
      ),
      body: ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return ListTile(
              trailing: Icon(
                expandedTile == index
                    ? Icons.keyboard_arrow_down
                    : Icons.keyboard_arrow_right,
                color: Constants.mainColor,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${helpList[index]}"),
                  if (selectedSubCat != null && selectedCat != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(selectedCat?.name),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 15.w,
                        ),
                        Text(selectedSubCat.name),
                      ],
                    )
                ],
              ),
              onTap: () {
                Get.to<List>(SubCategoryScreen(
                        showRetailResult: true,
                        subCategory: selectedSubCat?.id))
                    .then((cat) {
                  if (cat != null) {
                    setState(() {
                      selectedCat = cat[1];
                      selectedSubCat = cat[0];
                    });
                    setTotal();
                  }
                });
              },
            );
          } else if (index != 2) {
            return ExpansionTile(
              onExpansionChanged: (isExpanded) {
                setState(() {
                  if (isExpanded) {
                    expandedTile = index;
                  } else {
                    expandedTile = null;
                  }
                });
              },
              trailing: Icon(
                expandedTile == index
                    ? Icons.keyboard_arrow_down
                    : Icons.keyboard_arrow_right,
                color: Constants.mainColor,
              ),
              title: Text(helpList[index]),
              children: <Widget>[
                if (index == 1)
                  Column(
                    children: <Widget>[
                      RangeSlider(
                        values: price,
                        onChanged: (value) => setState(() {
                          price = value;
                          _minPriceCtrl.text = value.start.ceil().toString();
                          _maxPriceCtrl.text = value.end.ceil().toString();
                          setTotal();
                        }),
                        max: 10000,
                        min: 0,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[Text("From"), Text("To")],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 8.w),
                                child: TextField(
                                  controller: _minPriceCtrl,
                                  onChanged: (value) => setState(() {
                                    var val = double.parse(value);
                                    val = val >= _minPrice && val < price.end
                                        ? val
                                        : price.start;
                                    price = RangeValues(val, price.end);
                                    setTotal();
                                  }),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  keyboardType: TextInputType.numberWithOptions(
                                      signed: true),
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.all(8.w),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Constants.themeGreyLight,
                                            width: 1.0.w),
                                        borderRadius:
                                            BorderRadius.circular(5.w)),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 50.w,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 8.w),
                                child: TextField(
                                  controller: _maxPriceCtrl,
                                  onChanged: (value) => setState(() {
                                    var val = double.parse(value);
                                    val = val <= _maxPrice && val > price.start
                                        ? val
                                        : price.end;
                                    price = RangeValues(price.start, val);
                                    setTotal();
                                  }),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  keyboardType: TextInputType.numberWithOptions(
                                      signed: true),
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.all(8.w),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Constants.themeGreyLight,
                                            width: 1.0.w),
                                        borderRadius:
                                            BorderRadius.circular(5.w)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                if (index != 1)
                  Container(
                    child: Text("""Your Visa, Master and American Express
payments are going through secure payment
gateways operated by the respective banks.
Your card details will be securely transmitted
to the Bank for transaction authorization
using SSL 128bit encryption."""),
                  )
              ],
            );
          } else {
            return Container(
              constraints: BoxConstraints(maxHeight: 47.w),
              height: 47.w,
              decoration: BoxDecoration(
                  border:
                      Border.all(width: 1.w, color: Constants.themeGreyDark),
                  borderRadius: BorderRadius.circular(4.w)),
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
              margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: Text(helpList[index]),
                  value: sortValue,
                  onChanged: setSort,
                  items: sortByOptions,
                ),
              ),
            );
          }
        },
        itemCount: helpList.length,
      ),
    );
  }
}
