import 'package:bloc_test/bloc_test.dart';
import 'package:flood_mobile/Model/feeds_content_model.dart';
import 'package:flood_mobile/Model/notification_model.dart';
import 'package:flood_mobile/Model/single_feed_and_response_model.dart';
import 'package:flood_mobile/Model/single_rule_model.dart';
import 'package:flood_mobile/Model/torrent_model.dart';
import 'package:flood_mobile/Blocs/home_screen_bloc/home_screen_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late HomeScreenBloc sut;

  setUp(() {
    sut = HomeScreenBloc();
  });

  test(
    "initial values are correct",
    () {
      expect(sut.state.torrentList, []);
      expect(sut.state.torrentListJson, {});
      expect(sut.state.unreadNotifications, 0);
      expect(sut.state.notificationModel.read, 0);
      expect(sut.state.notificationModel.unread, 0);
      expect(sut.state.notificationModel.notifications, []);
      expect(sut.state.notificationModel.total, 0);
      expect(sut.state.rssFeedsListJson, {});
      expect(sut.state.rssFeedsList, []);
      expect(sut.state.rssRulesList, []);
      expect(sut.state.rssFeedsContentsList, []);
      expect(sut.state.upSpeed, '0 KB/s');
      expect(sut.state.downSpeed, '0 KB/s');
    },
  );

  group('setRssFeedsList', () {
    final newRssFeedsList = [
      FeedsAndRulesModel(
          type: 'test feed',
          label: 'test label',
          interval: 0,
          id: 'test id',
          url: 'test url',
          count: 0)
    ];
    final newRssRulesList = [
      RulesModel(
          type: 'test rules',
          label: 'test label',
          feedIDs: ['test feedIDs'],
          field: 'test field',
          tags: ['test tags'],
          match: 'test match',
          exclude: 'test exclude',
          destination: 'test destination',
          id: 'test id',
          isBasePath: true,
          startOnLoad: true,
          count: 0)
    ];

    blocTest<HomeScreenBloc, HomeScreenState>(
      'emits updated state when setRssFeedsList is called',
      build: () => sut,
      act: (bloc) => bloc.add(SetRssFeedsListEvent(
          newRssFeedsList: newRssFeedsList, newRssRulesList: newRssRulesList)),
      expect: () => [
        HomeScreenState(
          torrentList: [],
          torrentListJson: {},
          unreadNotifications: 0,
          notificationModel: NotificationModel(
              read: 0, unread: 0, notifications: [], total: 0),
          rssFeedsListJson: {},
          rssFeedsList: newRssFeedsList,
          rssRulesList: newRssRulesList,
          rssFeedsContentsList: [],
          upSpeed: '0 KB/s',
          downSpeed: '0 KB/s',
        ),
      ],
    );
  });

  group('setUnreadNotifications', () {
    final int unreadnotification = 1;

    blocTest<HomeScreenBloc, HomeScreenState>(
      'emits updated state when setUnreadNotifications is called',
      build: () => sut,
      act: (bloc) =>
          bloc.add(SetUnreadNotificationsEvent(count: unreadnotification)),
      expect: () => [
        HomeScreenState(
          torrentList: [],
          torrentListJson: {},
          unreadNotifications: unreadnotification,
          notificationModel: NotificationModel(
              read: 0, unread: 0, notifications: [], total: 0),
          rssFeedsListJson: {},
          rssFeedsList: [],
          rssRulesList: [],
          rssFeedsContentsList: [],
          upSpeed: '0 KB/s',
          downSpeed: '0 KB/s',
        ),
      ],
    );
  });

  group('setNotificationModel', () {
    final newNotificationModel = NotificationModel(notifications: [
      NotificationContentModel(
          identification: "test notification",
          id: "test notification",
          name: "test notification",
          read: true,
          ts: 0,
          status: "test notification status")
    ], read: 0, unread: 0, total: 0);

    blocTest<HomeScreenBloc, HomeScreenState>(
      'emits updated state when setNotificationModel is called',
      build: () => sut,
      act: (bloc) =>
          bloc.add(SetNotificationModelEvent(newModel: newNotificationModel)),
      expect: () => [
        HomeScreenState(
          torrentList: [],
          torrentListJson: {},
          unreadNotifications: 0,
          notificationModel: newNotificationModel,
          rssFeedsListJson: {},
          rssFeedsList: [],
          rssRulesList: [],
          rssFeedsContentsList: [],
          upSpeed: '0 KB/s',
          downSpeed: '0 KB/s',
        ),
      ],
    );
  });

  group('setSpeed', () {
    final String newUpSpeed = "test UpSpeed";
    final String newDownSpeed = "test DownSpeed";

    blocTest<HomeScreenBloc, HomeScreenState>(
      'emits updated state when setSpeed is called',
      build: () => sut,
      act: (bloc) =>
          bloc.add(SetSpeedEvent(up: newUpSpeed, down: newDownSpeed)),
      expect: () => [
        HomeScreenState(
          torrentList: [],
          torrentListJson: {},
          unreadNotifications: 0,
          notificationModel: NotificationModel(
              read: 0, unread: 0, notifications: [], total: 0),
          rssFeedsListJson: {},
          rssFeedsList: [],
          rssRulesList: [],
          rssFeedsContentsList: [],
          upSpeed: newUpSpeed + '/s',
          downSpeed: newDownSpeed + '/s',
        ),
      ],
    );
  });

  group('setTorrentList', () {
    final newTorrentList = [
      TorrentModel(
          bytesDone: 0.0,
          dateAdded: 0.0,
          dateCreated: 0.0,
          directory: "test directory",
          downRate: 0.0,
          downTotal: 0.0,
          eta: 0.0,
          hash: "test hash",
          isInitialSeeding: true,
          isPrivate: true,
          isSequential: true,
          message: "test message",
          name: "test name",
          peersConnected: 0.0,
          peersTotal: 0.0,
          percentComplete: 0.0,
          priority: 0.0,
          ratio: 0.0,
          seedsConnected: 0.0,
          seedsTotal: 0.0,
          sizeBytes: 0.0,
          status: ["test status"],
          tags: ["test tags"],
          trackerURIs: ["test trackerURIs"],
          upRate: 0.0,
          upTotal: 0.0)
    ];

    blocTest<HomeScreenBloc, HomeScreenState>(
      'emits updated state when setTorrentList is called',
      build: () => sut,
      act: (bloc) =>
          bloc.add(SetTorrentListEvent(newTorrentList: newTorrentList)),
      expect: () => [
        HomeScreenState(
          torrentList: newTorrentList,
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
        ),
      ],
    );
  });

  group('setRssFeedsContentsList', () {
    final newRssFeedsContentsList = [
      FeedsContentsModel(title: "test title", urls: ["test urls"])
    ];

    blocTest<HomeScreenBloc, HomeScreenState>(
      'emits updated state when setRssFeedsContentsList is called',
      build: () => sut,
      act: (bloc) => bloc.add(SetRssFeedsContentsListEvent(
          newRssFeedsContentsList: newRssFeedsContentsList)),
      expect: () => [
        HomeScreenState(
          torrentList: [],
          torrentListJson: {},
          unreadNotifications: 0,
          notificationModel: NotificationModel(
              read: 0, unread: 0, notifications: [], total: 0),
          rssFeedsListJson: {},
          rssFeedsList: [],
          rssRulesList: [],
          rssFeedsContentsList: newRssFeedsContentsList,
          upSpeed: '0 KB/s',
          downSpeed: '0 KB/s',
        ),
      ],
    );
  });

  group('setTorrentListJson', () {
    final newTorrentListJson = {'test': "test"};

    blocTest<HomeScreenBloc, HomeScreenState>(
      'emits updated state when setTorrentListJson is called',
      build: () => sut,
      act: (bloc) => bloc
          .add(SetTorrentListJsonEvent(newTorrentListJson: newTorrentListJson)),
      expect: () => [
        HomeScreenState(
          torrentList: [],
          torrentListJson: newTorrentListJson,
          unreadNotifications: 0,
          notificationModel: NotificationModel(
              read: 0, unread: 0, notifications: [], total: 0),
          rssFeedsListJson: {},
          rssFeedsList: [],
          rssRulesList: [],
          rssFeedsContentsList: [],
          upSpeed: '0 KB/s',
          downSpeed: '0 KB/s',
        ),
      ],
    );
  });

  group('setFeedsAndRulesListJson', () {
    final newFeedsAndRulesListJson = {'test': "test"};

    blocTest<HomeScreenBloc, HomeScreenState>(
      'emits updated state when setFeedsAndRulesListJson is called',
      build: () => sut,
      act: (bloc) => bloc.add(SetFeedsAndRulesListJsonEvent(
          newRssFeedsListJson: newFeedsAndRulesListJson)),
      expect: () => [
        HomeScreenState(
          torrentList: [],
          torrentListJson: {},
          unreadNotifications: 0,
          notificationModel: NotificationModel(
              read: 0, unread: 0, notifications: [], total: 0),
          rssFeedsListJson: newFeedsAndRulesListJson,
          rssFeedsList: [],
          rssRulesList: [],
          rssFeedsContentsList: [],
          upSpeed: '0 KB/s',
          downSpeed: '0 KB/s',
        ),
      ],
    );
  });

  group('updateTorrentList', () {
    final newupdateTorrentListJson = {'test': "test"};

    blocTest<HomeScreenBloc, HomeScreenState>(
      'emits updated state when updateTorrentList is called',
      build: () => sut,
      act: (bloc) => bloc.add(
          UpdateTorrentListEvent(newTorrentListJson: newupdateTorrentListJson)),
      expect: () => [
        HomeScreenState(
          torrentList: [],
          torrentListJson: newupdateTorrentListJson,
          unreadNotifications: 0,
          notificationModel: NotificationModel(
              read: 0, unread: 0, notifications: [], total: 0),
          rssFeedsListJson: {},
          rssFeedsList: [],
          rssRulesList: [],
          rssFeedsContentsList: [],
          upSpeed: '0 KB/s',
          downSpeed: '0 KB/s',
        ),
      ],
    );
  });
}
