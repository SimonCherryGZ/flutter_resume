import 'package:flutter_resume/domain/domain.dart';
import 'package:flutter_resume/presentation/common/common.dart';

class TrendBloc extends AbsPagingLoadBloc<Feed> {
  final FeedRepository _feedRepository;

  TrendBloc(this._feedRepository) : super(countPerPage: 20);

  @override
  Future<List<Feed>?> fetchData({required int page, required int count}) {
    return _feedRepository.fetchData(
      page: page,
      count: count,
    );
  }
}
