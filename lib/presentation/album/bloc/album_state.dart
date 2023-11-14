part of 'album_bloc.dart';

class AlbumState {
  final bool hasAccess;
  final List<AssetPathEntity> paths;
  final AssetPathEntity? currentPath;
  final int assetCount;
  final List<AssetEntity> entities;
  final bool showAlbums;

  AlbumState({
    this.hasAccess = true,
    required this.paths,
    this.currentPath,
    this.assetCount = 0,
    required this.entities,
    this.showAlbums = false,
  });

  AlbumState.initial()
      : hasAccess = true,
        paths = const [],
        currentPath = null,
        assetCount = 0,
        entities = const [],
        showAlbums = false;

  AlbumState copyWith({
    bool? hasAccess,
    List<AssetPathEntity>? paths,
    AssetPathEntity? currentPath,
    int? assetCount,
    List<AssetEntity>? entities,
    bool? showAlbums,
  }) {
    return AlbumState(
      hasAccess: hasAccess ?? this.hasAccess,
      paths: paths ?? this.paths,
      currentPath: currentPath ?? this.currentPath,
      assetCount: assetCount ?? this.assetCount,
      entities: entities ?? this.entities,
      showAlbums: showAlbums ?? this.showAlbums,
    );
  }
}
