import 'package:edeybe/controllers/assetFinanceController.dart';
import 'package:edeybe/screens/finance_product_screen/kyc_form.dart';
import 'package:flutter/material.dart';

import '../../index.dart';

class AssetFinancersList extends StatelessWidget {
  final _assetFinancers = Get.put(AssetFinanceController());
  final firstName, lastName, email;
  AssetFinancersList({@required this.firstName,@required this.email,@required this.lastName});

  @override
  Widget build(BuildContext context) {
    return Container(child: Obx(() {
      return Column(
        children: [
          for (var x in _assetFinancers.assetFinance)
            ListTile(
              onTap: () {
                Get.back();
                Get.to(KYCForm(
                  firstName: firstName,
                  lastName: lastName,
                  email: email,
                ));
              },
              leading: Icon(Icons.house),
              title: Text("${x.userDetails.companyName}"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Location: Nungua"),
                  Text("Tel: ${x.userDetails.phone}")
                ],
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
            )
        ],
      );
    }));
  }
}
