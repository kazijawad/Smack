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
    
    func returnUIColor(components: String) -> UIColor {
        let defaultColor = UIColor.lightGray
        let scanner = Scanner(string: components)
        let skipped = CharacterSet(charactersIn: "[], ")
        let comma = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = skipped
        
        guard let r = scanner.scanUpToCharacters(from: comma) else { return defaultColor }
        guard let g = scanner.scanUpToCharacters(from: comma) else { return defaultColor }
        guard let b = scanner.scanUpToCharacters(from: comma) else { return defaultColor }
        
        let rFloat = (r as NSString).floatValue
        let gFloat = (g as NSString).floatValue
        let bFloat = (b as NSString).floatValue
        
        let newUIColor = UIColor(red: CGFloat(rFloat), green: CGFloat(gFloat), blue: CGFloat(bFloat), alpha: 1)
        return newUIColor
    }
}
