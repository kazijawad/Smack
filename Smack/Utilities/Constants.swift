//
//  Constants.swift
//  Smack
//
//  Created by Kazi Jawad on 6/14/20.
//  Copyright © 2020 Kazi Jawad. All rights reserved.
//

import Foundation
import Alamofire

typealias CompletionHandler = (_ Success: Bool) -> ()

// URLs
let URL_BASE = "http://localhost:3005/v1/"
let URL_REGISTER = "\(URL_BASE)account/register"
let URL_LOGIN = "\(URL_BASE)account/login"
let URL_USER_ADD = "\(URL_BASE)user/add"
let URL_USER_BY_EMAIL = "\(URL_BASE)user/byEmail/"
let URL_CHANNEL = "\(URL_BASE)channel"
let URL_MESSAGES_BY_CHANNEL = "\(URL_BASE)message/byChannel/"

// Colors
let COLOR_PURPLE = #colorLiteral(red: 0.2588235294, green: 0.3294117647, blue: 0.7254901961, alpha: 0.5)

// Notifications
let NOTIF_USER_DATA_DID_CHANGE = Notification.Name("notifUserDataChanged")
let NOTIF_CHANNELS_LOADED = Notification.Name("notifChannelsLoaded")
let NOTIF_CHANNEL_SELECTED = Notification.Name("notifChannelSelected")

// Segues
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let TO_AVATAR_PICKER = "toAvatarPicker"
let UNWIND_TO_CHANNEL = "unwindToChannel"

// User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

// Headers
let HEADERS: HTTPHeaders = [
    "Content-Type": "application/json; charset=utf-8",
]
let HEADERS_BEARER: HTTPHeaders = [
    "Authorization": "Bearer \(AuthService.instance.authToken)",
    "Content-Type": "application/json; charset=utf-8",
]
