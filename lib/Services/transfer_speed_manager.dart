class TransferSpeedManager {
  static var speedToValMap = {
    '1 kB/s': 1024,
    '10 kB/s': 10240,
    '100 kB/s': 102400,
    '500 kB/s': 512000,
    '1 MB/s': 1048576,
    '2 MB/s': 2097152,
    '5 MB/s': 5242880,
    '10 MB/s': 10485760,
    'Unlimited': 0
  };
  static var valToSpeedMap = {
    1024: '1 kB/s',
    10240: '10 kB/s',
    102400: '100 kB/s',
    512000: '500 kB/s',
    1048576: '1 MB/s',
    2097152: '2 MB/s',
    5242880: '5 MB/s',
    10485760: '10 MB/s',
    0: 'Unlimited',
  };
}
