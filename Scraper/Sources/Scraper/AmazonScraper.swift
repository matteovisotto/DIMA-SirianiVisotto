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
    var category: String
}

class AmazonHTMLParser {
    
    public static func parseString(str: String, completionHandler: @escaping (_ product: AmazonProduct?) -> ()){
        do {
           let doc: Document = try SwiftSoup.parse(str)
            let productNotAvailable = try doc.select("div#percolate-ui-lpo_div div.a-carousel-viewport li.a-carousel-card")
            if (productNotAvailable.count > 0) {
                completionHandler(nil)
                return
            }
            let name = try doc.select("span#productTitle").first()?.text()
            let images = try doc.select("#altImages li.item")
            var imgArray: [String] = []
            let highDef = true;
            var urlImage = ""
            //Togliendo le replacingOccurrences dovrebbe prendere quelle ad highDef e quelle a LowDef in base a richiesta utente (basta aggiungerlo alla chiamata)
            for image in images {
                if (highDef) {
                    urlImage = try image.select("img").attr("data-old-hires").replacingOccurrences(of: "US40", with: "SR320,320")
                } else {
                    urlImage = try image.select("img").attr("src").replacingOccurrences(of: "US40", with: "SR320,320")
                }
                if (urlImage == "") {
                    urlImage = try image.select("img").attr("src").replacingOccurrences(of: "US40", with: "SR320,320")
                }
                imgArray.append(urlImage)
            }
            let priceWhole = try doc.select("span.a-price-whole").first?.text().replacingOccurrences(of: ",", with: "")
            let priceDecimal = try doc.select("span.a-price-fraction").first?.text()
            let priceSymbol = try doc.select("span.a-price-symbol").first?.text()
            var category = try doc.select("span.nav-a-content").first?.text()
            if (category == nil) {
                category = try doc.select("span.a-size-base-plus").first?.text()
                if (category == nil) {
                    category = "generic"
                }
            }
            guard let pName = name, let pI = priceWhole, let pD = priceDecimal, let pS = priceSymbol, let pCategory = category else {completionHandler(nil); return}
            let descriptionBullets = try doc.select("#feature-bullets li")
            var descriptionArray: [String] = []
            for bullet in descriptionBullets {
                let description = try bullet.select("span.a-list-item").text()
                descriptionArray.append(description)
            }
            var description = descriptionArray.joined(separator: ".\\n")
            description = description + "."
            let product = AmazonProduct(name: pName, price: pI+"."+pD+pS, description: description, images: imgArray, category: pCategory)
            
            completionHandler(product)
            
        } catch {
            completionHandler(nil)
        }
    }
    
    public static func parsePriceOnly(str: String, completionHandler: @escaping (_ price: String?) -> ()) {
        do {
           let doc: Document = try SwiftSoup.parse(str)
            let productNotAvailable = try doc.select("div#percolate-ui-lpo_div div.a-carousel-viewport li.a-carousel-card")
            if (productNotAvailable.count > 0) {
                completionHandler(nil)
                return
            }
            let priceWhole = try doc.select("span.a-price-whole").first?.text().replacingOccurrences(of: ",", with: "")
            let priceDecimal = try doc.select("span.a-price-fraction").first?.text()
            let priceSymbol = try doc.select("span.a-price-symbol").first?.text()
            guard let pI = priceWhole, let pD = priceDecimal, let pS = priceSymbol else {completionHandler(nil); return}
            
            completionHandler(pI+"."+pD+pS)
            
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
        
        guard let url = URL(string: urlString) else {completionHandler(urlString + "{\"exception\":\"Invalid URL\"}"); return}
       
        do {
            let contentString = try String(contentsOf: url, encoding: .utf8)
            if(!priceOnly){
                AmazonHTMLParser.parseString(str: contentString) { product in
                    do {
                        if (Int(product?.price.prefix(1) ?? "0") == 0) {
                            completionHandler("{\"exception\":\"Price not valid, check if all the fields are filled\"}")
                            return
                        }
                        let jsonEncoder = JSONEncoder()
                        let jsonData = try jsonEncoder.encode(product)
                        guard let jsonString = String(data: jsonData, encoding: String.Encoding.utf8) else {completionHandler("{\"exception\":\"Unable to convert json\"}"); return}
                        completionHandler(jsonString)
                    } catch {
                        completionHandler("{\"exception\":\"Unable to convert json\"}")
                    }
                }
            } else {
                AmazonHTMLParser.parsePriceOnly(str: contentString) { price in
                    if let price = price {
                        if (Int(price.prefix(1)) == 0) {
                            completionHandler("{\"exception\":\"Price not valid, check if all the fields are filled\"}")
                            return
                        }
                        completionHandler("{\"price\":\""+price+"\"}")
                    } else {
                        completionHandler("{\"exception\":\"Unable to find the price\"}")
                    }
                }
            }
        } catch {
            completionHandler("{\"exception\":\"An error occured while parsing content\"}")
        }
    }
}
