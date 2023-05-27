import 'package:flood_mobile/Provider/graph_provider.dart';
import 'package:flood_mobile/Provider/home_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GraphProvider', () {
    late GraphProvider graphProvider;

    setUp(() {
      graphProvider = GraphProvider();
    });

    test('Initial upload graph data should have 30 items with speed 0.00', () {
      expect(graphProvider.uploadGraphData.length, equals(30));

      for (final item in graphProvider.uploadGraphData) {
        expect(item.speed, equals(0.00));
      }
    });

    test('Initial download graph data should have 30 items with speed 0.00',
        () {
      expect(graphProvider.downloadGraphData.length, equals(30));

      for (final item in graphProvider.downloadGraphData) {
        expect(item.speed, equals(0.00));
      }
    });

    test('Initial fake time should be 31', () {
      expect(graphProvider.fakeTime, equals(31));
    });

    test('Initial show chart status should be false', () {
      expect(graphProvider.showChart, isFalse);
    });

    test('Changing chart status should toggle the show chart status', () {
      final initialStatus = graphProvider.showChart;

      graphProvider.changChartStatus();

      expect(graphProvider.showChart, isNot(equals(initialStatus)));

      graphProvider.changChartStatus();

      expect(graphProvider.showChart, equals(initialStatus));
    });

    test('updateDataSource should update the graph data correctly', () {
      final graphProvider = GraphProvider();
      final homeProvider = HomeProvider();
      homeProvider.upSpeed = '100 KB/s';
      homeProvider.downSpeed = '200 KB/s';

      graphProvider.updateDataSource(homeProvider);

      final uploadGraphData = graphProvider.uploadGraphData;
      final downloadGraphData = graphProvider.downloadGraphData;

      // Check if the last entry in uploadGraphData is updated correctly
      expect(uploadGraphData.last.speed, 100.0);
      expect(uploadGraphData.last.second, 31);

      // Check if the last entry in downloadGraphData is updated correctly
      expect(downloadGraphData.last.speed, 200.0);
      expect(downloadGraphData.last.second, 31);

      // Check if the first entry in uploadGraphData is removed
      expect(uploadGraphData.length, 30);
      expect(uploadGraphData.first.speed, 0.0);
      expect(uploadGraphData.first.second, 2);

      // Check if the first entry in downloadGraphData is removed
      expect(downloadGraphData.length, 30);
      expect(downloadGraphData.first.speed, 0.0);
      expect(downloadGraphData.first.second, 2);

      // Check if the fakeTime is incremented
      expect(graphProvider.fakeTime, 32);
    });
  });
}
