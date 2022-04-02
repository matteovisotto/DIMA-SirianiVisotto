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

class Parser {
    
    public static func parseString(str: String, completionHandler: @escaping (_ product: AmazonProduct) -> ()){
        
    }
}

class AmazonScraper {
    
    var completionHandler: (_ printable: String) -> () = {_ in}
    
    init(urlString: String, completionHandler: @escaping (_ printable: String) -> ()) {
        self.completionHandler = completionHandler
        let downloader: DownloadManager = DownloadManager(urlString: urlString)
        downloader.delegate = self
        downloader.execute()
    }
    
    
}


extension AmazonScraper: DownloadManagerDelegate {
    func downloadManager(_ downloadManager: DownloadManager, didFinishWithResult result: Bool, contentString: String) {
        if result {
            Parser.parseString(str: contentString) { product in
                
            }
        } else {
            print("{\"exception\":\""+contentString+"\"}")
        }
        exit(0)
    }
}
