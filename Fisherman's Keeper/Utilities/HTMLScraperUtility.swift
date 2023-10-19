////
////  HTMLScraperUtility.swift
////  Fisherman's Keeper
////
////  Created by Aman Bind on 18/10/23.
////
//
//import Foundation
//import SwiftSoup
//
//import SwiftUI
//
//struct HTMLScraperUtility {
//    @ObservedObject var fishbase = FishbaseSearch()
//    
//    func scrapeHTML(url: URL, isLoadMoreRequest: Bool) {
//        let baseURL = "https://www.fishbase.org.au"
//        
//        do {
//            let html: String = try String(contentsOf: url)
//            let doc: Document = try SwiftSoup.parse(html)
//            guard let body = doc.body() else { return }
//            
//            let rl = try body.select("div.rl")
//            
//            let list = try rl.select("a[href]")
//            
//            let pageStop = try body.select("li.last").select("a").attr("title").replacingOccurrences(of: "Page ", with: "")
//            
//            print("Page Stop : \(pageStop)")
//            
//            fishbase.pageNumberStop = Int(pageStop) ?? 1
//            
//            print("Page number Stop : \(fishbase.pageNumberStop)")
//            
//            if !isLoadMoreRequest {
//                fishbase.fishes.removeAll()
//            }
//            
//            for item in list {
//                let commonEnglishName = try item.select("div.common").text()
//                let scientificName = try item.select("div.science").text()
//                let familyName = try item.select("div.family").text()
//                let imageURL = try item.select("img").attr("src")
//                let articleURL = try item.attr("class", "science").attr("href")
//                
//                let fish = Fish(commonEnglishName: commonEnglishName, scientificName: scientificName, familyName: familyName, imageURL: baseURL + imageURL, articleURL: articleURL)
//                
//                fishbase.fishes.append(fish)
//            }
//        }
//        catch let Exception.Error(type: type, Message: message) {
//            print(type)
//            print(message)
//        }
//        catch {
//            print(error)
//        }
//    }
//}
