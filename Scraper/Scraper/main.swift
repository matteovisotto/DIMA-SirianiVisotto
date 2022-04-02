//
//  main.swift
//  Scraper
//
//  Created by Matteo Visotto on 02/04/22.
//

import Foundation
import ArgumentParser

/*var sema = DispatchSemaphore( value: 0 )

class Delegate : NSObject, URLSessionDataDelegate
{
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data)
    {
        print("got data \(String(data: data, encoding: .utf8 ) ?? "<empty>")");
        sema.signal()
    }
}

let config = URLSessionConfiguration.default
let session = URLSession(configuration: config, delegate: Delegate(), delegateQueue: nil )

guard let url = URL( string:"https://google.com" ) else { fatalError("Could not create URL object") }

session.dataTask( with: url ).resume()

sema.wait()
*/

enum Command {}

extension Command {
  struct Main: ParsableCommand {
    static var configuration: CommandConfiguration {
      .init(
        commandName: "Scraper",
        abstract: "A program used to scrape information from a website",
        version: "0.0.1",
        subcommands: [
          Command.Scrape.self
        ]
      )
    }
  }
}

Command.Main.main()
