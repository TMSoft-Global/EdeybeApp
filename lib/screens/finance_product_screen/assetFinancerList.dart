import 'package:edeybe/controllers/assetFinanceController.dart';
import 'package:edeybe/screens/finance_product_screen/kyc_form.dart';
import 'package:edeybe/widgets/empty_list_widget.dart';
import 'package:flutter/material.dart';

import '../../index.dart';

class AssetFinancersList extends StatelessWidget {
  final _assetFinancers = Get.put(AssetFinanceController());
  final firstName, lastName, email;
  var products;
  AssetFinancersList(
      {@required this.firstName,
      @required this.email,
      @required this.lastName,
      @required this.products});

  @override
  Widget build(BuildContext context) {
    return Container(child: Obx(() {
      return Column(
        children: [
          if (_assetFinancers.assetFinance.isNotEmpty)
            for (var x in _assetFinancers.assetFinance)
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            width: 0.5, color: Get.theme.primaryColor))),
                child: ListTile(
                  onTap: () {
                    _assetFinancers.getAssetBreakDown(products, x.sId, (val) {
                      if (val.contains("success")) {
                        Get.back();
                        Get.to(KYCForm(
                          firstName: firstName,
                          lastName: lastName,
                          email: email,
                          type: "asset",
                          financerID: x.sId,
                          products: products,
                          isAssestFinance: true,
                        ));
                      }
                    });
                  },
                  leading: Image.asset('assets/images/store.png'),
                  title: Text("${x.userDetails.companyName}"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Location: Nungua"),
                      Text("Tel: ${x.userDetails.phone}")
                    ],
                  ),
                  trailing: Padding(
                    padding: const EdgeInsets.only(top:10.0),
                    child: Image.asset('assets/images/next.png', width: 30,),
                  ),
                ),
              ),
          if (_assetFinancers.assetFinance.isEmpty)
            ListEmptyWidget(
                message: "No Asset financer found", child: SizedBox.shrink())
        ],
      );
    }));
  }
}
