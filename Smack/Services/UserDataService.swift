//
//  UserDataService.swift
//  Smack
//
//  Created by Kazi Jawad on 6/20/20.
//  Copyright © 2020 Kazi Jawad. All rights reserved.
//

import Foundation

class UserDataService {
    static let instance = UserDataService()
    
    public private(set) var id = ""
    public private(set) var email = ""
    public private(set) var name = ""
    public private(set) var avatarName = ""
    public private(set) var avatarColor = ""
    
    func setUserData(id: String, email: String, name: String, avatarName: String, avatarColor: String) {
        self.id = id
        self.email = email
        self.name = name
        self.avatarName = avatarName
        self.avatarColor = avatarColor
    }
    
    func setAvatarName(avatarName: String) {
        self.avatarName = avatarName
    }
}
