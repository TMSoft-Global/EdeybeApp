import 'package:edeybe/screens/checkout_screen/index.dart';
import 'package:edeybe/services/server_operation.dart';
import 'package:edeybe/widgets/ShimmerLoader.dart';
import 'package:flutter/material.dart';
import 'package:edeybe/index.dart';
import 'package:edeybe/models/category.dart';

class CategoryWidget extends StatelessWidget {
  final void Function() onTap;
  final dynamic item;
  final bool isLoading;
  final bool isActive;
  final String catImagePath =
      "$domain/api/static/categories/icon/";
  final String subCatImagePath =
      "$domain/api/static/subCategories/imageIcon/";
  CategoryWidget(
      {this.item, this.onTap, this.isLoading = false, this.isActive = false});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 35.w,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: isActive
                    ? Border.all(color: Constants.themeBlue)
                    : Border.all(color: Colors.transparent)),
            child: ShimmerLoading(
              isLoading: isLoading,
              child: Container(
                child: item == null || item.image == null
                    ? Container(
                        width: 40.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0XFFF6F6F6),
                        ),
                      )
                    : item is Category
                        ? SvgPicture.network(
                            catImagePath + item.image ?? '',
                            color: Constants.dark.withOpacity(0.8),
                            width: 35.w,
                          )
                        : CachedNetworkImage(
                            imageUrl: subCatImagePath + item.image ?? '',
                            width: 35.w,
                          ),
              ),
            ),
          ),
          Container(
            child: ShimmerLoading(
              isLoading: isLoading,
              child: Container(
                child: item == null || item.image == null
                    ? Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0XFFF6F6F6),
                        ),
                        margin: EdgeInsets.only(top: 5.w),
                        height: 10.w,
                        width: 50.w,
                      )
                    : Container(
                        margin: EdgeInsets.only(top: 5.w),
                        padding: EdgeInsets.all(1.w),
                        child: Text(
                          item.name,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
