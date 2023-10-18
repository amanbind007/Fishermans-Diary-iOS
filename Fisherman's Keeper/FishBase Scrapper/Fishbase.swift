//
//  Fishbase.swift
//  Fisherman's Keeper
//
//  Created by Aman Bind on 14/10/23.
//

import Foundation
import SwiftSoup

class FishbaseSearch: ObservableObject {
    @Published var fishes: [Fish] = []
    
    let baseURL = "https://www.fishbase.org.au"
    @Published var pageNumberStart: Int = 1
    @Published var pageNumberStop: Int = 1
    
    func getFish(_ searchTerm: String) {
        pageNumberStart = 1
        
        let url = URL(string: baseURL+"/v4/search?&q=\(searchTerm == "" ? "fish" : searchTerm)&page=\(pageNumberStart)")
        
        do {
            let html: String = try String(contentsOf: url!)
            let doc: Document = try SwiftSoup.parse(html)
            guard let body = doc.body() else { return }
            
            let rl = try body.select("div.rl")
            
            let list = try rl.select("a[href]")
            
            let pageStop = try body.select("li.last").select("a").attr("title").replacingOccurrences(of: "Page ", with: "")
            
            print("Page Stop : \(pageStop)")
            
            pageNumberStop = Int(pageStop) ?? 1
            
            print("Page number Stop : \(pageNumberStop)")
            
            fishes.removeAll()
            
            for item in list {
                let commonEnglishName = try item.select("div.common").text()
                let scientificName = try item.select("div.science").text()
                let familyName = try item.select("div.family").text()
                let imageURL = try item.select("img").attr("src")
                let articleURL = try item.attr("class", "science").attr("href")
                
                print(commonEnglishName)
                
                let fish = Fish(commonEnglishName: commonEnglishName, scientificName: scientificName, familyName: familyName, imageURL: baseURL+imageURL, articleURL: articleURL)
                
                fishes.append(fish)
            }
        }
        catch let Exception.Error(type: type, Message: message) {
            print(type)
            print(message)
        }
        catch {
            print(error)
        }
    }
    
    func getMoreFish(_ searchTerm: String) {
        if pageNumberStart < pageNumberStop {
            pageNumberStart += 1
        }
        else {
            return
        }
        
        let url = URL(string: baseURL+"/v4/search?&q=\(searchTerm == "" ? "fish" : searchTerm)&page=\(pageNumberStart)")
        
        do {
            let html = try String(contentsOf: url!)
            let doc: Document = try SwiftSoup.parse(html)
            guard let body = doc.body() else { return }
                
            let rl = try body.select("div.rl")
                
            let list = try rl.select("a[href]")
                
            let pageStop = try body.select("li.last").select("a").attr("title").replacingOccurrences(of: "Page ", with: "")
                
            print("Page Stop : \(pageStop)")
                
            pageNumberStop = Int(pageStop) ?? 1
                
            print("Page number Stop : \(pageNumberStop)")
                
            //            fishes.removeAll()
                
            for item in list {
                let commonEnglishName = try item.select("div.common").text()
                let scientificName = try item.select("div.science").text()
                let familyName = try item.select("div.family").text()
                let imageURL = try item.select("img").attr("src")
                let articleURL = try item.attr("class", "science").attr("href")
                    
                print(commonEnglishName)
                    
                let fish = Fish(commonEnglishName: commonEnglishName, scientificName: scientificName, familyName: familyName, imageURL: baseURL+imageURL, articleURL: articleURL)
                    
                fishes.append(fish)
            }
        }
        catch let Exception.Error(type: type, Message: message) {
            print(type)
            print(message)
        }
        catch {
            print(error)
        }
        
        // isLoading = false
    }
}
