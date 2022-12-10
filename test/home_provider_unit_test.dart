import 'package:flood_mobile/Model/feeds_content_model.dart';
import 'package:flood_mobile/Model/notification_model.dart';
import 'package:flood_mobile/Model/single_feed_and_response_model.dart';
import 'package:flood_mobile/Model/single_rule_model.dart';
import 'package:flood_mobile/Model/torrent_model.dart';
import 'package:flood_mobile/Provider/home_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late HomeProvider sut;

  setUp(() {
    sut = HomeProvider();
  });

  test(
    "initial values are correct",
    () {
      expect(sut.torrentList, []);
      expect(sut.torrentListJson, {});
      expect(sut.unreadNotifications, 0);
      expect(sut.RssFeedsListJson, {});
      expect(sut.RssFeedsList, []);
      expect(sut.RssRulesList, []);
      expect(sut.RssFeedsContentsList, []);
      expect(sut.upSpeed, '0 KB/s');
      expect(sut.downSpeed, '0 KB/s');
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
        count: 0
      )
    ];

    test(
      "tests setRssFeedsList working",
      () async {
        expect(sut.RssFeedsList.isEmpty, true);
        expect(sut.RssRulesList.isEmpty, true);
        sut.setRssFeedsList(newRssFeedsList, newRssRulesList);
        expect(sut.RssFeedsList.isNotEmpty, true);
        expect(sut.RssRulesList.isNotEmpty, true);
      },
    );
  });

  group('setUnreadNotifications', () {
    final int unreadnotifi = 1;

    test(
      "tests setUnreadNotifications working",
      () async {
        expect(sut.unreadNotifications == 0, true);
        sut.setUnreadNotifications(unreadnotifi);
        expect(sut.unreadNotifications == 1, true);
      },
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

    test(
      "tests setNotificationModel working",
      () async {
        sut.setNotificationModel(newNotificationModel);
        expect(sut.notificationModel.notifications,
            newNotificationModel.notifications);
      },
    );
  });

  group('setSpeed', () {
    final String newUpSpeed = "test UpSpeed";
    final String newDownSpeed = "test DownSpeed";

    test(
      "tests setSpeed working",
      () async {
        expect(sut.upSpeed == '0 KB/s', true);
        expect(sut.downSpeed == '0 KB/s', true);
        sut.setSpeed(newUpSpeed, newDownSpeed);
        expect(sut.upSpeed, newUpSpeed + '/s');
        expect(sut.downSpeed, newDownSpeed + '/s');
      },
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

    test(
      "tests setTorrentList working",
      () async {
        expect(sut.torrentList.isEmpty, true);
        sut.setTorrentList(newTorrentList);
        expect(sut.torrentList, newTorrentList);
      },
    );
  });

  group('setRssFeedsContentsList', () {
    final newRssFeedsContentsList = [
      FeedsContentsModel(title: "test title", urls: ["test urls"])
    ];

    test(
      "tests setRssFeedsContentsList working",
      () async {
        expect(sut.RssFeedsContentsList.isEmpty, true);
        sut.setRssFeedsContentsList(newRssFeedsContentsList);
        expect(sut.RssFeedsContentsList, newRssFeedsContentsList);
      },
    );
  });

  group('setTorrentListJson', () {
    final newTorrentListJson = {'test': "test"};

    test(
      "tests setTorrentListJson working",
      () async {
        expect(sut.torrentListJson.isEmpty, true);
        sut.setTorrentListJson(newTorrentListJson);
        expect(sut.torrentListJson, newTorrentListJson);
      },
    );
  });

  group('setFeedsAndRulesListJson', () {
    final newFeedsAndRulesListJson = {'test': "test"};

    test(
      "tests setFeedsAndRulesListJson working",
      () async {
        expect(sut.RssFeedsListJson.isEmpty, true);
        sut.setFeedsAndRulesListJson(newFeedsAndRulesListJson);
        expect(sut.RssFeedsListJson, newFeedsAndRulesListJson);
      },
    );
  });

  group('updateTorrentList', () {
    final newupdateTorrentListJson = {'test': "test"};

    test(
      "tests updateTorrentList working",
      () async {
        expect(sut.torrentListJson.isEmpty, true);
        sut.updateTorrentList(newupdateTorrentListJson);
        expect(sut.torrentListJson, newupdateTorrentListJson);
      },
    );
  });
}
