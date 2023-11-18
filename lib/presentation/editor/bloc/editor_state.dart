part of 'editor_bloc.dart';

class EditorState {
  final String? imagePath;
  final double? width;
  final double? height;
  final bool isShowLoading;

  EditorState({
    this.imagePath,
    this.width,
    this.height,
    this.isShowLoading = false,
  });

  EditorState copyWith({
    bool? isShowLoading,
  }) {
    return EditorState(
      isShowLoading: isShowLoading ?? this.isShowLoading,
    );
  }
}
