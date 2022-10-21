//
//  LensManager.swift
//  SwiftUI Lens Demo
//
//  Created by Sebastian Giraldo on 21/10/22.
//

import UIKit
import VeryfiLens

class LensManager {
    var eventListener: ((_ json: [String : Any]) -> Void)?
    func configure() {
        let credentials = VeryfiLensCredentials(clientId: "", username: "", apiKey: "", url: "")
        let settings = VeryfiLensSettings()
        settings.documentTypes = ["receipt"]
        settings.dataExtractionEngine = .cloudAPI
        settings.showDocumentTypes = true
        VeryfiLens.shared().configure(with: credentials, settings: settings)
    }
    
    func showCamera() {
        if let rootViewController = UIApplication.shared.currentUIWindow()?.rootViewController {
            VeryfiLens.shared().showCamera(in: rootViewController)
        }
    }
    
    func setDelegate(eventListener: @escaping ((_ json: [String : Any]) -> Void)) {
        self.eventListener = eventListener
        VeryfiLens.shared().delegate =  self
    }
    
    func removeDelegate() {
        self.eventListener = nil
        VeryfiLens.shared().delegate = nil
    }
}

extension LensManager: VeryfiLensDelegate {
    func veryfiLensClose(_ json: [String : Any]) {
        eventListener?(json)
    }
    
    func veryfiLensError(_ json: [String : Any]) {
        eventListener?(json)
    }
    
    func veryfiLensSuccess(_ json: [String : Any]) {
        eventListener?(json)
    }
    
    func veryfiLensUpdate(_ json: [String : Any]) {
        eventListener?(json)
    }
}
