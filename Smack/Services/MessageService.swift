//
//  MessageService.swift
//  Smack
//
//  Created by Kazi Jawad on 6/21/20.
//  Copyright © 2020 Kazi Jawad. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    static let instance = MessageService()
    
    var channels = [Channel]()
    var selectedChannel: Channel?
    
    func findAllChanne(completion: @escaping CompletionHandler) {
        AF.request(URL_CHANNEL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADERS_BEARER).responseJSON { (response) in
            switch response.result {
            case .success( _):
                guard let data = response.data else { return }
                do {
                    let json = try JSON(data: data).array!
                    for item in json {
                        let id = item["_id"].stringValue
                        let name = item["name"].stringValue
                        let description = item["description"].stringValue
                        let channel = Channel(id: id, name: name, description: description)
                        self.channels.append(channel)
                    }
                    NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
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
    
    func clearChannels() {
        channels.removeAll()
    }
}
