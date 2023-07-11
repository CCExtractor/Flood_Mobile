class ApiEndpoints {
  // Authentication endpoints
  static String authenticateUrl = '/api/auth/authenticate';

  // User endpoints
  static String getUsersList = '/api/auth/users';
  static String registerUser = '/api/auth/register';
  static String deleteUser = '/api/auth/users';

  // Torrent endpoints
  static String startTorrentUrl = '/api/torrents/start';
  static String getTorrentListUrl = '/api/torrents';
  static String stopTorrentUrl = '/api/torrents/stop';
  static String addTorrentMagnet = '/api/torrents/add-urls';
  static String addTorrentFile = '/api/torrents/add-files';
  static String deleteTorrent = '/api/torrents/delete';
  static String setTags = '/api/torrents/tags';
  static String setTrackers = '/api/torrents/trackers';
  static String updateInitialSeeding = '/api/torrents/initial-seeding';
  static String updateSequential = '/api/torrents/sequential';
  static String reannouncesTorrents = '/api/torrents/reannounce';
  static String updatePriority = '/api/torrents/priority';
  static String getTrackersList = '/api/torrents/';

  // Client settings endpoints
  static String getClientSettingsUrl = '/api/client/settings';
  static String setClientSettingsUrl = '/api/client/settings';
  static String checkClientConeection = '/api/client/connection-test';

  // Torrent content endpoint
  // api/torrents/{hash}/contents
  static String getTorrentContent = '/api/torrents/';

  // Torrent video endpoint
  // api/torrents/{hash}/contents/{id}/data?token={jwt token}
  static String playTorrentVideo = '/api/torrents/';

  // Event stream endpoint
  static String eventsStreamUrl =
      '/api/activity-stream?historySnapshot=FIVE_MINUTE';

  // Torrent content priority endpoint
  // api/torrents/{hash}/contents
  static String setTorrentContentPriorityUrl = '/api/torrents/';

  // Notifications endpoint
  // api/notifications?id=notification-tooltip&limit=10&start=0
  static String notifications = '/api/notifications';

  // Check hash endpoint
  static String checkHash = '/api/torrents/check-hash';

  // Feed monitor endpoints
  // api/feed-monitor/feeds/{id}
  static String addFeeds = '/api/feed-monitor/feeds';
  static String addRules = '/api/feed-monitor/rules';
  static String listAllFeedsAndRules = '/api/feed-monitor';
}
