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
    
    @Published var userStatus: Bool = false
    
    var session: WCSession!
    
    init(session: WCSession = .default){
        print("Init")
        super.init()
        self.session = session
        session.delegate = self
        session.activate()
        
    }
    
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("R: \(session.isReachable)")
        session.sendMessage(["status":"status"]) { response in
            guard let us = response["isLogged"] as? Bool else {return}
            if(us){
                guard let aToken = response["aToken"] as? String else {return}
                
            }
            DispatchQueue.main.async{
                self.userStatus = us
            }
        } errorHandler: { e in
            print(e.localizedDescription)
        }
        
    }
}
