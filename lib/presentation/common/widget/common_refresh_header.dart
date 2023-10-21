import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_resume/utils/utils.dart';

class CommonRefreshHeader extends Header {
  CommonRefreshHeader()
      : super(
          triggerOffset: 50.ss(),
          clamping: false,
          position: IndicatorPosition.behind,
          processedDuration: const Duration(milliseconds: 300),
        );

  @override
  Widget build(BuildContext context, IndicatorState state) {
    return Container(
      height: state.offset,
      width: double.maxFinite,
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.only(bottom: 10.ss()),
      child: Icon(
        Icons.flutter_dash,
        size: (state.offset - 10.ss()).clamp(
          0.0,
          40.ss(),
        ),
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
