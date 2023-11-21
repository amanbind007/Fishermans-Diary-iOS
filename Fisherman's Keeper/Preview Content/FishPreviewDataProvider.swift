//
//  FishPreviewDataProvider.swift
//  Fisherman's Keeper
//
//  Created by Aman Bind on 23/10/23.
//

import Foundation
import UIKit

class FishDataPreviewProvider {
    static let fishData = FishData(id: UUID(), scientificName: "Acanthistius Pictus", commonName: "Brick seabass", familyName: "Serranoidei", note: "Kaddu Machli", title: "Kaddu Machli Desi", count: 5, articleURL: "https://www.fishbase.org.au/v4/summary/57960", imageData: UIImage(named: "fishPlaceholder")!.pngData()!, imageURL: "https://www.fishbase.org.au/v4/images/species/Acpic_u2.jpg", dateTime: Date().timeIntervalSince1970, hasTitle: true, hasNote: true, hasCount: true)

    static let fishData1 = FishData(id: UUID(), scientificName: "Myripristis amaena", commonName: "Brick soldierfish", familyName: "Holocentriformes", title: "Patli Machli", count: 0, articleURL: "https://www.fishbase.org.au/v4/summary/7773", imageData: UIImage(named: "fishPlaceholder")!.pngData()!, imageURL: "https://www.fishbase.org.au/v4/images/species/Myama_u6.jpg", dateTime: Date().timeIntervalSince1970, hasTitle: true, hasNote: false, hasCount: false)

    static let fishData2 = FishData(id: UUID(), scientificName: "Acanthistius Pictus", commonName: "Brick seabass", familyName: "Serranoidei", note: "Kaddu Machli", count: 5, articleURL: "https://www.fishbase.org.au/v4/summary/57960", imageData: UIImage(named: "fishPlaceholder")!.pngData()!, imageURL: "https://www.fishbase.org.au/v4/images/species/Acpic_u2.jpg", dateTime: Date().timeIntervalSince1970, hasTitle: false, hasNote: true, hasCount: true)

    static let fishDataList = [fishData, fishData1, fishData2]
}
