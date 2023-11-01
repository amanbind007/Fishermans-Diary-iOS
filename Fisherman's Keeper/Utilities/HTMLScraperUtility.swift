//
//  HTMLScraperUtility.swift
//  Fisherman's Keeper
//
//  Created by Aman Bind on 18/10/23.
//

import Combine
import Foundation
import SwiftSoup
import SwiftUI

class HTMLScraperUtility {
    
    @ObservedObject var pageConfig = PageConfig()

    func scrapArticle(from data: Data) -> Future<[Fish], Never> {
        Future { [self] promise in
            let html = String(data: data, encoding: .utf8)!
            var fishes = [Fish]()
            
            do {
                let html = String(data: data, encoding: .utf8)!
                let doc: Document = try SwiftSoup.parse(html)
                guard let body = doc.body() else { return }
                
                let rl = try body.select("div.rl")
                
                let list = try rl.select("a[href]")
                
                let pageStop = try body.select("li.last").select("a").attr("title").replacingOccurrences(of: "Page ", with: "")
                
                //            print("Page Stop : \(pageStop)")
                
                //self.pageNumberStop = Int(pageStop) ?? 1
                pageConfig.pageNumberStop = Int(pageStop) ?? 1
                
                print("Page Stop: \(pageConfig.pageNumberStop)")
                
                //            print("Page number Stop : \(pageNumberStop)")
                
                //                DispatchQueue.main.async {
                //                    self.fishes.removeAll()
                //                }
                
                for item in list {
                    let commonEnglishName = try item.select("div.common").text()
                    let scientificName = try item.select("div.science").text()
                    let familyName = try item.select("div.family").text()
                    let imageURL = try item.select("img").attr("src")
                    let articleURL = try item.attr("class", "science").attr("href")
                    
                    //                print(commonEnglishName)
                    
                    let fish = Fish(commonEnglishName: commonEnglishName, scientificName: scientificName, familyName: familyName, imageURL: Constants.Endpoints.BASEURL + imageURL, articleURL: articleURL)
                    
                    fishes.append(fish)
                }
                    
                promise(.success(fishes))
            } catch {
                debugPrint(error)
                promise(.success([]))
                return
            }
        }
    }
}
