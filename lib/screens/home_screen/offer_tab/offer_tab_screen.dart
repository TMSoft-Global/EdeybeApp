// import 'package:edeybe/controller/category_repo.dart';
// import 'package:edeybe/controller/product_repo.dart';
// import 'package:edeybe/generated/l10n.dart';
// import 'package:edeybe/model/Category.dart';

// import 'package:edeybe/view/widget/category_widget.dart';
// import 'package:edeybe/view/widget/product_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class OfferScreen extends StatefulWidget {
//   @override
//   _OfferScreenState createState() => _OfferScreenState();
// }

// class _OfferScreenState extends State<OfferScreen> {
//   int currentPage = 1;
//   int selectedCategory = 0;

//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) => {
//           Provider.of<CategoryProvider>(context, listen: false).getCategories(),
//           Provider.of<ProductProvider>(context, listen: false)
//               .getDealProducts(page: currentPage),
//         });
//     var size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: NotificationListener<ScrollNotification>(
//         onNotification: (scrollNotification) {
//           if (scrollNotification is ScrollUpdateNotification &&
//               scrollNotification.metrics.pixels ==
//                   scrollNotification.metrics.maxScrollExtent) {
//             currentPage++;

//             Provider.of<ProductProvider>(context, listen: false)
//                 .getDealProducts(page: currentPage);
//           }
//           return true;
//         },
//         child: SingleChildScrollView(
//           padding: EdgeInsets.all(8),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 S.of(context).dealByCategory,
//                 style: Theme.of(context)
//                     .textTheme
//                     .subtitle1
//                     .copyWith(fontWeight: FontWeight.bold),
//               ),
//               SizedBox(
//                 height: 8,
//               ),
//               Selector<CategoryProvider, List<Category>>(
//                 selector: (_, provider) => provider.categories,
//                 builder: (BuildContext context, List<Category> categories,
//                         Widget child) =>
//                     Container(
//                   height: 110,
//                   width: size.width,
//                   child: ListView(
//                     scrollDirection: Axis.horizontal,
//                     itemExtent: 90,
//                     children: categories
//                         .map((e) => CategoryWidget(
//                               item: e,
//                               onTap: () {
//                                 setState(() {
//                                   selectedCategory = e.id;
//                                 });
//                               },
//                             ))
//                         .toList(),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 12,
//               ),
//               Consumer<ProductProvider>(
//                 builder: (contex, provider, child) => Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           S.of(context).dailyDeals,
//                           style: Theme.of(context).textTheme.subtitle1.copyWith(
//                                 fontWeight: FontWeight.bold,
//                               ),
//                         ),
//                       ],
//                     ),
//                     GridView.count(
//                       crossAxisCount: 2,
//                       mainAxisSpacing: 8,
//                       crossAxisSpacing: 12,
//                       physics: NeverScrollableScrollPhysics(),
//                       childAspectRatio: 3 / 5,
//                       shrinkWrap: true,
//                       children: (selectedCategory > 0
//                               ? provider.dealProducts.where(
//                                   (element) => element.categories
//                                       .any((cat) => cat.id == selectedCategory),
//                                 )
//                               : provider.dealProducts)
//                           .map(
//                             (e) => ProductWidget(
//                               product: e,
//                             ),
//                           )
//                           .toList(),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
