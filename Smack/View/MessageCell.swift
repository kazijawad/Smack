//
//  MessageCell.swift
//  Smack
//
//  Created by Kazi Jawad on 7/1/20.
//  Copyright © 2020 Kazi Jawad. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    @IBOutlet weak var userImage: CircleImage!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var messageBodyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(message: Message) {
        userImage.image = UIImage(named: message.userAvatar)
        userNameLabel.text = message.userName
        userImage.backgroundColor = UserDataService.instance.returnUIColor(components: message.userAvatarColor)
        messageBodyLabel.text = message.message
    }
}
