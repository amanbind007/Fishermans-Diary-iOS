//
//  FishData.swift
//  Fisherman's Keeper
//
//  Created by Aman Bind on 19/10/23.
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class FishData {
    @Attribute(.unique) var scientificName: String
    var commonName: String?
    var familyName: String
    var note: String?
    var title: String?
    var count: Int?
    var hasTitle: Bool = false
    var articleURL: String
    @Attribute(.externalStorage) var imageData: Data?
    var dateTime: Double
    
    init(scientificName: String, commonName: String? = nil, familyName: String, note: String? = nil, title: String? = nil, count: Int? = nil, hasTitle: Bool, articleURL: String, imageData: Data? = nil, dateTime: Double = Date().timeIntervalSince1970) {
        self.scientificName = scientificName
        self.commonName = commonName
        self.familyName = familyName
        self.note = note
        self.title = title
        self.count = count
        self.hasTitle = hasTitle
        self.articleURL = articleURL
        self.imageData = imageData
        self.dateTime = dateTime
    }
}
