part of 'album_bloc.dart';

abstract class AlbumEvent {}

class FetchData extends AlbumEvent {}

class ToggleAlbums extends AlbumEvent {}

class SelectAlbum extends AlbumEvent {
  final int index;

  SelectAlbum(this.index);
}
