//
//  Add.swift
//  Scraper
//
//  Created by Matteo Visotto on 02/04/22.
//

import Foundation
import ArgumentParser

extension Command {
  struct Scrape: ParsableCommand {
    static var configuration: CommandConfiguration {
      .init(
        commandName: "amazonUrl",
        abstract: "Scrape and amazon page"
      )
    }

    @Argument(help: "Amazon url that has to be scraped")
    var amazonUrl: String

    func run() throws {
        AmazonScraper(urlString: amazonUrl) { printable in
            print(printable)
        }
    }

  }
}
