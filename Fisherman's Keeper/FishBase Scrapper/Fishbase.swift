//
//  Fishbase.swift
//  Fisherman's Keeper
//
//  Created by Aman Bind on 14/10/23.
//

import Combine
import Foundation
import SwiftSoup
import SwiftUI

@MainActor
class FishbaseSearch: ObservableObject {
    let baseURL = "https://www.fishbase.org.au"
    
//    var htmlScrapUtlity: HTMLScraperUtility
//
//        init() {
//            self.htmlScrapUtlity = HTMLScraperUtility(fishbase: self)
//        }

    var htmlScraperUtility = HTMLScraperUtility()
    @ObservedObject var pageConfig = PageConfig()

    
    @Published var fishes = [Fish]()
//    @Published var pageNumberStart: Int = 1
//    @Published var pageNumberStop: Int = 1
    
    var cancellableTask: AnyCancellable? = nil
    
    func getFish(_ searchTerm: String) {
        fishes = []
        guard let url = URL(string: baseURL + "/v4/search?&q=\(searchTerm == "" ? "fish" : searchTerm)&page=\(pageConfig.pageNumberStart)") else { return }
        // self.isArticlesLoading = true
        cancellableTask?.cancel()
        cancellableTask = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data) // extract Data() from tuple
            .flatMap(htmlScraperUtility.scrapArticle(from:))
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in
                // print(completetion)
            }, receiveValue: { [unowned self] fishes in
                self.fishes = fishes
            })
        
//        print("Page Stop: \(pageConfig.pageNumberStop)")
    }
    
    func getMoreFish(_ searchTerm: String) {
        if pageConfig.pageNumberStart >= pageConfig.pageNumberStop { return }
            
        pageConfig.pageNumberStart += 1
        guard let url = URL(string: baseURL + "/v4/search?&q=\(searchTerm == "" ? "fish" : searchTerm)&page=\(pageConfig.pageNumberStart)") else { return }
        // self.isArticlesLoading = true
        cancellableTask?.cancel()
        cancellableTask = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data) // extract Data() from tuple
            .flatMap(htmlScraperUtility.scrapArticle(from:))
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in
                //
            }, receiveValue: { [unowned self] fishes in
                self.fishes.append(contentsOf: fishes)
            })
    }
    
//    func getFish(_ searchTerm: String) {
//        pageNumberStart = 1
//
//        let url = URL(string: baseURL+"/v4/search?&q=\(searchTerm == "" ? "fish" : searchTerm)&page=\(pageNumberStart)")
//
//        let task = URLSession.shared.dataTask(with: URLRequest(url: url!)) { data, reponse, error in
//            if let data = data {
//
//                do {
//                    let html: String = String(data: data, encoding: .utf8)!
//                    let doc: Document = try SwiftSoup.parse(html)
//                    guard let body = doc.body() else { return }
//
//                    let rl = try body.select("div.rl")
//
//                    let list = try rl.select("a[href]")
//
//                    let pageStop = try body.select("li.last").select("a").attr("title").replacingOccurrences(of: "Page ", with: "")
//
//        //            print("Page Stop : \(pageStop)")
//
//                    self.pageNumberStop = Int(pageStop) ?? 1
//
//        //            print("Page number Stop : \(pageNumberStop)")
//
//                    DispatchQueue.main.async {
//                        self.fishes.removeAll()
//                    }
//
//
//                    for item in list {
//                        let commonEnglishName = try item.select("div.common").text()
//                        let scientificName = try item.select("div.science").text()
//                        let familyName = try item.select("div.family").text()
//                        let imageURL = try item.select("img").attr("src")
//                        let articleURL = try item.attr("class", "science").attr("href")
//
//        //                print(commonEnglishName)
//
//                        let fish = Fish(commonEnglishName: commonEnglishName, scientificName: scientificName, familyName: familyName, imageURL: self.baseURL+imageURL, articleURL: articleURL)
//
//                        DispatchQueue.main.async {
//                            self.fishes.append(fish)
//                        }
//                    }
//                }
//                catch let Exception.Error(type: type, Message: message) {
//                    print(type)
//                    print(message)
//                }
//                catch {
//                    print(error)
//                }
//            }
//        }
//        task.resume()
//
//    }
//
//    func getMoreFish(_ searchTerm: String) {
//        if pageNumberStart < pageNumberStop {
//            pageNumberStart += 1
//        }
//        else {
//            return
//        }
//
//        let url = URL(string: baseURL+"/v4/search?&q=\(searchTerm == "" ? "fish" : searchTerm)&page=\(pageNumberStart)")
//
//
//        let task = URLSession.shared.dataTask(with: URLRequest(url: url!)) { data, reponse, error in
//            if let data = data {
//                do {
//                    let html = String(data: data, encoding: .utf8)!
//                    let doc: Document = try SwiftSoup.parse(html)
//                    guard let body = doc.body() else { return }
//
//                    let rl = try body.select("div.rl")
//
//                    let list = try rl.select("a[href]")
//
//                    let pageStop = try body.select("li.last").select("a").attr("title").replacingOccurrences(of: "Page ", with: "")
//
//        //            print("Page Stop : \(pageStop)")
//
//                    self.pageNumberStop = Int(pageStop) ?? 1
//
//        //            print("Page number Stop : \(pageNumberStop)")
//
//
//                    for item in list {
//                        let commonEnglishName = try item.select("div.common").text()
//                        let scientificName = try item.select("div.science").text()
//                        let familyName = try item.select("div.family").text()
//                        let imageURL = try item.select("img").attr("src")
//                        let articleURL = try item.attr("class", "science").attr("href")
//
//
//                        let fish = Fish(commonEnglishName: commonEnglishName, scientificName: scientificName, familyName: familyName, imageURL: self.baseURL+imageURL, articleURL: articleURL)
//
//                        DispatchQueue.main.async {
//                            self.fishes.append(fish)
//                        }
//                    }
//                }
//                catch let Exception.Error(type: type, Message: message) {
//                    print(type)
//                    print(message)
//                }
//                catch {
//                    print(error)
//                }
//
//            }
//        }
//
//        task.resume()
//
//    }
}
