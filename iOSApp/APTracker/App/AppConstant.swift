//
//  AppConstant.swift
//  APTracker
//
//  Created by Matteo Visotto on 04/04/22.
//

import Foundation

class AppConstant {
    public static let keychainCredentialKey = "APTrackerCredential"
    
    public static let backendDomain = "aptracker.matmacsystem.it"
    public static let localLoginURL = "https://aptracker.matmacsystem.it/auth/login"
    public static let facebookLoginURL = "https://aptracker.matmacsystem.it/auth/social/facebook"
    public static let googleLoginURL = "https://aptracker.matmacsystem.it/auth/social/google"
    public static let refreshTokenURL = "https://aptracker.matmacsystem.it/auth/refresh"
    public static let logoutURL = "https://aptracker.matmacsystem.it/auth/logout"
    public static let registerURL = "https://aptracker.matmacsystem.it/register"
}
