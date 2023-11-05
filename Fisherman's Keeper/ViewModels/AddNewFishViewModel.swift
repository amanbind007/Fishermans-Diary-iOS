//
//  AddNewFishViewModel.swift
//  Fisherman's Keeper
//
//  Created by Aman Bind on 21/10/23.
//

import Foundation
import SwiftData

class AddNewFishViewModel: ObservableObject {
    @Published var hasCustomTitle: Bool = false
    @Published var hasNote: Bool = false
    @Published var customTitle: String?
    @Published var note: String?
    @Published var hasFishCount: Bool = false
    @Published var fishCount: Int = 0
    
    var imageData = Data()

    func saveFish(fish: Fish, context: ModelContext) {
        if !hasCustomTitle {
            customTitle = nil
        }
        if !hasNote {
            note = nil
        }
        
        
        let imageTask = URLSession.shared.dataTask(with: URLRequest(url: URL(string: fish.imageURL)!)) { data, _, _ in
            guard let data = data else { return }
            
            print(data.debugDescription)
            self.imageData = data
        }
        imageTask.resume()

        let fishData = FishData(scientificName: fish.scientificName, commonName: fish.commonEnglishName, familyName: fish.familyName, note: note, title: customTitle, count: fishCount, articleURL: fish.articleURL, imageData: imageData, imageURL: fish.imageURL, dateTime: Date().timeIntervalSince1970, hasTitle: hasCustomTitle, hasNote: hasNote, hasCount: hasFishCount)

        context.insert(fishData)

        print()
        do {
            try context.save()
            print("added to persistence storage")
        } catch {
            print(error.localizedDescription)
        }
    }
}
