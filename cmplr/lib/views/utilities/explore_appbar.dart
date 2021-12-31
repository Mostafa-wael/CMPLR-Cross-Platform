import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// the app bar for the expolre tab
class ExploreAppBar implements SliverPersistentHeaderDelegate {
  @override
  final maxExtent, minExtent;
  final image;
  Widget? child;

  ExploreAppBar({
    this.image,
    this.child,
    this.minExtent = 20,
    this.maxExtent = 100,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(fit: StackFit.expand, children: [image]);
  }

  double titleOpacity(double shrinkOffset) {
    // simple formula: fade out text as soon as shrinkOffset > 0
    // return 1.0 - max(0.0, shrinkOffset) / maxExtent;
    //more complex formula: starts fading out text when shrinkOffset > minExtent
    //return 1.0 - max(0.0, (shrinkOffset - minExtent)) / (maxExtent - minExtent);
    return 1.0;
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration =>
      FloatingHeaderSnapConfiguration();

  @override
  // TODO: implement showOnScreenConfiguration
  PersistentHeaderShowOnScreenConfiguration? get showOnScreenConfiguration =>
      PersistentHeaderShowOnScreenConfiguration(
          maxShowOnScreenExtent: maxExtent, minShowOnScreenExtent: minExtent);

  @override
  // TODO: implement stretchConfiguration
  OverScrollHeaderStretchConfiguration? get stretchConfiguration =>
      OverScrollHeaderStretchConfiguration();

  @override
  // TODO: implement vsync
  TickerProvider? get vsync => null;
}
