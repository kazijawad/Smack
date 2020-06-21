//
//  AuthService.swift
//  Smack
//
//  Created by Kazi Jawad on 6/17/20.
//  Copyright © 2020 Kazi Jawad. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService {
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    
    var isLoggedIn: Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToken: String {
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail: String {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler) {
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password,
        ]
        
        AF.request(REGISTER_URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADERS).responseString { (response) in
            switch response.result {
            case .success( _):
                completion(true)
            case .failure(let error):
                completion(false)
                debugPrint(error as Any)
            }
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler) {
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password,
        ]
        
        AF.request(LOGIN_URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADERS).responseJSON { (response) in
            switch response.result {
            case .success( _):
                guard let data = response.data else { return }
                do {
                    let json = try JSON(data: data)
                    self.userEmail = json["user"].stringValue
                    self.authToken = json["token"].stringValue
                    self.isLoggedIn = true
                    completion(true)
                } catch let error {
                    completion(false)
                    debugPrint(error as Any)
                }
            case .failure(let error):
                completion(false)
                debugPrint(error as Any)
            }
        }
    }
    
    func createUser(email: String, name: String, avatarName: String, avatarColor: String, completion: @escaping CompletionHandler) {
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "name": name,
            "avatarName": avatarName,
            "avatarColor": avatarColor,
        ]
        
        AF.request(USER_ADD_URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADERS).responseJSON { (response) in
            switch response.result {
            case .success( _):
                guard let data = response.data else { return }
                let status = self.setUserInfo(data: data)
                completion(status)
            case .failure(let error):
                completion(false)
                debugPrint(error as Any)
            }
        }
    }
    
    func findUserByEmail(completion: @escaping CompletionHandler) {
        AF.request("\(USER_BY_EMAIL_URL)\(userEmail)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADERS).responseJSON { (response) in
            switch response.result {
            case .success( _):
                guard let data = response.data else { return }
                let status = self.setUserInfo(data: data)
                completion(status)
            case .failure(let error):
                completion(false)
                debugPrint(error as Any)
            }
        }
    }
    
    func setUserInfo(data: Data) -> Bool {
        do {
            let json = try JSON(data: data)
            let id = json["_id"].stringValue
            let email = json["email"].stringValue
            let name = json["name"].stringValue
            let avatarName = json["avatarName"].stringValue
            let avatarColor = json["avatarColor"].stringValue
            
            UserDataService.instance.setUserData(id: id, email: email, name: name, avatarName: avatarName, avatarColor: avatarColor)
            return true
        } catch let error {
            debugPrint(error as Any)
            return false
        }
    }
}
