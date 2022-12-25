<!-- CONTRIBUTING -->

<!-- GETTING STARTED -->

# Getting Started

In order to use the mobile app, you would need the flood backend running on your local machine. There are several ways
you can do that and all these approaches can be found at [Flood WIKI](https://github.com/jesec/flood/wiki)
The way I set it up was using [qBitTorrent](https://www.qbittorrent.org/) as the torrent client and Flood installed
using the npm distribution

## Steps

You can either use qBitTorrent,Transmission or rTorrent as the torrent client

### Install qBitTorrent 
1. Install [qBitTorrent](https://www.qbittorrent.org/)
2. Start the application, click the settings button and setup the Web UI. You would have to set a new username and password and with everything done,
   the qBitTorrent Web UI should be up and running in ```http://localhost:8080/```
   
<p align="center"><img width="400" alt="Screenshot 2022-12-20 at 11 04 PM" src="https://user-images.githubusercontent.com/64683098/208731323-019c3738-6303-4588-ab6d-006cbbee9013.PNG"></p>

<p align="center"><img width="400" alt="Screenshot 2021-05-25 at 1 59 24 PM" src="https://user-images.githubusercontent.com/64683098/208732411-2c7c74b9-0d9c-4804-bf9f-11170ea4696d.PNG"></p>

### Install Transmission 
1. Install [Transmission](https://transmissionbt.com/download)
2. Start the application, click the edit button, select preferences and setup the Remote Control. You would have to set a new port, username and password and with everything done, the traansmission app should be up and running in ```http://localhost:portnumber/```
3. Click Open web client button and access the app
   
<p align="center"><img width="400" alt="trans" src="https://user-images.githubusercontent.com/64683098/209478308-7c58c7a6-7a05-4363-91cd-50bed49b5e52.PNG"></p>

<p align="center"><img width="400" alt="trans1" src="https://user-images.githubusercontent.com/64683098/209478327-d9b1d47c-143e-4ee4-ac6f-dd92ecad5f88.PNG"></p>

<p align="center"><img width="400" alt="trans2" src="https://user-images.githubusercontent.com/64683098/209478329-549b953f-cb33-45fb-82cc-a332b589a688.PNG"></p>

### Install Flood

1. Install Flood using ```sudo npm i -g flood``` / ```npm i -g flood```
2. Run flood using ```flood``` command. After this, flood should be running on ```http://127.0.0.1:3000```
3. Configure the torrent client in the flood web ui by entering the url for qBitTorrent web ui and the username and password.

<p align="center"><img width="400" alt="Screenshot 2021-05-25 at 2 06 39 PM" src="https://raw.githubusercontent.com/KunjKanani/assets/main/Flood-Login-Img.png"></p>

<br /> 

### Installation
1. Clone the repository from GitHub:

```bash
git clone https://github.com/CCExtractor/Flood_Mobile.git
```

2. Navigate to project's root directory:

```bash
cd Flood_Mobile
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

### Login into app
___

> NOTE: MAKE SURE YOUR PC/LAPTOP SHOULD BE CONNECTED IN SAME NETWORK.
___

1. Run flood with specific host
    1. [Find your network ip](https://en.wikipedia.org/wiki/Ipconfig)
    2. Run following command: 
    ``` 
    flood --host your_local_network_ip
    Example:- flood --host 192.168.0.105
    ```
2. Open mobile app fill following login credentials.
   1. URL :- http://your_local_network_ip:3000
   2. Flood Username
   3. Flood Password

<p align="center"><img width="300" alt="Flood App Login Demo Image" src="https://raw.githubusercontent.com/KunjKanani/assets/main/Screenshot_2021-11-11-20-52-46-21_cee4b64e37a5d4be45a41b3aa0b225bb.jpg"></p>

## Prerequisites

* Flutter
* VSCode / Android Studio

## Contributing

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Add all files(`git add .`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request in the **develop branch**
