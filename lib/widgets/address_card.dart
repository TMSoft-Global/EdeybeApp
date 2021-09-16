import 'package:edeybe/index.dart';
import 'package:edeybe/models/deliveryModel.dart';
import 'package:edeybe/utils/constant.dart';
import 'package:flutter/material.dart';

class AddressCard extends StatelessWidget {
  final ShippingAddress address;
  final DeliveryAddress deliveryAddress;
  final VoidCallback onRemoveAddress;
  final VoidCallback onEditAddress;
  final VoidCallback onCardPressed;
  final bool isSelected;
  AddressCard(
      {Key key,
      @required this.onCardPressed,
      @required this.address,
      @required this.deliveryAddress,
      @required this.onEditAddress,
      this.showChangeButton = false,
      this.onChangeButtonPressed,
      @required this.onRemoveAddress,
      this.isSelected = false})
      : super(key: key);
  final bool showChangeButton;
  final VoidCallback onChangeButtonPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onCardPressed,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.w),
            color: Colors.white,
            border: isSelected
                ? Border.symmetric(
                    vertical: BorderSide(color: Get.theme.primaryColor),
                    horizontal: BorderSide(color: Get.theme.primaryColor))
                : null,
            boxShadow: [
              BoxShadow(
                color: Constants.boxShadow,
                blurRadius: 3.4.w,
                offset: Offset(0, 3.4.w),
              )
            ]),
        margin: EdgeInsets.fromLTRB(10.w, 10.w, 10.w, 10.w),
        padding: EdgeInsets.fromLTRB(15.w, 5.w, 15.w, 20.w),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Text(
                      'Delivery Address',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 18.w, fontWeight: FontWeight.w800)),
                  ),
                ),
                if (onRemoveAddress != null || onEditAddress != null)
                  Expanded(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        if (onEditAddress != null)
                          Padding(
                            padding: EdgeInsets.all(0),
                            child: TextButton.icon(
                              icon: Icon(
                                FontAwesomeIcons.edit,
                                size: 13.w,
                                color: Constants.themeGreyDark,
                              ),
                              label: Text(
                                S.of(context).edit,
                                style: TextStyle(
                                    fontSize: 13.w,
                                    color: Constants.themeGreyDark),
                              ),
                              onPressed: onEditAddress,
                            ),
                          ),
                        if (onRemoveAddress != null)
                          Padding(
                              padding: EdgeInsets.all(0),
                              child: Container(
                                child: TextButton.icon(
                                  icon: Icon(
                                    FontAwesomeIcons.trash,
                                    size: 13.w,
                                    color: Constants.themeGreyDark,
                                  ),
                                  label: Text(S.of(context).remove,
                                      style: TextStyle(
                                          fontSize: 13.w,
                                          color: Constants.themeGreyDark)),
                                  onPressed: onRemoveAddress,
                                ),
                              )),
                        if (showChangeButton)
                          Padding(
                              padding: EdgeInsets.all(0),
                              child: Container(
                                child: TextButton.icon(
                                  icon: Icon(
                                    Icons.swap_vert,
                                    size: 13.w,
                                    color: Constants.themeGreyDark,
                                  ),
                                  label: Text(S.of(context).change,
                                      style: TextStyle(
                                          fontSize: 13.w,
                                          color: Constants.themeGreyDark)),
                                  onPressed: onChangeButtonPressed,
                                ),
                              )),
                      ],
                    ),
                  ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Text("Place Name",
                        style: TextStyle(color: Constants.themeGreyDark)),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 10.w,
                    ),
                    child: Text(
                      deliveryAddress.placeName
                      // "${address.firstName} ${address.lastName}",
                      
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Text(S.of(context).address,
                        style: TextStyle(color: Constants.themeGreyDark)),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 10.w,
                    ),
                    child: Text(
                      deliveryAddress.displayText ?? "",
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Text("Longitude",
                        style: TextStyle(color: Constants.themeGreyDark)),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 10.w,
                    ),
                    child: Text(
                      deliveryAddress.long ?? "",
                      
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Text("Latitude",
                        style: TextStyle(color: Constants.themeGreyDark)),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 10.w,
                    ),
                    child: Text(
                      deliveryAddress.lat ?? "",
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
