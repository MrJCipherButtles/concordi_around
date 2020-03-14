[![Build Status](https://travis-ci.com/MrJCipherButtles/concordi_around.svg?branch=master)](https://travis-ci.com/MrJCipherButtles/concordi_around)
[![codecov](https://codecov.io/gh/MrJCipherButtles/concordi_around/branch/master/graph/badge.svg)](https://codecov.io/gh/MrJCipherButtles/concordi_around)

# ConcordiAround

ConcordiaAround is a campus guide mobile application for Concordia University

## Collaborators

1. Umer Anwar, 40032710
2. Garo Balouzian, 40065652
3. Joshua Butler, 40045825 (Team leader)
4. Raffi Jansezian, 40063156
5. Gregory Khchadourian, 40064648
6. Muhammad Saad Mujtaba, 40043156
7. Seyedhoessein Noorbakhsh, 40036604
8. Divesh Patel, 40027989
9. Mohammad Naimur Rashid, 40027867
10. Chester Yu, 27769504
11. Mehrdad Ahmadi, 40026720

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## User Interface Design

### Prototypes

#### Round 2

- Prototype designed based on round 1 feedback - [Link here](https://www.figma.com/file/rfiUTh2GkeCBAvtW3bqoak/ConcordiAround-(UI-TeamWork)?node-id=0%3A1)

#### Round 1

- Prototype designed by Garo Balouzian - [Link here](https://www.figma.com/file/XzHOtigWV0hs67zmfdpPtm/Concordia-Navigation-App?node-id=0%3A1)
- Prototype designed by Seyedhoessein Noorbakhsh - [Link here](https://www.figma.com/file/WlTDgUjK4guinFq5b1VtfV/ConcordiAround?node-id=0%3A1)
- Prototype designed by Chester Yu - [Link here](https://www.figma.com/file/p7wmZIPNqhUBFpw6sPbtKe/Mockup-v0.1?node-id=0%3A9)

## Getting Started on iOS

1. Your iPhone must be running on the latest public beta software (iOS 13.4).
To get the latest public beta software on your iPhone, you must do so by downloading
the configuration profile from on your iPhone.
[Get Public Beta Software](https://beta.apple.com/sp/betaprogram/enroll#ios)

2. Install Xcode 11.3.1 by following steps on flutter.dev/install.
This may be an optional step, you will need to use Xcode 11.4 beta 3 to run the flutter project;
however, there is no harm in having both the stable and beta versions installed.
[Install Xcode](https://flutter.dev/docs/get-started/install/macos#install-xcode)

3. Download and install Xcode 11.4 beta 3.
This may take some time, the download file is 7.5 GB. Once downloaded,
simply double-click on Xcode_11.4_beta_3.xip to unarchive Xcode-beta.app,
and move it to /Applications folder. [Download Xcode 11.4 beta 3](https://developer.apple.com/download/)

4. xcodebuild should be invoked from Xcode-beta. Run cmd `sudo xcode-select -switch /Applications/Xcode-beta.app/`
[Managing multiple versions of Xcode](http://iosdevelopertips.com/xcode/xcode-select-managing-multiple-versions-of-xcode.html)

5. You can get the project running on your iOS device by following the steps on flutter.dev/install.
[Deploy to iOS devices](https://flutter.dev/docs/get-started/install/macos#deploy-to-ios-devices)

If you are experiencing issues after following these steps, run cmd `flutter doctor -v`
to check that everything has been installed correctly:

    [✓] Xcode - develop for iOS and macOS (Xcode 11.4)
         • Xcode at /Applications/Xcode-beta.app/Contents/Developer
         • Xcode 11.4, Build version 11N132i
         • CocoaPods version 1.8.4

#### Common Mistakes:

- Must be on MacOS.
- iPhone iOS version is less than iOS 11.4
- Using Xcode 11.3.1 instead of 11.4 beta 3
- Did not open ios/Runner.xcworkspace using Xcode to set Runner > Signing & Capabilities > Team, and enable automatically manage signing
- Did not trust this computer when iPhone was connected to by USB to Computer
- Did not trust App on iPhone. Settings > General > Profiles & Device Management > Developer App > Trust Development App