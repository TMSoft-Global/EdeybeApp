import 'package:edeybe/controllers/user_controller.dart';
import 'package:edeybe/index.dart';
import 'package:edeybe/models/product.dart' as ProductModel;
import 'package:edeybe/screens/auth_screen/login_screen.dart';
import 'package:edeybe/screens/product_details_screen/product_details_screen.dart';
import 'package:edeybe/screens/review_screen/review_bottom_bar/reveiw_bottom_bar.dart';
import 'package:edeybe/screens/review_screen/write_review/write_review.dart';
import 'package:edeybe/utils/constant.dart';
import 'package:edeybe/utils/helper.dart';
import 'package:edeybe/widgets/start_rating.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReviewScreen extends StatelessWidget {
  ReviewScreen({Key key, this.product, this.reviews}) : super(key: key);

  final ProductModel.Product product;
  final List<Map<String, dynamic>> reviews;
  final _userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text(
          S.of(context).reviews,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _userController.user == null
                  ? Helper.signInRequired(
                      "You must sign in to rate and write reviews",
                      () {
                        // _userController.logout();
                      },
                    )
                  : Get.to(WriteReviewScreen());
            },
          ),
        ],
      ),
      bottomNavigationBar: ReviewBottomBar(
        onWriteReview: () => !_userController.isLoggedIn()
            ? Helper.signInRequired(
                "You must sign in to rate and write reviews",
                () => Get.offAll(LoginScreen()),
              )
            : Get.to(WriteReviewScreen()),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 8.w, left: 8.w, right: 8.w),
        child: ListView.builder(
            itemCount: 1 + reviews.length,
            itemBuilder: (_, i) {
              if (i == 0) {
                return GestureDetector(
                  onTap: () => Get.to(ProductDetailsScreen()),
                  child: Container(
                      padding: EdgeInsets.only(
                          left: 10.w, right: 10.w, top: 5.w, bottom: 5.w),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.grey.withOpacity(0.1),
                                  width: 5))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 20.w,
                                  top: 5.w,
                                  bottom: 5.w,
                                  right: 20.w),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 20.w),
                                        child: Image(
                                          width: 100.w,
                                          image: CachedNetworkImageProvider(
                                            this.product.image.sm,
                                          ),
                                          alignment: Alignment.center,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 8.w),
                                                  child: Text(
                                                    this.product.name.tr,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        fontSize: 14.w,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          S.of(context).brand +
                                                              " : ${this.product.brand}",
                                                          style: TextStyle(
                                                              fontSize: 12.w,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 2,
                                                        ),
                                                        Text(
                                                          "${this.product.priceRange.minimumPrice.finalPrice.currency} ${this.product.priceRange.minimumPrice.finalPrice.value}"
                                                              .tr,
                                                          style: TextStyle(
                                                              fontSize: 15.w,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                        ),
                                                      ],
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 0.w,
                                                                left: 10.w),
                                                        child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: <Widget>[
                                                              StarRating(
                                                                starCount: 5,
                                                                color: Constants
                                                                    .ratingBG,
                                                                allowHalfRating:
                                                                    true,
                                                                rating: 3.3,
                                                                size: 15.w,
                                                              ),
                                                              Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(5
                                                                            .w),
                                                                child: Text(
                                                                  "(18 ${S.of(context).rating})",
                                                                  maxLines: 2,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                              .grey[
                                                                          400],
                                                                      fontSize:
                                                                          13.w,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                            ]),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      )),
                );
              }
              var review = reviews[i - 1];
              return ListTile(
                  // dense: true,
                  leading: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                        "https://ae.edeybe.com/en/pub/media/wysiwyg/home-v4/Egypt_slider_mobile_EN-min.jpg"),
                  ),
                  isThreeLine: true,
                  title: Text(review["name"],
                      style: Get.textTheme.bodyText1.copyWith(
                          fontWeight: FontWeight.w600, fontSize: 16.w)),
                  subtitle: Container(
                    constraints: BoxConstraints(maxHeight: 40.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              StarRating(
                                starCount: 5,
                                color: Constants.ratingBG,
                                allowHalfRating: true,
                                rating: review["rating"],
                                size: 15.w,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 8.w, right: 8.w),
                                child: Text(review["moment"],
                                    maxLines: 2,
                                    style: Get.textTheme.bodyText1.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.w)),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Text(review["review"],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Get.textTheme.bodyText1.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.w)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ));
            }),
      ),
    );
  }
}
