import 'package:edeybe/index.dart';
import 'package:edeybe/models/productModel.dart';
import 'package:flutter/material.dart';

class VariantsImage extends StatefulWidget {
  @override
  _VariantsImageState createState() => _VariantsImageState();
}

class _VariantsImageState extends State<VariantsImage> {
  List<String> images = [
    "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
    "https://images.ctfassets.net/hrltx12pl8hq/7yQR5uJhwEkRfjwMFJ7bUK/dc52a0913e8ff8b5c276177890eb0129/offset_comp_772626-opt.jpg",
    "https://cdn.pixabay.com/photo/2015/04/19/08/32/marguerite-729510_960_720.jpg",
    "https://thumbs.dreamstime.com/b/cosmos-beauty-deep-space-elements-image-furnished-nasa-science-fiction-art-102581846.jpg"
  ];
  List<String> images2 = [
    "https://cdn.jpegmini.com/user/images/bullet-1.jpg",
    "https://tinypng.com/images/social/website.jpg",
    "https://imgv3.fotor.com/images/homepage-feature-card/Fotor-image-cropper.jpg",
    "https://picjumbo.com/wp-content/uploads/creative-space-hero-image-place-for-text-free-photo-1080x720.jpg"
  ];

  List<String> imageString = [];
  bool autoPlay = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imageString = images;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      SizedBox(
        height: 30,
      ),
      // imageCarousel(context: context,images: imageString,)
      // child: CarouselSlider(
      //   itemCount:autoPlay? images.length : images2.length,
      //   autoPlay: autoPlay,
      //   containerHeight: 150.w,
      //   itemBuilder: (context, ind) => Image(
      //     width: Get.width.w,
      //     image: NetworkImage(
      //      !autoPlay ? images[ind] : images2[ind],
      //     ),
      //     alignment: Alignment.center,
      //     fit: BoxFit.cover,
      //   ),
      // ),
      // ,
      SizedBox(
        height: 30,
      ),
      Row(
        children: [
          for (var image in images)
            GestureDetector(
              onTap: () {
                setState(() {
                  imageString = images2;
                  // autoPlay = false;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(image),
                ),
              ),
            )
        ],
      )
    ]));
  }
}

Widget imageCarousel({List<Photos> images, BuildContext context}) {
  return Container(
    height: 180.w,
    width: Get.width.w,
    child: PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (_, i) {
          return Container(
            width: MediaQuery.of(context).size.width - 10,
            child: CachedNetworkImage(
              imageUrl: images[i].sm,
              fit: BoxFit.fitWidth,
            ),
          );
        }),
  );
  // child: CarouselSlider(
  //   itemCount:autoPlay? images.length : images2.length,
  //   autoPlay: autoPlay,
  //   containerHeight: 150.w,
  //   itemBuilder: (context, ind) => Image(
  //     width: Get.width.w,
  //     image: NetworkImage(
  //      !autoPlay ? images[ind] : images2[ind],
  //     ),
  //     alignment: Alignment.center,
  //     fit: BoxFit.cover,
  //   ),
  // ),
}
