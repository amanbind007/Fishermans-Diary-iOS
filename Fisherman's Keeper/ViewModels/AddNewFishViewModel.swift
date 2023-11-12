//
//  AddNewFishViewModel.swift
//  Fisherman's Keeper
//
//  Created by Aman Bind on 21/10/23.
//

import Foundation
import SwiftData

// View model for AddNewFishView
class AddNewFishViewModel: ObservableObject {
    // Published properties for tracking various form elements
    @Published var hasCustomTitle: Bool = false
    @Published var hasNote: Bool = false
    @Published var customTitle: String?
    @Published var note: String?
    @Published var hasFishCount: Bool = false
    @Published var fishCount: Int = 0
    @Published var isAlreadyInMyLis: Bool = false

    // Data for fish image
    var imageData = Data()

    // Function to save the new fish to Core Data
    func saveFish(fish: Fish, context: ModelContext) {
        if !hasCustomTitle {
            customTitle = nil
        }
        if !hasNote {
            note = nil
        }

        // Loading Fish image data from URL to save in persistence storage
        let imageTask = URLSession.shared.dataTask(with: URLRequest(url: URL(string: fish.imageURL)!)) { data, _, _ in
            guard let data = data else { return }

            self.imageData = data

            let fishData = FishData(id: UUID(), scientificName: fish.scientificName, commonName: fish.commonEnglishName, familyName: fish.familyName, note: self.note, title: self.customTitle, count: self.fishCount, articleURL: fish.articleURL, imageData: self.imageData, imageURL: fish.imageURL, dateTime: Date().timeIntervalSince1970, hasTitle: self.hasCustomTitle, hasNote: self.hasNote, hasCount: self.hasFishCount)

            // Inserting the fishData in persistence storage
            context.insert(fishData)

            // Manual saving for Confidence(not required)
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
        imageTask.resume()
    }
}
