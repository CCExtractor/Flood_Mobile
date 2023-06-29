part of 'home_screen_bloc.dart';

abstract class HomeScreenEvent extends Equatable {
  const HomeScreenEvent();

  @override
  List<Object> get props => [];
}

class SetUnreadNotificationsEvent extends HomeScreenEvent {
  final int count;

  SetUnreadNotificationsEvent({required this.count});

  @override
  List<Object> get props => [count];
}

class SetNotificationModelEvent extends HomeScreenEvent {
  late final NotificationModel newModel;

  SetNotificationModelEvent({required this.newModel});

  @override
  List<Object> get props => [newModel];
}

class SetSpeedEvent extends HomeScreenEvent {
  final String up;
  final String down;

  SetSpeedEvent({required this.up, required this.down});

  @override
  List<Object> get props => [up, down];
}

class SetTorrentListEvent extends HomeScreenEvent {
  final List<TorrentModel> newTorrentList;

  SetTorrentListEvent({required this.newTorrentList});

  @override
  List<Object> get props => [newTorrentList];
}

class SetRssFeedsListEvent extends HomeScreenEvent {
  final List<FeedsAndRulesModel> newRssFeedsList;
  final List<RulesModel> newRssRulesList;

  SetRssFeedsListEvent(
      {required this.newRssFeedsList, required this.newRssRulesList});

  @override
  List<Object> get props => [newRssFeedsList, newRssRulesList];
}

class SetRssFeedsContentsListEvent extends HomeScreenEvent {
  final List<FeedsContentsModel> newRssFeedsContentsList;

  SetRssFeedsContentsListEvent({required this.newRssFeedsContentsList});

  @override
  List<Object> get props => [newRssFeedsContentsList];
}

class SetTorrentListJsonEvent extends HomeScreenEvent {
  final Map<String, dynamic> newTorrentListJson;

  SetTorrentListJsonEvent({required this.newTorrentListJson});

  @override
  List<Object> get props => [newTorrentListJson];
}

class SetFeedsAndRulesListJsonEvent extends HomeScreenEvent {
  final Map<String, dynamic> newRssFeedsListJson;

  SetFeedsAndRulesListJsonEvent({required this.newRssFeedsListJson});

  @override
  List<Object> get props => [newRssFeedsListJson];
}

class UpdateTorrentListEvent extends HomeScreenEvent {
  final Map<String, dynamic> newTorrentListJson;

  UpdateTorrentListEvent({required this.newTorrentListJson});

  @override
  List<Object> get props => [newTorrentListJson];
}
