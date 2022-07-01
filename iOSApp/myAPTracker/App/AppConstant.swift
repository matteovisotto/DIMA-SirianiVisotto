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
    public static let appleLoginURL = "https://aptracker.matmacsystem.it/auth/social/apple"
    public static let refreshTokenURL = "https://aptracker.matmacsystem.it/auth/refresh"
    public static let logoutURL = "https://aptracker.matmacsystem.it/auth/logout"
    public static let registerURL = "https://aptracker.matmacsystem.it/register"
    
    
    public static let addCommentURL = "https://aptracker.matmacsystem.it/api/v1/comment/add"
    public static let getCommentURL = "https://aptracker.matmacsystem.it/api/v1/comment/get"
    public static let removeCommentURL = "https://aptracker.matmacsystem.it/api/v1/comment/remove"
    public static let updateCommentURL = "https://aptracker.matmacsystem.it/api/v1/comment/update"
    
    
    public static let addProductImageURL = "https://aptracker.matmacsystem.it/api/v1/image/add"
    public static let getProductImagesURL = "https://aptracker.matmacsystem.it/api/v1/image/get"
    
    
    public static let addPriceURL = "https://aptracker.matmacsystem.it/api/v1/price/add"
    public static let getPriceURL = "https://aptracker.matmacsystem.it/api/v1/price/get"
    public static let getLastPriceURL = "https://aptracker.matmacsystem.it/api/v1/price/getLast"
    
    
    public static let addProductURL = "https://aptracker.matmacsystem.it/api/v1/product/add"
    public static let getAllProductsURL = "https://aptracker.matmacsystem.it/api/v1/product/getAll"
    public static let getAllPaging = "https://aptracker.matmacsystem.it/api/v1/product/getAllPaging"
    public static let getProductByIdURL = "https://aptracker.matmacsystem.it/api/v1/product/getById"
    public static let getProductByUrlURL = "https://aptracker.matmacsystem.it/api/v1/product/getByUrl"
    public static let getMostTracked = "https://aptracker.matmacsystem.it/api/v1/product/getMostTracked"
    public static let getMostTrackedPaging = "https://aptracker.matmacsystem.it/api/v1/product/getMostTrackedPaging"
    public static let getLastPriceDropPercentage = "https://aptracker.matmacsystem.it/api/v1/product/getByLastPriceDropPercentage"
    public static let getLastPriceDropPercentagePaging = "https://aptracker.matmacsystem.it/api/v1/product/getByLastPriceDropPercentagePaging"
    public static let getPriceDrop = "https://aptracker.matmacsystem.it/api/v1/product/getByPriceDrop"
    public static let getPriceDropPaging = "https://aptracker.matmacsystem.it/api/v1/product/getByPriceDropPaging"
    
    
    public static let addTrackingByIdURL = "https://aptracker.matmacsystem.it/api/v1/tracking/addById"
    public static let addTrackingByUrlURL = "https://aptracker.matmacsystem.it/api/v1/tracking/addByUrl"
    public static let getMyTrackingURL = "https://aptracker.matmacsystem.it/api/v1/tracking/my"
    public static let removeTrackingURL = "https://aptracker.matmacsystem.it/api/v1/tracking/remove"
    public static let updateTrackingURL = "https://aptracker.matmacsystem.it/api/v1/tracking/update"
    public static let getTrackingStatusURL = "https://aptracker.matmacsystem.it/api/v1/tracking/status"
    
    
    public static let userDataURL = "https://aptracker.matmacsystem.it/api/v1/user/me"
    public static let updateUserProfile = "https://aptracker.matmacsystem.it/api/v1/user/updateProfile"
    public static let changeUserPassword = "https://aptracker.matmacsystem.it/api/v1/user/changePassword"
    
    public static let fcmRegistration = "https://aptracker.matmacsystem.it/api/v1/notification/registerDevice"
    
    public static let getCategories = "https://aptracker.matmacsystem.it/api/v1/product/getCategories"
}
