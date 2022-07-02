//
//  WatchAppModel.swift
//  watchapp WatchKit Extension
//
//  Created by Matteo Visotto on 01/07/22.
//

import Foundation
import WatchConnectivity
import SwiftUI

class WatchAppModel: NSObject, ObservableObject, WCSessionDelegate {
    
    public static let shared: WatchAppModel = WatchAppModel()
    
    @Published var userStatus: Bool = false
    
    var accessToken: String = ""
    
    var session: WCSession!
    
    init(session: WCSession = .default){
        super.init()
        self.session = session
        session.delegate = self
        session.activate()
    }
    
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        session.sendMessage(["get":"userCredential"]) { response in
            guard let us = response["isLogged"] as? Bool else {return}
            if(us){
                guard let aToken = response["aToken"] as? String else {return}
                self.accessToken = aToken
            }
            DispatchQueue.main.async{
                self.userStatus = us
            }
        } errorHandler: { e in
            print(e.localizedDescription)
        }
        
    }
}
