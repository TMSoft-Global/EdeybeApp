import 'dart:async';

import 'package:edeybe/screens/checkout_screen/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:edeybe/index.dart';

class CarouselSlider extends StatefulWidget {
  final Function(BuildContext context, int index) itemBuilder;
  final Function(BuildContext context, int index, Function() onPressed)
      dotBuilder;
  final void Function(int index) onItemFocusChange;
  final int itemCount;
  final bool showDots;
  final bool autoPlay;
  final ControllButtons controlButton;
  final Duration autoPlayInterval;
  final Widget overlayWidget;
  final Duration autoPlayDelay;
  final double viewportFraction;
  final double scale;
  final bool reverse;
  final bool twinGrid;
  final bool showControlButton;
  final Alignment dotsPosition;
  final Alignment overLayPosition;
  final Duration duration;
  final double containerHeight;

  const CarouselSlider(
      {@required this.itemBuilder,
      this.autoPlay = false,
      this.dotBuilder,
      this.autoPlayDelay,
      this.viewportFraction,
      this.autoPlayInterval,
      this.duration,
      this.containerHeight,
      this.reverse = false,
      @required this.itemCount,
      this.onItemFocusChange,
      this.showDots = true,
      this.showControlButton = false,
      this.overlayWidget,
      this.dotsPosition = Alignment.center,
      this.scale,
      this.overLayPosition,
      this.controlButton,
      this.twinGrid = false})
      : assert(itemBuilder != null),
        assert((showControlButton && controlButton == null) ||
            (!showControlButton && controlButton == null) ||
            (showControlButton && controlButton != null)),
        assert(itemCount != 0);
  @override
  _PhotoSliderState createState() => _PhotoSliderState();
}

