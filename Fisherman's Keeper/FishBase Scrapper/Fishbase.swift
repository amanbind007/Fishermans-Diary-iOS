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

    @Published var fishes = [Fish]()

    @ObservedObject var htmlScraperUtility = HTMLScraperUtility()

    var cancellableTask: AnyCancellable? = nil

    func getFish(for searchTerm: String, sortOrder: FishSortOrder) {
        fishes = []
        htmlScraperUtility.currentPage = 1
        htmlScraperUtility.totalPage = 1

        var sortOrderString: String
        switch sortOrder {
        case .relevance:
            sortOrderString = "relevance"
        case .scientificName:
            sortOrderString = "scientific"
        case .commonName:
            sortOrderString = "common"
        case .familyName:
            sortOrderString = "family"
        }

        guard let url = URL(string: Constants.Endpoints.BASEURL + "/v4/search?&q=\(searchTerm == "" ? "fish" : searchTerm)&page=\(htmlScraperUtility.currentPage)&sort=\(sortOrderString)") else { return }
        cancellableTask?.cancel()
        cancellableTask = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data) // extract Data() from tuple
            .flatMap(htmlScraperUtility.scrapArticle(from:))
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in
                // Action
                print("Get Fish : Stream received")
            }, receiveValue: { [unowned self] fishes in
                self.fishes = fishes
            })
    }

    func getMoreFish(for searchTerm: String, sortOrder: FishSortOrder) {
        if htmlScraperUtility.currentPage >= htmlScraperUtility.totalPage { return }

        htmlScraperUtility.currentPage += 1

        var sortOrderString: String
        switch sortOrder {
        case .relevance:
            sortOrderString = "relevance"
        case .scientificName:
            sortOrderString = "scientific"
        case .commonName:
            sortOrderString = "common"
        case .familyName:
            sortOrderString = "family"
        }

        guard let url = URL(string: Constants.Endpoints.BASEURL + "/v4/search?&q=\(searchTerm == "" ? "fish" : searchTerm)&page=\(htmlScraperUtility.currentPage)&sort=\(sortOrderString)") else { return }
        cancellableTask?.cancel()
        cancellableTask = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data) // extract Data() from tuple
            .flatMap(htmlScraperUtility.scrapArticle(from:))
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in
                // Action
                print("More Fish : Stream received")
            }, receiveValue: { [unowned self] fishes in
                self.fishes.append(contentsOf: fishes)
            })
    }
}
