//
//  MyFishListView.swift
//  Fisherman's Keeper
//
//  Created by Aman Bind on 07/10/23.
//

import SwiftData
import SwiftUI

struct MyFishListView: View {
    @Environment(\.modelContext) var context

    @Query var fishData: [FishData]

    @State var searchText: String?
    @State private var selectedFish: FishData?

    var body: some View {
        NavigationStack {
            List(selection: $selectedFish) {
                ForEach(fishData, id: \.scientificName) { fish in

                    MyFishListItemView(fishData: fish)
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                context.delete(fish)
                                do {
                                    try context.save()
                                } catch {
                                    print(error.localizedDescription)
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }
            }
            .searchable(text: $searchText ?? "")
            .navigationTitle("My Fish List")
        }
    }
}

#Preview {
    MyFishListView()
}
