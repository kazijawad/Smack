//
//  SocketService.swift
//  Smack
//
//  Created by Kazi Jawad on 6/21/20.
//  Copyright © 2020 Kazi Jawad. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {
    static let instance = SocketService()
    
    let manager: SocketManager = SocketManager(socketURL: URL(string: URL_BASE)!)
    var socket: SocketIOClient!
    
    override init() {
        super.init()
        socket = manager.defaultSocket
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func addChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler) {
        socket.emit("newChannel", channelName, channelDescription)
        completion(true)
    }
    
    func addMessage(userID: String, channelID: String, messageBody: String, completion: @escaping CompletionHandler) {
        let user = UserDataService.instance
        socket.emit("newMessage", messageBody, userID, channelID, user.name, user.avatarName, user.avatarColor)
        completion(true)
    }
    
    func getChannel(completion: @escaping CompletionHandler) {
        socket.on("channelCreated") { (dataArray, ack) in
            guard let channelName = dataArray[0] as? String else { return }
            guard let channelDescription = dataArray[1] as? String else { return }
            guard let channelID = dataArray[2] as? String else { return }
            
            let newChannel = Channel(id: channelID, name: channelName, description: channelDescription)
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    }
    
    func getMessage(completion: @escaping CompletionHandler) {
        socket.on("messageCreated") { (dataArray, ack) in
            guard let messsageBody = dataArray[0] as? String else { return }
            guard let channelID = dataArray[2] as? String else { return }
            guard let userName = dataArray[3] as? String else { return }
            guard let userAvatar = dataArray[4] as? String else { return }
            guard let userAvatarColor = dataArray[5] as? String else { return }
            guard let id = dataArray[6] as? String else { return }
            guard let timestamp = dataArray[7] as? String else { return }
            
            if channelID == MessageService.instance.selectedChannel?.id && AuthService.instance.isLoggedIn {
                let newMessage = Message(id: id, channelID: channelID, message: messsageBody, userName: userName, userAvatar: userAvatar, userAvatarColor: userAvatarColor, timestamp: timestamp)
                MessageService.instance.messages.append(newMessage)
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func getTypingUsers(_ completionHandler: @escaping (_ typingUsers: [String: String]) -> Void) {
        socket.on("userTypingUpdate") { (dataArray, ack) in
            guard let typingUsers = dataArray[0] as? [String: String] else { return }
            completionHandler(typingUsers)
        }
    }
}
