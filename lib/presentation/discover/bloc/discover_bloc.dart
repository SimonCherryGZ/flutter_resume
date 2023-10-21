import 'package:flutter_resume/domain/domain.dart';
import 'package:flutter_resume/presentation/common/common.dart';

class DiscoverBloc extends AbsPagingLoadBloc<Feed> {
  final FeedRepository _feedRepository;

  DiscoverBloc(this._feedRepository) : super(countPerPage: 10);

  @override
  Future<List<Feed>?> fetchData({required int page, required int count}) {
    return _feedRepository.fetchData(
      page: page,
      count: count,
    );
  }
}
