import 'package:edeybe/controllers/category_controller.dart';
import 'package:edeybe/models/category.dart';
import 'package:edeybe/screens/checkout_screen/index.dart';
import 'package:edeybe/screens/products_view/products.dart';
import 'package:edeybe/widgets/Shimmer.dart';
import 'package:edeybe/widgets/category_widget.dart';
import 'package:flutter/material.dart';
import 'package:edeybe/index.dart';

class SubCategoryScreen extends StatelessWidget {
  final bool showRetailResult;
  final String subCategory;

  SubCategoryScreen({Key key, this.showRetailResult = false, this.subCategory})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CategoryController>();
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          title: Text(
            S.of(context).category,
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Obx(() => Shimmer(
            linearGradient: Constants.shimmerGradient,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 2,
                    child: Obx(() => SingleChildScrollView(
                          child: Wrap(
                            children: controller.categories
                                .map((e) => GestureDetector(
                                      onTap: () {
                                        controller.getSubCategories(e.id);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color:
                                              controller.selectedParent == e.id
                                                  ? Theme.of(context)
                                                      .scaffoldBackgroundColor
                                                  : Colors.grey.withAlpha(20),
                                          border: Border(
                                              top: BorderSide(
                                                color:
                                                    Colors.grey.withAlpha(30),
                                              ),
                                              bottom: BorderSide(
                                                color:
                                                    Colors.grey.withAlpha(30),
                                              )),
                                        ),
                                        height: 55.w,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              color:
                                                  controller.selectedParent ==
                                                          e.id
                                                      ? Theme.of(context)
                                                          .primaryColor
                                                      : null,
                                              width: 3.w,
                                            ),
                                            Expanded(
                                              child: Container(
                                                padding: EdgeInsets.all(5.w),
                                                child: Text(
                                                  e.name,
                                                  textAlign: TextAlign.center,
                                                  softWrap: true,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ))),
                Expanded(
                    flex: 5,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(2),
                            child: !showRetailResult
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        S.of(context).topCategories,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      TextButton(
                                          style: TextButton.styleFrom(
                                            shape: RoundedRectangleBorder(),
                                          ),
                                          onPressed: () {
                                            Get.off(ProductsView(
                                                type: Category(
                                                    id: controller
                                                        .selectedParent)));
                                          },
                                          child: Text(
                                            S.of(context).viewAll.toUpperCase(),
                                            style: Get.textTheme.button
                                                .copyWith(
                                                    color: Constants
                                                        .themeBlueLight,
                                                    fontSize: 12.w),
                                          ))
                                    ],
                                  )
                                : SizedBox.shrink(),
                          ),
                          controller.subCategories.isNotEmpty
                              ? GridView.count(
                                  physics: NeverScrollableScrollPhysics(),
                                  crossAxisCount: 3,
                                  shrinkWrap: true,
                                  mainAxisSpacing: 18,
                                  children: controller.subCategories
                                      .map(
                                        (item) => CategoryWidget(
                                          isActive: controller.selectedChild ==
                                              item.id,
                                          item: item,
                                          onTap: () {
                                            showRetailResult
                                                ? Get.back(result: [
                                                    item,
                                                    controller.categories
                                                        .firstWhere((element) =>
                                                            element.id ==
                                                            controller
                                                                .selectedParent)
                                                  ])
                                                : Get.off(
                                                    ProductsView(type: item));
                                          },
                                        ),
                                      )
                                      .toList(),
                                )
                              : Center(
                                  child: Container(
                                    padding: EdgeInsets.all(20),
                                    child: Text(
                                        "Select a cetegory to the it's subcategories"),
                                  ),
                                ),
                          // Padding(
                          //   padding: EdgeInsets.all(2),
                          //   child: Text(
                          //     "${S.of(context).shopBy} Brand",
                          //     style: Theme.of(context)
                          //         .textTheme
                          //         .bodyText1
                          //         .copyWith(
                          //           fontWeight: FontWeight.bold,
                          //         ),
                          //   ),
                          // ),
                        ],
                      ),
                    )),
              ],
            ))));
  }
}
