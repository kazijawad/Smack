# Smack

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

```
Swift 5.x
API/Database Server
```

### Installing

A step by step series of examples that tell you how to get a development env running

1. Clone the repository
```
git clone https://github.com/kazijawad/Smack.git
```

2. Launch the workspace in Xcode
```
Smack.xcworkspace
```

3. Initialize API server routes under "Utilities/Constants.swift"
```
let BASE_URL = "http://localhost:3005/v1/"
let REGISTER_URL = "\(BASE_URL)account/register"
let LOGIN_URL = "\(BASE_URL)account/login"
let USER_ADD_URL = "\(BASE_URL)user/add"
```

4. Start MongoDB Daemon and API under `ChatAPI/`

5. Click play to build the app and run on the iOS Simulator

## Built With

* [SWReveal](https://github.com/John-Lluch/SWRevealViewController) - UIViewController Subclass
* [Alamofire](https://github.com/Alamofire/Alamofire) - HTTP Networking Library
* [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON) - JSON Library
* [Socket.IO](https://github.com/socketio/socket.io-client-swift) - Real-Time Engine
* [Starscream](https://github.com/daltoniam/Starscream) - Websocket Library

## Acknowledgments

[Devslopes iOS 11 & Swift 4](https://www.udemy.com/course/devslopes-ios11/)
