import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:edeybe/index.dart';
import 'package:edeybe/models/productModel.dart' as Pro;
import 'package:edeybe/services/server_operation.dart';
// import 'package:edeybe/models/product.dart' as ProductModel;
import 'package:flutter/material.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:edeybe/widgets/loading_widget.dart';

class PostGallery extends StatefulWidget {
  final List<Pro.Photos> images;
  final int currentImage;
  PostGallery({@required this.images, this.currentImage});
  @override
  _PostGalleryState createState() => _PostGalleryState();
}

class _PostGalleryState extends State<PostGallery> {
  PageController pageController;
  final ScrollController thumbController = ScrollController();
  int page;
  final double thumbSize = 40;
  @override
  void initState() {
    super.initState();
    page = widget.currentImage ?? 0;
    pageController = PageController(initialPage: page);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black.withOpacity(0.6),
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            elevation: 0,
            title: Text(
              "Image ${page + 1} of ${widget.images.length}",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 16),
            ),
            backgroundColor: Colors.transparent,
            actions: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios_outlined),
                onPressed: () => pageController.previousPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeIn),
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward_ios_outlined),
                onPressed: () => pageController.nextPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeIn),
              ),
            ],
          ),
          body: GestureDetector(
            onTap: () {
              if (Get.isDialogOpen) Get.back();
            },
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 2),
                    child: PageView(
                      controller: pageController,
                      onPageChanged: (index) {
                        _setCurrentPage(index);
                        thumbController.animateTo(index * thumbSize,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      },
                      children: _buildGalleryView(widget.images),
                    ),
                  ),
                ),
                Container(
                  height: thumbSize,
                  child: ListView(
                    controller: thumbController,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: _buildGalleryItemThumbnail(widget.images),
                  ),
                )
              ],
            ),
          )),
    );
  }

  void _setCurrentPage(int index) {
    setState(() {
      page = index;
    });
  }

  Widget _buildGalleryItem(String url) {
    print(url);
    return Center(
      child: PinchZoom(
        maxScale: 5.0,
        // doubleTapScale: 2.0,
        resetDuration: Duration(milliseconds: 200),
        image: Container(
          child: CachedNetworkImage(
            imageUrl: url,
            placeholder: (context, url) => LoadingWidget(),
            errorWidget: (context, url, error) =>
                Image.asset("images/ic_error_image.png"),
          ),
        ),
      ),
    );
  }

  Widget _buildGalleryThumbnail(Pro.Photos img, ind) {
    return new GestureDetector(
      onTap: () => pageController.animateToPage(ind,
          duration: Duration(milliseconds: 500), curve: Curves.easeIn),
      child: Transform.scale(
        scale: page == ind ? 1 : 0.8,
        child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: page == ind ? Colors.white : Colors.transparent)),
            child: CachedNetworkImage(
              height: thumbSize,
              width: thumbSize,
              imageUrl:img.sm,
              fit: BoxFit.fill,
              placeholder: (context, url) => SizedBox(
                  width: thumbSize - 20,
                  height: thumbSize - 20,
                  child: CircularProgressIndicator()),
              errorWidget: (context, url, error) =>
                  Image.asset("images/ic_error_image.png"),
            )),
      ),
    );
  }

  List<Widget> _buildGalleryView(List<Pro.Photos> items) {
    return items.map((image) => _buildGalleryItem(image.lg)).toList();
  }

  List<Widget> _buildGalleryItemThumbnail(List<Pro.Photos> items) {
    return items
        .asMap()
        .map((index, image) =>
            MapEntry(index, _buildGalleryThumbnail(image, index)))
        .values
        .toList();
  }
}
