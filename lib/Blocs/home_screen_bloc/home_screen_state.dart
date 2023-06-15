// ignore_for_file: must_be_immutable

part of 'home_screen_bloc.dart';

class HomeScreenState extends Equatable {
  final List<TorrentModel> torrentList;
  final Map<String, dynamic> torrentListJson;
  final int unreadNotifications;
  final NotificationModel notificationModel;
  final Map<String, dynamic> rssFeedsListJson;
  final List<FeedsAndRulesModel> rssFeedsList;
  final List<RulesModel> rssRulesList;
  final List<FeedsContentsModel> rssFeedsContentsList;
  String upSpeed;
  String downSpeed;

  HomeScreenState({
    required this.torrentList,
    required this.torrentListJson,
    required this.unreadNotifications,
    required this.notificationModel,
    required this.rssFeedsListJson,
    required this.rssFeedsList,
    required this.rssRulesList,
    required this.rssFeedsContentsList,
    required this.upSpeed,
    required this.downSpeed,
  });

  HomeScreenState copyWith({
    List<TorrentModel>? torrentList,
    Map<String, dynamic>? torrentListJson,
    int? unreadNotifications,
    NotificationModel? notificationModel,
    Map<String, dynamic>? rssFeedsListJson,
    List<FeedsAndRulesModel>? rssFeedsList,
    List<RulesModel>? rssRulesList,
    List<FeedsContentsModel>? rssFeedsContentsList,
    String? upSpeed,
    String? downSpeed,
  }) {
    return HomeScreenState(
      torrentList: torrentList ?? this.torrentList,
      torrentListJson: torrentListJson ?? this.torrentListJson,
      unreadNotifications: unreadNotifications ?? this.unreadNotifications,
      notificationModel: notificationModel ?? this.notificationModel,
      rssFeedsListJson: rssFeedsListJson ?? this.rssFeedsListJson,
      rssFeedsList: rssFeedsList ?? this.rssFeedsList,
      rssRulesList: rssRulesList ?? this.rssRulesList,
      rssFeedsContentsList: rssFeedsContentsList ?? this.rssFeedsContentsList,
      upSpeed: upSpeed ?? this.upSpeed,
      downSpeed: downSpeed ?? this.downSpeed,
    );
  }

  @override
  List<Object?> get props => [
        torrentList,
        torrentListJson,
        unreadNotifications,
        notificationModel,
        rssFeedsListJson,
        rssFeedsList,
        rssRulesList,
        rssFeedsContentsList,
        upSpeed,
        downSpeed,
      ];
}

class HomeScreenInitial extends HomeScreenState {
  HomeScreenInitial()
      : super(
          torrentList: [],
          torrentListJson: {},
          unreadNotifications: 0,
          notificationModel: NotificationModel(
              read: 0, unread: 0, notifications: [], total: 0),
          rssFeedsListJson: {},
          rssFeedsList: [],
          rssRulesList: [],
          rssFeedsContentsList: [],
          upSpeed: '0 KB/s',
          downSpeed: '0 KB/s',
        );

  @override
  List<Object?> get props => super.props;
}
