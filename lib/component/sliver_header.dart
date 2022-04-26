import 'package:flutter/material.dart';

class SliverHeader extends SliverPersistentHeaderDelegate {
  final String _title;

  SliverHeader(this._title);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.black26,
      child: Center(
        child: Text(
          _title,
        ),
      ),
    );
  }

  @override
  double get maxExtent => 40;

  @override
  double get minExtent => 30;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
