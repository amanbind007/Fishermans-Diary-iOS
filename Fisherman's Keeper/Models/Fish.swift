//
//  Fish.swift
//  Fisherman's Keeper
//
//  Created by Aman Bind on 09/10/23.
//

import Foundation

struct Fist: Codable {
    let id: Int
    let name: String
    let url: String
    let img_src_set: ImageSet?
    let meta: Meta?
}

struct ImageSet: Codable{
    
    let x15: String?
    let x2: String?
    
    enum CodingKeys: String, CodingKey {
        case x15 = "1.5x"
        case x2 = "2x"
    }
}



struct Meta: Codable {
//    let conservation_status: String?
    //let scientific_classification: ScientificClassification?
//    let type_species: String?
//    let genera: String?
//    let species: String?
    let binomial_name: String?
//    let families: String?
    let synonyms: String?
//    let subfamiliesAndGenera: String?
//    enum CodingKeys: String, CodingKey {
//        case conservation_status, scientific_classification, type_species, binomial_name, synonyms, families, species, genera
//        case subfamiliesAndGenera = "subfamilies_&_genera"
//    }
    
}

//struct ScientificClassification: Codable {
//    let kingdom: String?
//    let phylum: String?
//    let _class: String?
//    let clade: String?
//    let superorder: String?
//    let order: String?
//    let suborder: String?
//    let superfamily: String?
//    let family: String?
//    let tribe: String?
//    let genus: String?
//    let subgenus: String?
//    let species: String?
//}
