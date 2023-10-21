//
//  MyFishListView.swift
//  Fisherman's Keeper
//
//  Created by Aman Bind on 07/10/23.
//

import SwiftUI
import SwiftData

struct MyFishListView: View {
    
    @Query var fishData : [FishData]
    var body: some View {
        VStack{
            ForEach(fishData, id: \.scientificName) { fish in
                Text(fish.scientificName)
            }
        }
    }
}

#Preview {
    MyFishListView()
}
