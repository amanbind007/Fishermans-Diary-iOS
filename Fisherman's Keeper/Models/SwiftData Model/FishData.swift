//
//  FishData.swift
//  Fisherman's Keeper
//
//  Created by Aman Bind on 19/10/23.
//

import Foundation
import SwiftData
import SwiftUI

// This class represents persistent data for a Fish object
@Model
final class FishData {
    @Attribute(.unique) var id: UUID
    @Attribute(.unique) var scientificName: String
    var commonName: String?
    var familyName: String
    var note: String?
    var title: String?
    var count: Int
    var articleURL: String
    @Attribute(.externalStorage) var imageData : Data
    var imageURL: String
    var dateTime: Double
    var hasTitle: Bool
    var hasNote: Bool
    var hasCount: Bool

    // Initializer to create a FishData object
    init(id: UUID, scientificName: String, commonName: String? = nil, familyName: String, note: String? = nil, title: String? = nil, count: Int, articleURL: String, imageData: Data, imageURL: String, dateTime: Double, hasTitle: Bool, hasNote: Bool, hasCount: Bool) {
        self.id = id
        self.scientificName = scientificName
        self.commonName = commonName
        self.familyName = familyName
        self.note = note
        self.title = title
        self.count = count
        self.articleURL = articleURL
        self.imageData = imageData
        self.imageURL = imageURL
        self.dateTime = dateTime
        self.hasTitle = hasTitle
        self.hasNote = hasNote
        self.hasCount = hasCount
    }
}
