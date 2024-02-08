import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerProgressIndicator extends StatelessWidget {
  const ShimmerProgressIndicator({
    super.key,
    this.width = double.infinity,
    this.height = kToolbarHeight,
    this.radius = 16.0,
  });

  final double width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Shimmer.fromColors(
      baseColor: Theme.of(context).splashColor,
      highlightColor: colorScheme.surface,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: Theme.of(context).splashColor,
        ),
      ),
    );
  }
}
