# Flood Mobile App
![Group 3](https://user-images.githubusercontent.com/52864956/118592164-24de8280-b7c3-11eb-95f3-f575fd75d356.png)

<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#supported-clients">Supported Clients</a></li>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage & Screenshots</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project
[![Flood logo](https://github.com/jesec/flood/raw/master/flood.svg)](https://flood.js.org)
 
Flood is a monitoring service for various torrent clients. It's a Node.js service that communicates with your favorite torrent client and serves a decent mobile UI for administration. The web ap and other relevant documentation can be found at [Flood](https://github.com/jesec/floodI).

#### Supported Clients

| Client                                                          | Support                                                                                                      |
| --------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------ |
| [rTorrent](https://github.com/rakshasa/rtorrent)                | :white_check_mark: ([tested](https://github.com/jesec/flood/blob/master/server/.jest/rtorrent.setup.js))     |
| [qBittorrent](https://github.com/qbittorrent/qBittorrent) v4.1+ | :white_check_mark: ([tested](https://github.com/jesec/flood/blob/master/server/.jest/qbittorrent.setup.js))  |
| [Transmission](https://github.com/transmission/transmission)    | :white_check_mark: ([tested](https://github.com/jesec/flood/blob/master/server/.jest/transmission.setup.js)) |

### Built With
* [Dart](https://dart.dev/)
* [Flutter](https://flutter.dev/)
* [flutter_client_sse](https://github.com/pratikbaid3/flutter_client_sse)



<!-- GETTING STARTED -->
## Getting Started

In order to use the mobile app, you would need the flood backend running on your local machine. There are several ways you can do that and all these approaches can be found at [Flood WIKI](https://github.com/jesec/flood/wiki)
The way I set it up was using [qBitTorrent](https://www.qbittorrent.org/) as the torrent client and Flood installed using the npm distribution 

### Steps
1. Install [qBitTorrent](https://www.qbittorrent.org/)
2. In the preferences, set up the Web UI. You would have to set a new username nad password and with everything done, the qBitTorrent Web UI should be up and running in ```http://localhost:8080/```        
                                                                                                                                                                 
<img width="400" alt="Screenshot 2021-05-25 at 1 59 24 PM" src="https://user-images.githubusercontent.com/52864956/119465947-c9cc0300-bd61-11eb-97a4-7889aec00fe9.png">

3. Install Flood using ```sudo npm i -g flood```
4. Run flood using ```flood```. After this, flood should be running on ```http://127.0.0.1:3000```
5. Configure the torrent client in the flood web ui by entering the url for qBitTorrent web ui and the username and pasword. 

<img width="400" alt="Screenshot 2021-05-25 at 2 06 39 PM" src="https://user-images.githubusercontent.com/52864956/119466727-8aea7d00-bd62-11eb-860c-a85398ef3113.png">

### Prerequisites
* Flutter
* VSCode / Android Studio

### Installation

1. Clone the repository from GitHub:
```bash
git clone https://github.com/CCExtractor/Flood_Mobile.git
```
2. Navigate to project's root directory:
```bash
cd flood_mobile
```
3. Check for Flutter setup and connected devices:
```bash
flutter doctor
```
4. Get the dependancies
```bash
flutter pub get
```
5. Installing packages (**IOS ONLY**)
```bash
cd ios
pod install --verbose
```
6. Run the app:
```bash
flutter run
```


<!-- USAGE EXAMPLES -->
## Usage & Screenshots

https://user-images.githubusercontent.com/52864956/119470249-c76ba800-bd65-11eb-9a9e-8c860fdd1f9d.mov


<img src="https://user-images.githubusercontent.com/52864956/119470520-0bf74380-bd66-11eb-8378-ee26877dcaf7.png" width=250>  <img src="https://user-images.githubusercontent.com/52864956/119470670-2e895c80-bd66-11eb-9aaa-6d6aa9659329.png" width=250>  <img src="https://user-images.githubusercontent.com/52864956/119470714-38ab5b00-bd66-11eb-9f7f-20eadd0c6a4f.png" width=250>  <img src="https://user-images.githubusercontent.com/52864956/119470671-2e895c80-bd66-11eb-8b86-c16ae139331e.png" width=250>  <img src="https://user-images.githubusercontent.com/52864956/119470337-de11ff00-bd65-11eb-951c-70db8aec0f52.png" width=250>  <img src="https://user-images.githubusercontent.com/52864956/119470372-e702d080-bd65-11eb-9565-d3ffe90a4599.png" width=250>  <img src="https://user-images.githubusercontent.com/52864956/119470428-f2ee9280-bd65-11eb-9073-f0fc7496888a.png" width=250>




<!-- ROADMAP -->
## Roadmap
Coming Soon!


<!-- CONTRIBUTING -->
## Contributing

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request


<!-- CONTACT -->
## Contact

[Pratik Baid](https://www.linkedin.com/in/pratik-baid-aa253980/)
Project Link: [Flood_Mobile](https://github.com/CCExtractor/Flood_Mobile)

