import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flood_mobile/Model/user_interface_model.dart';

part 'user_interface_event.dart';
part 'user_interface_state.dart';

class UserInterfaceBloc extends Bloc<UserInterfaceEvent, UserInterfaceState> {
  UserInterfaceBloc() : super(UserInterfaceState.initial()) {
    on<UpdateUserInterfaceEvent>(_updateUserInterface);
    on<GetPreviousSetUserInterfaceEvent>(_getPreviousSetUserInterface);
  }

  // Callback method for the `UpdateUserInterfaceEvent`.
  void _updateUserInterface(
    UpdateUserInterfaceEvent event,
    Emitter<UserInterfaceState> emit,
  ) {
    UserInterfaceModel model = UserInterfaceModel(
      showProgressBar: event.model.showProgressBar,
      showDateAdded: event.model.showDateAdded,
      showDateCreated: event.model.showDateCreated,
      showRatio: event.model.showRatio,
      showLocation: event.model.showLocation,
      showTags: event.model.showTags,
      showTrackers: event.model.showTrackers,
      showTrackersMessage: event.model.showTrackersMessage,
      showDownloadSpeed: event.model.showDownloadSpeed,
      showUploadSpeed: event.model.showUploadSpeed,
      showPeers: event.model.showPeers,
      showSeeds: event.model.showSeeds,
      showSize: event.model.showSize,
      showType: event.model.showType,
      showHash: event.model.showHash,
      showDelete: event.model.showDelete,
      showCheckHash: event.model.showCheckHash,
      showReannounce: event.model.showReannounce,
      showSetTags: event.model.showSetTags,
      showSetTrackers: event.model.showSetTrackers,
      showGenerateMagnetLink: event.model.showGenerateMagnetLink,
      showPriority: event.model.showPriority,
      showInitialSeeding: event.model.showInitialSeeding,
      showSequentialDownload: event.model.showSequentialDownload,
      showDownloadTorrent: event.model.showDownloadTorrent,
      tagPreferenceButtonValue: event.model.tagPreferenceButtonValue,
    );

    saveUserInterfaceModel(model);
    emit(state.copyWith(model: model));
  }

  // Callback method for the `GetPreviousSetUserInterfaceEvent`.
  void _getPreviousSetUserInterface(
    GetPreviousSetUserInterfaceEvent event,
    Emitter<UserInterfaceState> emit,
  ) {
    getUserInterfaceModel().then((value) {
      if (value != null) {
        emit(state.copyWith(model: value));
      }
    });
  }

  /// Store the UserInterfaceState object in shared preferences.
  Future<void> saveUserInterfaceModel(UserInterfaceModel model) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(model.toJson());
    await prefs.setString('userInterfaceState', jsonString);
  }

  /// Retrieve the UserInterfaceState object from shared preferences.
  Future<UserInterfaceModel?> getUserInterfaceModel() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('userInterfaceState');
    if (jsonString != null) {
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      return UserInterfaceModel.fromJson(jsonMap);
    }
    return null;
  }
}
