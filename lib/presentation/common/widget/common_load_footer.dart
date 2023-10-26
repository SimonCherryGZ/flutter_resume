import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_resume/l10n/l10n.dart';
import 'package:flutter_resume/utils/utils.dart';

class CommonLoadFooter extends Footer {
  CommonLoadFooter({
    this.needEndLabel = true,
  }) : super(
          triggerOffset: 60.ss(),
          clamping: false,
          position: IndicatorPosition.locator,
        );

  final bool needEndLabel;

  @override
  Widget build(BuildContext context, IndicatorState state) {
    final l10n = L10nDelegate.l10n(context);
    if (IndicatorResult.none == state.result) {
      return Container(
        height: state.offset,
        width: double.maxFinite,
        alignment: Alignment.topCenter,
        padding: EdgeInsets.symmetric(vertical: 10.ss()),
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
    if (needEndLabel && IndicatorResult.noMore == state.result) {
      return Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(top: 20.ss()),
        child: Text(
          l10n.footerNoMore,
          style: const TextStyle(
            color: Color(0xFFAFB4BD),
            fontSize: 11,
            height: 16 / 11,
          ),
        ),
      );
    }
    return Container();
  }
}
