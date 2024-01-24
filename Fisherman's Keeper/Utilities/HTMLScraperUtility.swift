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

// This class is responsible for scraping HTML data to extract fish information
import Combine
class HTMLScraperUtility: ObservableObject {
    
    // Publishing the current page and total pages
    // for UI changes and infinite scrolling
    @Published var currentPage: Int = 1
    @Published var totalPage: Int = 1
    
    // Function to parse HTML data and return a Future containing an array of Fish
    func scrapArticle(from data: Data) -> Future<[Fish], Never> {
        Future { [self] promise in
            let html = String(data: data, encoding: .utf8)!
            var fishes = [Fish]()
            
            do {
                let doc: Document = try SwiftSoup.parse(html)
                guard let body = doc.body() else { return }
                
                let rl = try body.select("div.rl")
                
                let list = try rl.select("a[href]")
                
                let pageStop = try body.select("li.last").select("a").attr("title").replacingOccurrences(of: "Page ", with: "")
                
                totalPage = Int(pageStop) ?? 1
                
                for item in list {
                    // Extract fish information from HTML elements
                    let commonEnglishName = try item.select("div.common").text()
                    let scientificName = try item.select("div.science").text()
                    let familyName = try item.select("div.family").text()
                    let imageURL = try item.select("img").attr("src")
                    let articleURL = try item.attr("class", "science").attr("href")

                    
                    // Create a Fish object and add it to the array
                    let fish = Fish(commonEnglishName: commonEnglishName, scientificName: scientificName, familyName: familyName, imageURL: Constants.Endpoints.BASEURL + imageURL, articleURL: articleURL)
                    
                    fishes.append(fish)
                }
                    
                promise(.success(fishes))
            } catch {
                // Handle errors and return an empty array
                debugPrint(error)
                promise(.success([]))
                return
            }
        }
    }
}
