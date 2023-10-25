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
    this.headerBuilder,
  });

  final PagingLoadWidgetBuilder<B> builder;
  final WidgetBuilder? headerBuilder;

  @override
  State<PagingLoadWidget> createState() => _PagingLoadWidgetState<A, B>();
}

class _PagingLoadWidgetState<A extends AbsPagingLoadBloc<B>, B>
    extends State<PagingLoadWidget<A, B>> {
  late final EasyRefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _refreshController = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshController.callRefresh();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<A, PagingLoadState<B>>(
          listenWhen: (p, c) => p.isRefreshing != c.isRefreshing,
          listener: (context, state) {
            if (!state.isRefreshing) {
              _refreshController.finishRefresh();
            }
          },
        ),
        BlocListener<A, PagingLoadState<B>>(
          listenWhen: (p, c) => p.isLoading != c.isLoading,
          listener: (context, state) {
            if (!state.isLoading) {
              _refreshController.finishLoad(state.isNoMoreData
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
            controller: _refreshController,
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
                if (widget.headerBuilder != null) ...[
                  widget.headerBuilder!(context),
                ],
                const HeaderLocator.sliver(),
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
