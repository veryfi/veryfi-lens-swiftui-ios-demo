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
        let CLIENT_ID = getEnvironmentVar(key: "VERYFI_CLIENT_ID") // replace with your assigned Client Id
        let AUTH_USERNAME = getEnvironmentVar(key: "VERYFI_USERNAME") // replace with your assigned Username
        let AUTH_APIKEY = getEnvironmentVar(key: "VERYFI_API_KEY") // replace with your assigned API Key
        let URL = getEnvironmentVar(key: "VERYFI_URL") // replace with your assigned Endpoint URL
        
        let credentials = VeryfiLensCredentials(clientId: CLIENT_ID,
                                                          username: AUTH_USERNAME,
                                                          apiKey: AUTH_APIKEY,
                                                          url: URL)
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
    
    //Func to get environment variables.
    private func getEnvironmentVar(key: String) -> String {
        return Bundle.main.object(forInfoDictionaryKey: key) as? String ?? ""
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
