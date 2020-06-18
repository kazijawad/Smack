//
//  Constants.swift
//  Smack
//
//  Created by Kazi Jawad on 6/14/20.
//  Copyright © 2020 Kazi Jawad. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ()

// URLs
let BASE_URL = "http://localhost:3005/v1/"
let REGISTER_URL = "\(BASE_URL)account/register"

// Segues
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND_TO_CHANNEL = "unwindToChannel"

// User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"
