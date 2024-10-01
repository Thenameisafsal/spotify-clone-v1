import 'dart:io';
import 'dart:ui';

import 'package:client/core/providers/current_user_notifier.dart';
import 'package:client/core/utils.dart';
import 'package:client/features/home/model/song_model.dart';
import 'package:client/features/home/repositories/home_local_repository.dart';
import 'package:client/features/home/repositories/home_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_viewmodel.g.dart';

@riverpod
Future<List<SongModel>> getAllSongs(GetAllSongsRef ref) async {
  final token = ref.watch(currentUserNotifierProvider)!.token;
  final res = await ref.watch(homeRepositoryProvider).getAllSongs(token: token);
  return switch (res) {
    Left(value: final l) => throw l.error,
    Right(value: final r) => r,
  };
}

@riverpod
class HomeViewmodel extends _$HomeViewmodel {
  late HomeRepository _homeRepository;
  late HomeLocalRepository _homeLocalRepository;
  @override
  AsyncValue? build() {
    _homeRepository = ref.watch(homeRepositoryProvider);
    _homeLocalRepository = ref.watch(homeLocalRepositoryProvider);
    return null;
  }

  Future<void> uploadSong(
      {required File selectedAudio,
      required File selectedImage,
      required String songName,
      required String artist,
      required Color color}) async {
    state = const AsyncValue.loading();
    final res = await _homeRepository.uploadSong(
      selectedAudio: selectedAudio,
      selectedImage: selectedImage,
      songName: songName,
      artist: artist,
      hexCode: rgbToHex(color),
      token: ref.read(currentUserNotifierProvider)!.token,
    );
    final val = switch (res) {
      Left(value: final l) => state =
          AsyncValue.error(l.error, StackTrace.current),
      Right(value: final r) => state = AsyncValue.data(r)
    };
  }

  List<SongModel> getRecentlyPlayedSongs() {
    return _homeLocalRepository.loadSongs();
  }
}
