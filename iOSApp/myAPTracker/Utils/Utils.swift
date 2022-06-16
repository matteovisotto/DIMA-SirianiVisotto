//
//  Utils.swift
//  APTracker
//
//  Created by Matteo Visotto on 06/04/22.
//

import Foundation

class Utils {
    static func getInitialFromIdentity(_ identity: UserIdentity?) -> String {
        var id = ""
        if let identity = identity {
            if let n = identity.name.first {
                id = id + String(n)
            }
            if let s = identity.surname.first {
                id = id + String(s)
            }
        }
        return id
    }
    
    static func getInitialFromComment(_ identity: Comment?) -> String {
        var id = ""
        if let identity = identity {
            if let n = identity.name.first {
                id = id + String(n)
            }
            if let s = identity.surname.first {
                id = id + String(s)
            }
        }
        return id
    }
}
