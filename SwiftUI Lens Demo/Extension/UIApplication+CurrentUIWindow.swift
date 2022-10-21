//
//  UIApplication+CurrentUIWindow.swift
//  SwiftUI Lens Demo
//
//  Created by Sebastian Giraldo on 21/10/22.
//

import UIKit

extension UIApplication {
    func currentUIWindow() -> UIWindow? {
        let connectedScenes = UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
        
        let window = connectedScenes.first?
            .windows
            .first { $0.isKeyWindow }

        return window
        
    }
}
