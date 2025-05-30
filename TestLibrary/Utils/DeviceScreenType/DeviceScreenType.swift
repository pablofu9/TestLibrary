//
//  DeviceScreenType.swift
//  TestLibrary
//
//  Created by Pablo Fuertes ruiz on 30/5/25.
//

import Foundation
import UIKit


enum DeviceScreenType {
    case iPhoneSE       // 4.0 - 4.7"
    case iPhoneMini     // 5.4"
    case iPhoneStandard // 6.1" (ex: iPhone 11, 12, 13, 14)
    case iPhonePlus     // 6.5" - 6.7"
    case iPad
    case unknown
}

extension UIScreen {
    var deviceScreenType: DeviceScreenType {
        let height = max(bounds.size.height, bounds.size.width)
        let idiom = UIDevice.current.userInterfaceIdiom
        
        if idiom == .pad {
            return .iPad
        }
        
        switch height {
        case 0..<600:
            return .iPhoneSE
        case 600..<700:
            return .iPhoneMini
        case 700..<750:
            return .iPhoneStandard
        case 750...:
            return .iPhonePlus
        default:
            return .unknown
        }
    }
}
