//
//  File.swift
//  Fisherman's Keeper
//
//  Created by Aman Bind on 26/10/23.
//

import Foundation
import SwiftData

class UpdateFishViewModel: ObservableObject {
    @Published var hasCustomTitle: Bool = false
    @Published var hasNote: Bool = false
    @Published var customTitle: String?
    @Published var note: String?
    @Published var hasFishCount: Bool = false
    @Published var fishCount: Int = 0

    var fishData: FishData

    init(fishData: FishData) {
        self.fishData = fishData
        self.hasCustomTitle = fishData.hasTitle
        self.hasNote = fishData.hasNote
        self.customTitle = fishData.title
        self.note = fishData.note
        self.hasFishCount = fishData.hasCount
        self.fishCount = fishData.count
    }

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

        print()
        do {
            try context.save()
            print("added to persistence storage")
        } catch {
            print(error.localizedDescription)
        }
    }
}
