//
//  AmazonScraper.swift
//  Scraper
//
//  Created by Matteo Visotto on 02/04/22.
//

import Foundation
import SwiftSoup

struct AmazonProduct: Codable {
    var name: String
    var price: String
    var description: String
    var images: [String]
}

class AmazonHTMLParser {
    
    public static func parseString(str: String, completionHandler: @escaping (_ product: AmazonProduct?) -> ()){
        do {
           let doc: Document = try SwiftSoup.parse(str)
            let name = try doc.select("span#productTitle").first()?.text()
            let images = try doc.select("#altImages li.item")
            var imgArray: [String] = []
            for image in images {
                let url = try image.select("img").attr("src").replacingOccurrences(of: "US40", with: "SR320,320")
                imgArray.append(url)
            }
            
            let priceWhole = try doc.select("span.a-price-whole").first?.text().replacingOccurrences(of: ",", with: "")
            let priceDecimal = try doc.select("span.a-price-fraction").first?.text()
            let priceSymbol = try doc.select("span.a-price-symbol").first?.text()
            guard let pName = name, let pI = priceWhole, let pD = priceDecimal, let pS = priceSymbol else {completionHandler(nil); return}
            
            let product = AmazonProduct(name: pName, price: pI+"."+pD+pS, description: "", images: imgArray)
            
            completionHandler(product)
            
        } catch {
            completionHandler(nil)
        }
    }
}

class AmazonScraper {
    
    var completionHandler: (_ printable: String) -> () = {_ in}
    
    private var priceOnly: Bool
    
    init(urlString: String, priceOnly: Bool, completionHandler: @escaping (_ printable: String) -> ()) {
        self.completionHandler = completionHandler
        self.priceOnly = priceOnly
        
        guard let url = URL(string: urlString) else {completionHandler("{\"exception\":\"Invalid URL\"}"); return}
       
        do {
            let contentString = try String(contentsOf: url, encoding: .utf8)
            AmazonHTMLParser.parseString(str: contentString) { product in
                do{
                    let jsonEncoder = JSONEncoder()
                    let jsonData = try jsonEncoder.encode(product)
                    guard let jsonString = String(data: jsonData, encoding: String.Encoding.utf8) else {completionHandler("{\"exception\":\"Unable to convert json\"}"); return}
                    completionHandler(jsonString)
                }catch{
                    completionHandler("{\"exception\":\"Unable to convert json\"}")
                }
            }
        } catch {
            completionHandler("{\"exception\":\"An error occured while parsing content\"}")
        }
    }
}
