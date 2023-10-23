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
    
    @State var searchText: String?
    var body: some View {
        NavigationStack{
            ScrollView{
                LazyVGrid(columns: [GridItem()], content: {
                    ForEach(fishData, id: \.scientificName) { fish in
                        
                        FishCardView(fish: Fish(commonEnglishName: fish.commonName, scientificName: fish.scientificName, familyName: fish.familyName, imageURL: fish.imageURL, articleURL: fish.imageURL), fishData: fish)
                            .padding(.horizontal)
                        
                    }
                    .onDelete(perform: { indexSet in
                        //perform
                    })
                })
                .searchable(text: $searchText ?? "")
            }
            
        }
    }
}

#Preview {
    MyFishListView()
}
