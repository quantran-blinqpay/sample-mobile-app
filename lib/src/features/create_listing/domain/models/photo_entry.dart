import 'dart:io';

import 'package:equatable/equatable.dart';

class PhotoEntry extends Equatable {
  final String path;
  final String? uploadId;
  final String? uploadUrl;
  final bool? isLoading;

  const PhotoEntry({
    required this.path,
    this.uploadId,
    this.uploadUrl,
    this.isLoading = true,
  });

  File get file => File(path);

  PhotoEntry copyWith({
    String? path,
    String? uploadId,
    String? uploadUrl,
    bool? isLoading,
  }) {
    return PhotoEntry(
      path: path ?? this.path,
      uploadId: uploadId ?? this.uploadId,
      uploadUrl: uploadUrl ?? this.uploadUrl,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        path,
        uploadId,
        uploadUrl,
        isLoading,
      ];
}
