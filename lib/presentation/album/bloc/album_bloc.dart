import 'package:bloc/bloc.dart';
import 'package:photo_manager/photo_manager.dart';

part 'album_event.dart';

part 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  AlbumBloc() : super(AlbumState.initial()) {
    on<FetchData>(_onFetchData);
    on<ToggleAlbums>(_onToggleAlbums);
    on<SelectAlbum>(_onSelectAlbum);
  }

  void _onFetchData(FetchData event, Emitter<AlbumState> emit) async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (!ps.hasAccess) {
      emit(state.copyWith(hasAccess: false));
      return;
    }
    final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(
      type: RequestType.image,
    );
    final currentPath = paths[0];
    final assetCount = await currentPath.assetCountAsync;
    final entities =
        await currentPath.getAssetListRange(start: 0, end: assetCount);
    emit(state.copyWith(
      hasAccess: true,
      paths: paths,
      currentPath: currentPath,
      assetCount: assetCount,
      entities: entities,
    ));
  }

  void _onToggleAlbums(ToggleAlbums event, Emitter<AlbumState> emit) {
    emit(state.copyWith(showAlbums: !state.showAlbums));
  }

  void _onSelectAlbum(SelectAlbum event, Emitter<AlbumState> emit) async {
    final currentPath = state.paths[event.index];
    final assetCount = await currentPath.assetCountAsync;
    final List<AssetEntity> entities = assetCount > 0
        ? await currentPath.getAssetListRange(start: 0, end: assetCount)
        : const [];
    emit(state.copyWith(
      currentPath: currentPath,
      assetCount: assetCount,
      entities: entities,
    ));
  }
}
