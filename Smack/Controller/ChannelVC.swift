//
//  ChannelVC.swift
//  Smack
//
//  Created by Kazi Jawad on 6/14/20.
//  Copyright © 2020 Kazi Jawad. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 100
    }
}
