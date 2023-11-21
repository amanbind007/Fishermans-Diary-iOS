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

// This class handles the interaction with the FishBase search page to search for fishes
class FishSearchViewModel: ObservableObject {

    // Published property to update the UI when fishes change
    @Published var fishes = [Fish]()
    
    // Observing changes in the properties defined in HTMLScraperUtility
    // i.e., current page & total page for infinite scrolling
    @ObservedObject var htmlScraperUtility = HTMLScraperUtility()

    var cancellableTask: AnyCancellable? = nil

    // Published property to track the loading state
    @Published var isLoading: Bool = false
    
    // Function to get fishes based on search term and sorting order
    func getFish(for searchTerm: String, sortOrder: FishFilterOption) {
        fishes = [] // Emptying array for new fish search
        htmlScraperUtility.currentPage = 1
        htmlScraperUtility.totalPage = 1

        // setting users sort selection
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
        isLoading = true
        cancellableTask = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data) // extract Data() from tuple
            .flatMap(htmlScraperUtility.scrapArticle(from:)) // scraping fishes from Data()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in
                // Completion handler, update isLoading
                self.isLoading = false
            }, receiveValue: { [unowned self] fishes in
                // Value handler, update the fishes array
                self.fishes = fishes
            })
    }

    // Function to get more fishes for infinite scrolling
    func getMoreFish(for searchTerm: String, sortOrder: FishFilterOption) {
        
        // Checking if current page has crossed the total
        // number of page else increment the current page by 1
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
        isLoading = true
        cancellableTask = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data) // extract Data() from tuple
            .flatMap(htmlScraperUtility.scrapArticle(from:)) // scraping fishes from Data()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in
                // Completion handler, update isLoading
                self.isLoading = false
            }, receiveValue: { [unowned self] fishes in
                // Value handler, append more fishes to the existing array
                self.fishes.append(contentsOf: fishes)
            })
    }
}
