//
//  MyFishListView.swift
//  Fisherman's Keeper
//
//  Created by Aman Bind on 07/10/23.
//

import SwiftData
import SwiftUI

struct MyFishListView: View {
    @Query var fishData: [FishData]

    @State var searchText: String?
    var body: some View {
        NavigationStack {
            List {
                ForEach(fishData, id: \.scientificName) { fish in

                    MyFishListItemView(fishData: fish)
                }
                .onDelete(perform: { _ in
                    // perform
                })
            }
            .searchable(text: $searchText ?? "")
            .navigationTitle("My Fish List")
        }
    }
}

#Preview {
    MyFishListView()
}
