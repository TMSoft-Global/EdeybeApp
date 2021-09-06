import 'package:edeybe/widgets/Shimmer.dart';
import 'package:flutter/material.dart';

class ShimmerLoading extends StatefulWidget {
  const ShimmerLoading({
    Key key,
    @required this.isLoading,
    @required this.child,
  }) : super(key: key);

  final bool isLoading;
  final Widget child;

  @override
  _ShimmerLoadingState createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading> {
  Listenable _shimmerChanges;
  ShimmerState shimmer;
  Size shimmerSize;
  LinearGradient gradient;
  Offset offsetWithinShimmer;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // Collect ancestor shimmer information.
      if (mounted)
        setState(() {
          shimmer = Shimmer.of(context);

          shimmerSize = shimmer.size;
          gradient = shimmer.gradient;
          offsetWithinShimmer = shimmer.getDescendantOffset(
            descendant: context.findRenderObject() as RenderBox,
          );
          offsetWithinShimmer = shimmer.getDescendantOffset(
            descendant: context.findRenderObject() as RenderBox,
          );
        });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_shimmerChanges != null) {
      _shimmerChanges?.removeListener(_onShimmerChange);
    }
    _shimmerChanges = Shimmer.of(context)?.shimmerChanges;
    if (_shimmerChanges != null) {
      _shimmerChanges?.addListener(_onShimmerChange);
    }
  }

  @override
  void dispose() {
    _shimmerChanges?.removeListener(_onShimmerChange);
    super.dispose();
  }

  void _onShimmerChange() {
    if (widget.isLoading && mounted) {
      setState(() {
        // update the shimmer painting.
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) {
      return widget.child;
    }
    if (gradient == null ||
        shimmerSize == null ||
        (shimmer == null || !shimmer.isSized)) {
      // The ancestor Shimmer widget isn’t laid
      // out yet. Return an empty box.
      return SizedBox();
    }
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        return gradient.createShader(
          Rect.fromLTWH(
            -(offsetWithinShimmer != null ? offsetWithinShimmer?.dx : 0.0),
            -(offsetWithinShimmer != null ? offsetWithinShimmer?.dy : 0.0),
            shimmerSize != null ? shimmerSize.width : 40,
            shimmerSize != null ? shimmerSize.height : 40,
          ),
        );
      },
      child: widget.child,
    );
  }
}
