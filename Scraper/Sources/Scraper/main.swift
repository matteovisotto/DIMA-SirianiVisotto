import Foundation
import ArgumentParser
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

struct Scraper: ParsableCommand {
    @Flag(name: .shortAndLong, help: "Parse only the price without product metadata")
    var priceOnly = false

    @Option(name: [.customShort("w"), .customLong("website")], help: "The website from which scrape data")
    var website: String = "Amazon"

    @Argument(help: "Amazon link to be parsed")
    var url: String

    mutating func run() throws {
        let wSite = website.lowercased()
        if(wSite == "amazon"){
            var substring: String = ""
            var urlSubstring: String = ""
            if let index = url.range(of: "?")?.lowerBound {
                substring = String(url[..<index])
                urlSubstring = String(substring)
                url = urlSubstring
            } else {
                url = self.url
            }
            let _ = AmazonScraper(urlString: url, priceOnly: priceOnly) { printable in
                print(printable)
            }
        } else {
            print("{\"exception\":\"Unsupported website\"}")
        }
    }
}
Scraper.main()
