import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flood_mobile/Model/feeds_content_model.dart';
import 'package:flood_mobile/Model/notification_model.dart';
import 'package:flood_mobile/Model/single_feed_and_response_model.dart';
import 'package:flood_mobile/Model/single_rule_model.dart';
import 'package:flood_mobile/Model/torrent_model.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(HomeScreenInitial()) {
    on<SetUnreadNotificationsEvent>(_setUnreadNotifications);
    on<SetNotificationModelEvent>(_setNotificationModel);
    on<SetSpeedEvent>(_setSpeed);
    on<SetTorrentListEvent>(_setTorrentList);
    on<SetRssFeedsListEvent>(_setRssFeedsList);
    on<SetRssFeedsContentsListEvent>(_setRssFeedsContentsList);
    on<SetTorrentListJsonEvent>(_setTorrentListJson);
    on<SetFeedsAndRulesListJsonEvent>(_setFeedsAndRulesListJson);
    on<UpdateTorrentListEvent>(_updateTorrentList);
  }

  // Handle the SetUnreadNotifications event
  void _setUnreadNotifications(
      SetUnreadNotificationsEvent event, Emitter<HomeScreenState> emit) {
    emit(state.copyWith(unreadNotifications: event.count));
  }

  // Handle the SetNotificationModel event
  void _setNotificationModel(
      SetNotificationModelEvent event, Emitter<HomeScreenState> emit) {
    emit(state.copyWith(notificationModel: event.newModel));
  }

  // Handle the SetSpeed event
  void _setSpeed(SetSpeedEvent event, Emitter<HomeScreenState> emit) {
    emit(
        state.copyWith(upSpeed: '${event.up}/s', downSpeed: '${event.down}/s'));
  }

  // Handle the SetTorrentList event
  void _setTorrentList(
      SetTorrentListEvent event, Emitter<HomeScreenState> emit) {
    final newTorrentList = List<TorrentModel>.from(event.newTorrentList);
    newTorrentList.sort((a, b) {
      return a.dateAdded.compareTo(b.dateAdded);
    });
    emit(state.copyWith(torrentList: newTorrentList));
  }

  // Handle the SetRssFeedsList event
  void _setRssFeedsList(
      SetRssFeedsListEvent event, Emitter<HomeScreenState> emit) {
    emit(state.copyWith(
        rssFeedsList: event.newRssFeedsList,
        rssRulesList: event.newRssRulesList));
  }

  // Handle the SetRssFeedsContentsList event
  void _setRssFeedsContentsList(
      SetRssFeedsContentsListEvent event, Emitter<HomeScreenState> emit) {
    emit(state.copyWith(rssFeedsContentsList: event.newRssFeedsContentsList));
  }

  // Handle the SetTorrentListJson event
  void _setTorrentListJson(
      SetTorrentListJsonEvent event, Emitter<HomeScreenState> emit) {
    emit(state.copyWith(torrentListJson: event.newTorrentListJson));
  }

  // Handle the SetFeedsAndRulesListJson event
  void _setFeedsAndRulesListJson(
      SetFeedsAndRulesListJsonEvent event, Emitter<HomeScreenState> emit) {
    emit(state.copyWith(rssFeedsListJson: event.newRssFeedsListJson));
  }

  // Handle the UpdateTorrentList event
  void _updateTorrentList(
      UpdateTorrentListEvent event, Emitter<HomeScreenState> emit) {
    emit(state.copyWith(torrentListJson: event.newTorrentListJson));
  }
}
