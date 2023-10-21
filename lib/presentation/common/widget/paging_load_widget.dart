import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_resume/presentation/common/common.dart';

typedef PagingLoadWidgetBuilder<T> = Widget Function(
  BuildContext context,
  List<T> data,
);

class PagingLoadWidget<A extends AbsPagingLoadBloc<B>, B>
    extends StatefulWidget {
  const PagingLoadWidget({
    super.key,
    required this.builder,
  });

  final PagingLoadWidgetBuilder<B> builder;

  @override
  State<PagingLoadWidget> createState() => _PagingLoadWidgetState<A, B>();
}

class _PagingLoadWidgetState<A extends AbsPagingLoadBloc<B>, B>
    extends State<PagingLoadWidget<A, B>> {
  final _controller = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.callRefresh();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<A, PagingLoadState<B>>(
          listenWhen: (p, c) => p.isRefreshing != c.isRefreshing,
          listener: (context, state) {
            if (!state.isRefreshing) {
              _controller.finishRefresh();
            }
          },
        ),
        BlocListener<A, PagingLoadState<B>>(
          listenWhen: (p, c) => p.isLoading != c.isLoading,
          listener: (context, state) {
            if (!state.isLoading) {
              _controller.finishLoad(state.isNoMoreData
                  ? IndicatorResult.noMore
                  : IndicatorResult.success);
            }
          },
        ),
      ],
      child: BlocBuilder<A, PagingLoadState<B>>(
        builder: (context, state) {
          final data = state.data;
          final bloc = context.read<A>();
          return EasyRefresh(
            controller: _controller,
            header: CommonRefreshHeader(),
            footer: CommonLoadFooter(),
            onRefresh: () {
              bloc.add(FetchData(isRefresh: true));
            },
            onLoad: () {
              bloc.add(FetchData());
            },
            child: CustomScrollView(
              slivers: [
                widget.builder(context, data),
                const FooterLocator.sliver(),
              ],
            ),
          );
        },
      ),
    );
  }
}
