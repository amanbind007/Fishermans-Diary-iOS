//
//  FishPreviewDataProvider.swift
//  Fisherman's Keeper
//
//  Created by Aman Bind on 23/10/23.
//

import Foundation

class FishDataPreviewProvider {
    static let fishData = FishData(scientificName: "Acanthistius Pictus", commonName: "Brick seabass", familyName: "Serranoidei", note: "Kaddu Machli", title: "Kaddu Machli Desi", count: 5, articleURL: "https://www.fishbase.org.au/v4/summary/57960", imageURL: "https://www.fishbase.org.au/v4/images/species/Acpic_u2.jpg", dateTime: Date().timeIntervalSince1970, hasTitle: true, hasNote: true, hasCount: true)

    static let fishData1 = FishData(scientificName: "Myripristis amaena", commonName: "Brick soldierfish", familyName: "Holocentriformes", title: "Patli Machli", count: 0, articleURL: "https://www.fishbase.org.au/v4/summary/7773", imageURL: "https://www.fishbase.org.au/v4/images/species/Myama_u6.jpg", dateTime: Date().timeIntervalSince1970, hasTitle: true, hasNote: false, hasCount: false)

    static let fishData2 = FishData(scientificName: "Acanthistius Pictus", commonName: "Brick seabass", familyName: "Serranoidei", note: "Kaddu Machli", count: 5, articleURL: "https://www.fishbase.org.au/v4/summary/57960", imageURL: "https://www.fishbase.org.au/v4/images/species/Acpic_u2.jpg", dateTime: Date().timeIntervalSince1970, hasTitle: false, hasNote: true, hasCount: true)

    static let fishDatas = [fishData, fishData1, fishData2]
}
