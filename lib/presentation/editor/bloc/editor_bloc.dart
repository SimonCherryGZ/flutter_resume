import 'package:bloc/bloc.dart';

part 'editor_event.dart';

part 'editor_state.dart';

class EditorBloc extends Bloc<EditorEvent, EditorState> {
  EditorBloc() : super(EditorState()) {
    on<AddAssetSticker>((event, emit) {
      emit(EditorState(
        imagePath: event.imagePath,
        width: event.width,
        height: event.height,
      ));
    });
  }
}
