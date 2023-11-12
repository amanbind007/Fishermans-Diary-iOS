//
//  File.swift
//  Fisherman's Keeper
//
//  Created by Aman Bind on 26/10/23.
//

import Foundation
import SwiftData

// View model for updating fish details
class UpdateFishViewModel: ObservableObject {
    // Published properties for tracking various form elements
    @Published var hasCustomTitle: Bool = false
    @Published var hasNote: Bool = false
    @Published var customTitle: String?
    @Published var note: String?
    @Published var hasFishCount: Bool = false
    @Published var fishCount: Int = 0

    // Fish data to be updated
    var fishData: FishData

    // Initializer
    init(fishData: FishData) {
        self.fishData = fishData
        self.hasCustomTitle = fishData.hasTitle
        self.hasNote = fishData.hasNote
        self.customTitle = fishData.title
        self.note = fishData.note
        self.hasFishCount = fishData.hasCount
        self.fishCount = fishData.count
    }

    // Function to update fish details
    func updateFish(context: ModelContext) {
        if !hasCustomTitle {
            customTitle = nil
        }
        if !hasNote {
            note = nil
        }

        fishData.title = customTitle
        fishData.hasTitle = hasCustomTitle
        fishData.note = note
        fishData.hasNote = hasNote
        fishData.hasCount = hasFishCount
        fishData.count = fishCount

        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
