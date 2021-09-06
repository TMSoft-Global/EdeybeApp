import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BackToTopWidget extends StatefulWidget {
  final ScrollController scrollController;

  BackToTopWidget({
    Key key,
    @required this.scrollController,
  }) : super(key: key);

  @override
  _BackToTopWidgetState createState() => _BackToTopWidgetState();
}

class _BackToTopWidgetState extends State<BackToTopWidget>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  bool _isVisible = false;
  AnimationController _controller;
  ScrollController _currentlyScrollingController;
  Animation<Offset> _offsetAnimation;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    widget.scrollController
      ..addListener(() => scrollingBehavior(widget.scrollController));
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: Offset(0.0, 3.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticIn,
    ));
    _controller.reverse();
  }

  @override
  void dispose() {
    _controller.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
        position: _offsetAnimation, child: bottomSideButton());
  }

  /// Define the scrolling behavior of the customListView
  void scrollingBehavior(ScrollController scrollController) {
    if (scrollController.position.extentBefore < 1200 && _isVisible) {
      if (mounted) {
        setState(() {
          _currentlyScrollingController = null;
          _isVisible = false;
        });
        _controller.reverse();
      }
    } else if (scrollController.position.extentBefore > 1200 && !_isVisible) {
      if (mounted) {
        setState(() {
          _currentlyScrollingController = scrollController;
          _isVisible = true;
        });
        _controller.forward();
      }
    }
  }

  /// Widget that creates the bottomNavigationBar
  Widget floatingBackToTopButton() => Container(
        width: 40.0,
        height: 40.0,
        child: RawMaterialButton(
          fillColor: Colors.grey.withOpacity(0.3),
          shape: CircleBorder(),
          elevation: 10.0,
          child: Icon(
            Icons.keyboard_arrow_up_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            if (_currentlyScrollingController != null)
              _currentlyScrollingController.animateTo(
                0,
                duration: Duration(milliseconds: 50),
                curve: Curves.easeOut,
              );
          },
        ),
      );

  /// Widget that creates the bottomNavigationBar
  Widget bottomSideButton() => Align(
        alignment: Alignment.bottomRight,
        child: Container(
          height: 60,
          margin: EdgeInsets.only(right: 10, bottom: 10),
          child: Align(
            alignment: Alignment.topRight,
            child: floatingBackToTopButton(),
          ),
        ),
      );
}
