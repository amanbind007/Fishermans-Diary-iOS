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
    @Published var isAlreadyInMyLis: Bool = false
    
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
            
            self.imageData = data
            
            let fishData = FishData(id: UUID(), scientificName: fish.scientificName, commonName: fish.commonEnglishName, familyName: fish.familyName, note: self.note, title: self.customTitle, count: self.fishCount, articleURL: fish.articleURL, imageData: self.imageData, imageURL: fish.imageURL, dateTime: Date().timeIntervalSince1970, hasTitle: self.hasCustomTitle, hasNote: self.hasNote, hasCount: self.hasFishCount)
        
            context.insert(fishData)
            
            print()
            do {
                try context.save()
                print("added to persistence storage")
            } catch {
                print(error.localizedDescription)
            }
            
            
            
        }
        imageTask.resume()
        
    }
}
