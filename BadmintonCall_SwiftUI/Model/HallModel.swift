//
//  HallModel.swift
//  BadmintonCall_SwiftUI
//
//  Created by 劉洧熏 on 2024/10/1.
//

import UIKit

struct HallModel {
    init(hallName: String, address: String, phoneNumber: Int) {
        self.hallName = hallName
        self.address = address
        self.phoneNumber = phoneNumber
    }
    
    var hallName: String
    var address: String
    var phoneNumber: Int = 0
    
    var image: UIImage = UIImage()
    var actived: Bool = false
    var description: String = ""
}
