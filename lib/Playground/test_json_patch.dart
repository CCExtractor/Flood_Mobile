import 'package:json_patch/json_patch.dart';

void main() {
  try {
    final newJson = JsonPatch.apply(
      {
        "E2ED9D8DEABDAD0BA046E3792C90FB7657DEEF4A": {
          "bytesDone": 182441860,
          "dateAdded": 1616514924,
          "dateCreated": 1614517583,
          "directory": "/Users/pratikbaid/Downloads/",
          "downRate": 0,
          "downTotal": 174387579,
          "eta": -1,
          "hash": "E2ED9D8DEABDAD0BA046E3792C90FB7657DEEF4A",
          "isPrivate": false,
          "isInitialSeeding": false,
          "isSequential": false,
          "message": "",
          "name": "LibreOffice_7.1.1_Linux_x86-64_deb.tar.gz",
          "peersConnected": 0,
          "peersTotal": 74,
          "percentComplete": 93.04776088181042,
          "priority": 1,
          "ratio": 0,
          "seedsConnected": 0,
          "seedsTotal": 0,
          "sizeBytes": 196073348,
          "status": ["inactive", "stopped"],
          "tags": [],
          "trackerURIs": ["documentfoundation.org"],
          "upRate": 0,
          "upTotal": 0
        },
        "2969286FCA368586FBB0C80192A2E2185CB2405D": {
          "bytesDone": 263634944,
          "dateAdded": 1616869841,
          "dateCreated": 1616339624,
          "directory": "/Users/pratikbaid/Downloads/",
          "downRate": 0,
          "downTotal": 272144452,
          "eta": -1,
          "hash": "2969286FCA368586FBB0C80192A2E2185CB2405D",
          "isPrivate": false,
          "isInitialSeeding": false,
          "isSequential": false,
          "message": "",
          "name":
              "[FreeCourseSite.com] Udemy - iOS & Swift - The Complete iOS App Development Bootcamp",
          "peersConnected": 0,
          "peersTotal": 9,
          "percentComplete": 21.674299568965516,
          "priority": 1,
          "ratio": 0.2208665859556086,
          "seedsConnected": 0,
          "seedsTotal": 7,
          "sizeBytes": 1216348160,
          "status": ["inactive", "stopped"],
          "tags": [],
          "trackerURIs": [
            "dealclub.de",
            "leechers-paradise.org",
            "rarbg.to",
            "desync.com",
            "uw0.xyz",
            "stealth.si",
            "tiny-vps.com",
            "eu.org",
            "opentrackr.org",
            "moeking.me",
            "internetwarriors.net",
            "cyberia.is",
            "demonii.si",
            "openbittorrent.com",
            "coppersurfer.tk"
          ],
          "upRate": 0,
          "upTotal": 60107616
        }
      },
      [
        {
          "op": "replace",
          "path": "/2969286FCA368586FBB0C80192A2E2185CB2405D/status/1",
          "value": "stopped"
        },
        {
          "op": "replace",
          "path": "/2969286FCA368586FBB0C80192A2E2185CB2405D/seedsConnected",
          "value": 0
        },
        {
          "op": "replace",
          "path": "/2969286FCA368586FBB0C80192A2E2185CB2405D/peersTotal",
          "value": 8
        },
        {
          "op": "replace",
          "path": "/2969286FCA368586FBB0C80192A2E2185CB2405D/peersConnected",
          "value": 0
        },
        {
          "op": "replace",
          "path": "/2969286FCA368586FBB0C80192A2E2185CB2405D/downRate",
          "value": 273
        }
      ],
      strict: true,
    );
    print('Object after applying patch operations: $newJson');
  } on JsonPatchTestFailedException catch (e) {
    print(e);
  }
}
