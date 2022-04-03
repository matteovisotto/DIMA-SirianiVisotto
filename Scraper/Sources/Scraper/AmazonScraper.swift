//
//  AmazonScraper.swift
//  Scraper
//
//  Created by Matteo Visotto on 02/04/22.
//

import Foundation
import SwiftSoup

struct AmazonProduct {
    var name: String
    var price: String
    var description: String
    var images: [String]
}

class AmazonHTMLParser {
    
    public static func parseString(str: String, completionHandler: @escaping (_ product: AmazonProduct) -> ()){
        
    }
}

class AmazonScraper {
    
    var completionHandler: (_ printable: String) -> () = {_ in}
    
    private var priceOnly: Bool
    
    init(urlString: String, priceOnly: Bool, completionHandler: @escaping (_ printable: String) -> ()) {
        self.completionHandler = completionHandler
        self.priceOnly = priceOnly
        let downloader: DownloadManager = DownloadManager(urlString: urlString)
        downloader.delegate = self
        downloader.execute()
    }
    
    
}


extension AmazonScraper: DownloadManagerDelegate {
    func downloadManager(_ downloadManager: DownloadManager, didFinishWithResult result: Bool, contentString: String) {
        if result {
            AmazonHTMLParser.parseString(str: contentString) { product in
                
            }
        } else {
            completionHandler("{\"exception\":\""+contentString+"\"}")
        }
        exit(0)
    }
}
