import 'package:edeybe/controllers/address_controller.dart';
import 'package:edeybe/controllers/delivery_coltroller.dart';
import 'package:edeybe/index.dart';
import 'package:edeybe/models/deliveryModel.dart';
import 'package:edeybe/screens/address_screen/add_edit_address/add_edit_address.dart';
import 'package:edeybe/utils/constant.dart';
import 'package:edeybe/widgets/address_card.dart';
import 'package:edeybe/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';

class AddressScreen extends StatefulWidget {
  AddressScreen(
      {Key key, this.hasContinueButton = false, this.onContinuePressed})
      : super(key: key);
  final bool hasContinueButton;
  final VoidCallback onContinuePressed;

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _addressController = Get.find<AddressController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        iconTheme: Get.theme.iconTheme.copyWith(color: Colors.white),
        automaticallyImplyLeading: true,
        title:
            Text(S.of(context).address, style: TextStyle(color: Colors.white)),
      ),
      bottomNavigationBar: widget.hasContinueButton
          ? GetBuilder<AddressController>(
              builder: (_) => Container(
                    padding: EdgeInsets.all(10.w),
                    height: 85.h,
                    child: Center(
                      widthFactor: 1.w,
                      child: Container(
                        width: Get.width,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.w)),
                            backgroundColor: Get.theme.primaryColor,
                            // disabledColor: Constants.themeGreyLight,
                            onSurface:
                                Get.theme.primaryColor.withOpacity(0.5.w),
                          ),
                          child: Text(
                            "${S.of(context).continueText.toUpperCase()}",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: _addressController.selectedAddress !=
                                      null &&
                                  _addressController.selectedAddress.id !=
                                      null
                              ? widget.onContinuePressed
                              : null,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            top: BorderSide(
                          color: Colors.grey[200],
                          width: 1.0,
                        ))),
                  ))
          : null,
      body: Obx(()=>
             ListView.builder(
              itemCount: 1 + _addressController.delivery.length,
              itemBuilder: (_, i) {
                if (i == _addressController.delivery.length) {
                  return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.w),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 2.w,
                              offset: Offset(0, 3.4.w),
                              color: Constants.boxShadow,
                            )
                          ]),
                      margin: EdgeInsets.all(10.w),
                      padding: EdgeInsets.all(0.0),
                      child: TextButton.icon(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.w)),
                        ),
                        icon: Icon(
                          Icons.add,
                        ),
                        label: Text(S.of(context).addAddress),
                        onPressed: () {
                          Get.to(AddorEditScreen());
                        },
                      ));
                }
                // var address =_addressController.addresses != null ? _addressController.addresses[0]:null;
                var delivery = _addressController.delivery[i];
      
                // return Text(address.email);
                // print("${address.email}----------------------------");
                // var data =address.deliveryAddresses[0];
                return AddressCard(
                  // onCardPressed: (){},
                  onEditAddress: (){
                          Get.to(AddorEditScreen(
                            address: delivery,
                          ));

                  },
                  // onRemoveAddress: (){},
                  // onChangeButtonPressed: (){
                  //   print("object");
                  // },
                  address: null,
                  onCardPressed: widget.hasContinueButton
                      ? () {
                        setState((){
                          if(delivery.isSelect == true){
                            delivery.isSelect = false;
                          }else{
                            delivery.isSelect = true;
                             _addressController.setDeliveryAddress(delivery);
                          }
                        });
 }
                      : null,
                  // address: address,
                  deliveryAddress: delivery,
                  // onEditAddress: () =>
                  //     Get.to(AddorEditScreen(address: address)),
                  onRemoveAddress: () => _removeAddress(delivery),
                  isSelected: _addressController.selectedAddress != null &&
                      _addressController.selectedAddress.id ==
                          delivery.id &&
                      widget.hasContinueButton,
                );
              })),
    );
  }

  void _removeAddress(DeliveryAddress i) {
    Get.dialog(CustomDialog(
      title: S.current.removeAdrress,
      content: S.current.removeAddressMessage,
      confrimPressed: () {
        _addressController.deleteAddress(i);
        Get.back();
      },
      cancelText: S.current.no,
      confrimText: S.current.yes,
    ));
  }
}
