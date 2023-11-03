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

class FishbaseSearch: ObservableObject {
    let baseURL = "https://www.fishbase.org.au"

    var fishes = [Fish]()

    @ObservedObject var htmlScraperUtility = HTMLScraperUtility()
    
    var cancellableTask: AnyCancellable? = nil
    
    func getFish(_ searchTerm: String) {
        fishes = []
        htmlScraperUtility.currentPage = 1
        htmlScraperUtility.totalPage = 1
        guard let url = URL(string: Constants.Endpoints.BASEURL + "search?&q=\(searchTerm == "" ? "fish" : searchTerm)&page=\(htmlScraperUtility.currentPage)") else { return }
        cancellableTask?.cancel()
        cancellableTask = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data) // extract Data() from tuple
            .flatMap(htmlScraperUtility.scrapArticle(from:))
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in
                // Action
            }, receiveValue: { [unowned self] fishes in
                self.fishes = fishes
            })
        
    }
    
    func getMoreFish(_ searchTerm: String) {
        print("FishBase: GetMore: Current -> \(htmlScraperUtility.currentPage)")
        print("ContentView: GetMore: Total ->  \(htmlScraperUtility.totalPage)")
        if htmlScraperUtility.currentPage >= htmlScraperUtility.totalPage { return }
        print("FishBase: GetMore: After check : Current -> \(htmlScraperUtility.currentPage)")
        print("ContentView: GetMore: After check : Total ->  \(htmlScraperUtility.totalPage)")
        
        htmlScraperUtility.currentPage += 1
        print("FishBase: GetMore: After check : After Increment: Current -> \(htmlScraperUtility.currentPage)")
        print("ContentView: GetMore: After check : After Increment: Total ->  \(htmlScraperUtility.totalPage)")

        guard let url = URL(string: Constants.Endpoints.BASEURL + "search?&q=\(searchTerm == "" ? "fish" : searchTerm)&page=\(htmlScraperUtility.currentPage)") else { return }
        cancellableTask?.cancel()
        cancellableTask = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data) // extract Data() from tuple
            .flatMap(htmlScraperUtility.scrapArticle(from:))
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in
                // Action
            }, receiveValue: { [unowned self] fishes in
                self.fishes.append(contentsOf: fishes)
            })
    }
}
