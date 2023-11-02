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
    
    var pageConfig : PageConfig

    @Published var fishes = [Fish]()

    var htmlScraperUtility : HTMLScraperUtility
    
    var cancellableTask: AnyCancellable? = nil
    
    init() {
        self.pageConfig = PageConfig()
        self.htmlScraperUtility = HTMLScraperUtility(pageConfig: pageConfig)
    }
    
    func getFish(_ searchTerm: String) {
        fishes = []
        pageConfig.resetPageCount()
        guard let url = URL(string: baseURL + "/v4/search?&q=\(searchTerm == "" ? "fish" : searchTerm)&page=\(pageConfig.pageNumberStart)") else { return }
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

        if pageConfig.canLoadMore() { return }
        pageConfig.incrementCurrentPage()

        guard let url = URL(string: baseURL + "/v4/search?&q=\(searchTerm == "" ? "fish" : searchTerm)&page=\(pageConfig.pageNumberStart)") else { return }
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
