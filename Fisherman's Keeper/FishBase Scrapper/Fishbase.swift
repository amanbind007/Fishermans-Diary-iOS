//
//  Fishbase.swift
//  Fisherman's Keeper
//
//  Created by Aman Bind on 14/10/23.
//

import Foundation
import SwiftSoup


struct Fish {
    let commonEnglishName: String?
    let scientificName: String?
    let familyName: String?
    let imageURL: String?
    let articleURL: String?
}

class FishbaseSearch: ObservableObject {
    
    @Published var fishes : [Fish] = []
    
    func getFish(_ searchTerm: String){
        
        let baseURL = "https://www.fishbase.org.au"
        
        let url = URL(string: baseURL+"/v4/search?&q="+searchTerm)
        
        do {
            let html = try String(contentsOf: url!)
            let doc : Document = try SwiftSoup.parse(html)
            guard let body = doc.body() else { return }
            
            let rl = try body.select("div.rl")
            
            let list = try rl.select("a[href]")
            
            fishes.removeAll()
            
            for item in list {
                let commonEnglishName = try item.select("div.common").text()
                let scientificName = try item.select("div.science").text()
                let familyName = try item.select("div.family").text()
                let imageURL = try item.select("img").attr("src")
                let articleURL = try item.attr("class", "science").attr("href")
                
                
                let fish = Fish(commonEnglishName: commonEnglishName, scientificName: scientificName, familyName: familyName, imageURL: baseURL+imageURL, articleURL: articleURL)
                
                fishes.append(fish)

            }
        }
        catch Exception.Error(type: let type, Message: let message){
            print(type)
            print(message)
        }
        catch{
            print(error)
        }
        
    }
    
    
}