class _PhotoSliderState extends State<CarouselSlider>
    with WidgetsBindingObserver {
  PageController pageController;
  final ScrollController thumbController = ScrollController();
  List<Widget> items = [];
  List<Widget> dots = [];
  final double thumbSize = 13;
  final double _defaultWidth = 200;
  int page = 0;
  Duration _autoPlayInterval = Duration(seconds: 5);
  Duration _duration = Duration(milliseconds: 100);
  Duration _autoPlayDelay = Duration(seconds: 5);
  ScrollDirection direction = ScrollDirection.forward;
  Timer snapTimer;
  Timer snapTimerPerodic;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if (widget.twinGrid)
      buildTwinGrid();
    else
      _buildItems();
    pageController =
        PageController(viewportFraction: widget.viewportFraction ?? 1);
    if (widget.duration != null) _duration = widget.duration;
    if (widget.autoPlayDelay != null) _autoPlayDelay = widget.autoPlayDelay;
    if (widget.autoPlayInterval != null)
      _autoPlayInterval = widget.autoPlayInterval;
    if (widget.autoPlay) _autoPlaySnap();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (Notification noti) {
        if (widget.autoPlay) {
          if (noti is ScrollStartNotification) {
            if (noti.dragDetails != null) {
              _stopAutoplay();
            }
          } else if (noti is ScrollEndNotification) {
            if (snapTimer == null) _autoPlaySnap();
          }
        }
        return true;
      },
      child: Container(
          color: Colors.transparent,
          height: widget.containerHeight ?? _defaultWidth,
          child: Stack(
            children: [
              new PageView(
                controller: pageController,
                onPageChanged: (index) {
                  _setCurrentPage(index);
                  if (widget.showDots)
                    thumbController.animateTo(index * thumbSize,
                        duration: Duration(milliseconds: 100),
                        curve: Curves.easeIn);
                  if (widget.onItemFocusChange != null)
                    widget.onItemFocusChange(index);
                  _buildSliderDots();
                },
                children: items,
              ),
              if (widget.showControlButton && widget.itemCount > 1)
                ..._getControlls,
              if (widget.showDots || widget.overlayWidget != null)
                Positioned(
                    bottom: widget.overlayWidget == null ? 10.w : 0,
                    left: 0,
                    right: 0,
                    child: Wrap(
                      children: [
                        if (widget.showDots && widget.itemCount > 1)
                          _buildDotsWidget(),
                        if (widget.overlayWidget != null)
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 3.w, horizontal: 5.w),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.2),
                                border: Border(
                                    top: BorderSide(
                                  color: Colors.grey,
                                ))),
                            width: MediaQuery.of(context).size.width,
                            child: Align(
                              alignment:
                                  widget.overLayPosition ?? Alignment.center,
                              child: widget.overlayWidget,
                            ),
                          ),
                      ],
                    ))
            ],
          )),
    );
  }

  void previous() {
    pageController.previousPage(
        duration: Duration(milliseconds: 100), curve: Curves.easeIn);
  }

  void next() {
    pageController.nextPage(
        duration: Duration(milliseconds: 100), curve: Curves.easeIn);
  }

  void _setCurrentPage(int index) {
    setState(() {
      page = index;
    });
  }

  List<Widget> get _getControlls {
    return [
      Positioned(
          left: 0,
          bottom: 0,
          top: 0,
          child: widget.controlButton != null
              ? widget.controlButton.left(previous)
              : Center(
                  child: Padding(
                      padding: EdgeInsets.all(8.w),
                      child: Container(
                        width: 20.w,
                        height: 20.w,
                        decoration: BoxDecoration(
                            color: Constants.mainColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20)),
                        child: TextButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.resolveWith(
                                  (s) => EdgeInsets.zero),
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.transparent),
                              shape: MaterialStateProperty.resolveWith(
                                  (states) => RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.w)))),
                          child: Icon(
                            Icons.arrow_back_ios_outlined,
                            size: 15.w,
                          ),
                          onPressed: previous,
                        ),
                      )),
                )),
      Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          child: widget.controlButton != null
              ? widget.controlButton.right(next)
              : Center(
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Container(
                        width: 20.w,
                        height: 20.w,
                        decoration: BoxDecoration(
                            color: Constants.mainColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20.w)),
                        child: TextButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.resolveWith(
                                  (s) => EdgeInsets.zero),
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.transparent),
                              shape: MaterialStateProperty.resolveWith(
                                  (states) => RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.w)))),
                          child: Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 15.w,
                          ),
                          onPressed: next,
                        ),
                      )),
                )),
    ];
  }

  _buildItems() {
    items.clear();
    for (var i = 0; i < widget.itemCount; i++) {
      Widget item = widget.itemBuilder(context, i);

      items.add((widget.viewportFraction != null && widget.scale != null)
          ? Transform.scale(
              scale: page == i ? 1 : widget.scale ?? 1, child: item)
          : item);
    }
    // return items;
  }

  buildTwinGrid() {
    items.clear();
    int currentItem = 0;
    int grids = (widget.itemCount / 2).ceil();
    for (var i = 0; i < grids; i++) {
      Widget item2;
      Widget item = widget.itemBuilder(context, currentItem);
      // items.add((widget.viewportFraction != null && widget.scale != null)
      //     ? Transform.scale(
      //         scale: page == i ? 1 : widget.scale ?? 1, child: item)
      //     : item);

      if (1 + currentItem < (widget.itemCount)) {
        item2 = widget.itemBuilder(context, 1 + currentItem);
      }
      items.add((widget.viewportFraction != null && widget.scale != null)
          ? Transform.scale(
              scale: page == i ? 1 : widget.scale ?? 1, child: item2)
          : GridView.count(
              shrinkWrap: true,
              primary: false,
              padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 10.0),
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
              childAspectRatio: 0.780,
              crossAxisCount: 2,
              children: [item, item2],
            ));

      if ((widget.itemCount > (currentItem + 2)))
        currentItem += 2;
      else if (currentItem + 1 <= widget.itemCount) currentItem += 1;
    }
  }

  // auto play snap
  _autoPlaySnap() {
    if (items != null && items.isNotEmpty)
      snapTimer = Timer(_autoPlayDelay, () {
        snapTimerPerodic = Timer.periodic(_autoPlayInterval, (timer) {
          if (page == 0 ||
              (page < items.length - 1 &&
                  direction == ScrollDirection.forward)) {
            if (mounted && page == 0)
              setState(() {
                direction = ScrollDirection.forward;
              });
            if (pageController.hasClients)
              pageController.nextPage(
                  duration: _duration, curve: Curves.easeInCubic);
          } else {
            if (page == (-1 + items.length)) {
              if (mounted)
                setState(() {
                  direction = ScrollDirection.reverse;
                });
            }
            if (pageController.hasClients) {
              if (widget.reverse)
                pageController.previousPage(
                    duration: _duration, curve: Curves.easeInCubic);
              else
                pageController.jumpToPage(
                  0,
                );
            }
          }
        });
      });
  }

  void _stopAutoplay() {
    if (snapTimerPerodic != null) {
      snapTimerPerodic.cancel();
      snapTimerPerodic = null;
    }
    if (snapTimer != null) {
      snapTimer.cancel();
      snapTimer = null;
    }
  }

  Widget _buildDots(int ind) {
    Function() onDotPressed = () => pageController.animateToPage(ind,
        duration: Duration(milliseconds: 100), curve: Curves.easeIn);
    return widget.dotBuilder != null
        ? widget.dotBuilder(context, ind, onDotPressed)
        : new GestureDetector(
            onTap: onDotPressed,
            child: Container(
              margin: EdgeInsets.all(2.5),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: page == ind ? Constants.mainColor : Colors.white),
            ),
          );
  }

  Widget _buildDotsWidget() {
    return new Align(
      alignment: widget.dotsPosition,
      child: Container(
        margin: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15)),
        width: items.length * 13.0,
        height: thumbSize,
        child: Center(
          child: new ListView(
            controller: thumbController,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: _buildSliderDots(),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildSliderDots() {
    dots = [];
    for (var i = 0; i < items.length; i++) {
      dots.add(_buildDots(i));
    }
    return dots;
  }

  @override
  void dispose() {
    pageController.dispose();
    thumbController.dispose();
    if (snapTimerPerodic != null) {
      snapTimer.cancel();
      snapTimerPerodic.cancel();
    }
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
        if (widget.autoPlay) _stopAutoplay();
        break;
      case AppLifecycleState.resumed:
        if (widget.autoPlay) _autoPlaySnap();
        break;
      default:
    }
    super.didChangeAppLifecycleState(state);
  }
}

class ControllButtons {
  final Widget Function(VoidCallback onPress) left;
  final Widget Function(VoidCallback onPress) right;

  ControllButtons({@required this.left, @required this.right})
      : assert(left != null),
        assert(right != null);
}
