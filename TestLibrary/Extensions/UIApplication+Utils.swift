//
//  UIApplication+Utils.swift
//  TestLibrary
//
//  Created by Pablo Fuertes ruiz on 30/5/25.
//

import Foundation
import UIKit

extension UIApplication {
    var keyWindowSafeAreaInsets: UIEdgeInsets {
        connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first(where: { $0.isKeyWindow })?
            .safeAreaInsets ?? .zero
    }
}
