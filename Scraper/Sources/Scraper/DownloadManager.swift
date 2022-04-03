//
//  DownloadManager.swift
//  Scraper
//
//  Created by Matteo Visotto on 02/04/22.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

protocol DownloadManagerDelegate {
    func downloadManager(_ downloadManager: DownloadManager, didFinishWithResult result: Bool, contentString: String) -> Void
}

class DownloadManager {
    private var urlString: String
    
    open var delegate: DownloadManagerDelegate? = nil
    
    init(urlString: String) {
        self.urlString = urlString
    }
    
    public func execute() {
        guard let url = URL(string: self.urlString) else {delegate?.downloadManager(self, didFinishWithResult: false, contentString: "Invalid url"); return}
           
        let sema = DispatchSemaphore( value: 0 )
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config, delegate: URLDelgate(downloadManager: self, sema: sema), delegateQueue: nil )
            session.dataTask( with: url ).resume()
            sema.wait()
    }
    
}

class URLDelgate : NSObject, URLSessionDataDelegate {
    private var downloadManager: DownloadManager
    private var sema: DispatchSemaphore
    init(downloadManager: DownloadManager, sema: DispatchSemaphore) {
        self.downloadManager = downloadManager
        self.sema = sema
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        self.downloadManager.delegate?.downloadManager(self.downloadManager, didFinishWithResult: false, contentString: error?.localizedDescription ?? "Data task error")
        return
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data)
    {
        let response = dataTask.response as! HTTPURLResponse
        let status = response.statusCode
        guard (200...299).contains(status) else {
            self.downloadManager.delegate?.downloadManager(self.downloadManager, didFinishWithResult: false, contentString: "Error: \(status)")
            return
        }
        
        if let s = String(data: data, encoding: .utf8) {
            self.downloadManager.delegate?.downloadManager(self.downloadManager, didFinishWithResult: true, contentString: s)
        } else {
            self.downloadManager.delegate?.downloadManager(self.downloadManager, didFinishWithResult: false, contentString: "Error: Invalid data")
        }
        
        sema.signal()
    }
}

