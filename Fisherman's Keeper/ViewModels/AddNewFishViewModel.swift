//
//  AddNewFishViewModel.swift
//  Fisherman's Keeper
//
//  Created by Aman Bind on 21/10/23.
//

import Foundation

class AddNewFishViewModel: ObservableObject {
    
    @Published var hasCustomTitle: Bool = false
    @Published var hasNote: Bool = false
    @Published var customTitle: String?
    @Published var note: String?
    @Published var hasFishCount: Bool = false
    @Published var fishCount: Int = 0
    
    func saveFish(fish: Fish) {
        
        hasCustomTitle = customTitle != nil
        hasNote = note != nil
        
        let fishData: FishData = FishData(scientificName: fish.scientificName, commonName: fish.commonEnglishName, familyName: fish.familyName, note: note, title: customTitle, count: fishCount, articleURL: fish.articleURL, imageURL: fish.imageURL, dateTime: Date().timeIntervalSince1970, hasTitle: hasCustomTitle, hasNote: hasNote, hasCount: hasFishCount)
        
        do{
            try fishData.modelContext?.save()
        }
        catch{
            print(error.localizedDescription)
        }
        
        
    }
}
