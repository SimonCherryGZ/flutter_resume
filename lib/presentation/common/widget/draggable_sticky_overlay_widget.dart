import 'package:flutter/material.dart';

// https://takeroro.github.io/2019/07/28/Flutter-Overlay/
class DraggableStickyOverlayWidget {
  static OverlayEntry? _holder;

  static void remove() {
    _holder?.remove();
    _holder = null;
  }

  static void show({
    required BuildContext context,
    required Widget view,
    required Size viewSize,
  }) {
    remove();
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: MediaQuery.paddingOf(context).top,
          child: _buildDraggable(
            context: context,
            view: view,
            viewSize: viewSize,
          ),
        );
      },
    );
    Overlay.of(context).insert(overlayEntry);
    _holder = overlayEntry;
  }

  static _buildDraggable({
    required BuildContext context,
    required Widget view,
    required Size viewSize,
  }) {
    return Draggable(
      ignoringFeedbackSemantics: false,
      feedback: view,
      onDragEnd: (detail) {
        createDragTarget(
          offset: detail.offset,
          context: context,
          view: view,
          viewSize: viewSize,
        );
      },
      childWhenDragging: Container(),
      child: view,
    );
  }

  static void refresh() {
    _holder?.markNeedsBuild();
  }

  static void createDragTarget({
    required Offset offset,
    required BuildContext context,
    required Widget view,
    required Size viewSize,
  }) {
    _holder?.remove();
    _holder = OverlayEntry(
      builder: (context) {
        bool isLeft = true;
        if (offset.dx + viewSize.width / 2 >
            MediaQuery.sizeOf(context).width / 2) {
          isLeft = false;
        }
        double minY = MediaQuery.paddingOf(context).top;
        double maxY = MediaQuery.sizeOf(context).height - viewSize.height;
        return Positioned(
          top: offset.dy < minY
              ? minY
              : offset.dy < maxY
                  ? offset.dy
                  : maxY,
          left: isLeft ? 0 : null,
          right: isLeft ? null : 0,
          child: DragTarget(
            onWillAccept: (data) {
              return true;
            },
            builder: (
              BuildContext context,
              List incoming,
              List rejected,
            ) {
              return _buildDraggable(
                context: context,
                view: view,
                viewSize: viewSize,
              );
            },
          ),
        );
      },
    );
    Overlay.of(context).insert(_holder!);
  }
}
