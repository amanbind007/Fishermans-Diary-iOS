//
//  MyFishListView.swift
//  Fisherman's Keeper
//
//  Created by Aman Bind on 07/10/23.
//

import AlertToast
import SwiftData
import SwiftUI

// enums for filter and sort options available
enum FilterOption {
    case keyword
    case title
    case note
    case familyName
    case scientificName
    case commonName
}

enum SortOption {
    case dateLowToHigh
    case dateHighToLow
    case AtoZ
    case ZtoA
}

// A view displaying the list of fishes owned by the user
struct MyFishListView: View {
    @Environment(\.modelContext) var context

    // Querying all the fishes from SwiftData
    @Query var fishData: [FishData]

    // Search String
    @State var searchText: String = ""

    // variables to store bool if an fish is deleted
    // or updated for the toast messages
    @State var isDeleted: Bool = false
    @State var isUpdated: Bool = false

    // tracking the selected filter and sorted option
    @State var selectedFilterOption: FilterOption = .keyword
    @State var selectedSortOption: SortOption = .dateHighToLow

    // Storing filtered and sorted fishes
    var filteredAndSortedFish: [FishData] {
        var filteredFish = fishData

        // Apply filter
        if !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            switch selectedFilterOption {
            case .keyword:
                filteredFish = fishData.filter { fish in
                    fish.scientificName.lowercased().contains(searchText.lowercased()) ||
                        fish.commonName?.lowercased().contains(searchText.lowercased()) == true ||
                        fish.familyName.lowercased().contains(searchText.lowercased()) ||
                        fish.note?.lowercased().contains(searchText.lowercased()) == true ||
                        fish.title?.lowercased().contains(searchText.lowercased()) == true
                }
            case .title:
                filteredFish = fishData.filter { fish in
                    fish.title?.lowercased().contains(searchText.lowercased()) == true
                }
            case .note:
                filteredFish = fishData.filter { fish in
                    fish.note?.lowercased().contains(searchText.lowercased()) == true
                }
            case .familyName:
                filteredFish = fishData.filter { fish in
                    fish.familyName.lowercased().contains(searchText.lowercased())
                }
            case .scientificName:
                filteredFish = fishData.filter { fish in
                    fish.scientificName.lowercased().contains(searchText.lowercased())
                }
            case .commonName:
                filteredFish = fishData.filter { fish in
                    fish.commonName?.lowercased().contains(searchText.lowercased()) == true
                }
            }
        }

        // Apply sort
        switch selectedSortOption {
        case .dateLowToHigh:
            filteredFish.sort { $0.dateTime < $1.dateTime }
        case .dateHighToLow:
            filteredFish.sort { $0.dateTime > $1.dateTime }
        case .AtoZ:
            filteredFish.sort { $0.scientificName < $1.scientificName }
        case .ZtoA:
            filteredFish.sort { $0.scientificName > $1.scientificName }
        }

        return filteredFish
    }

    var body: some View {
        NavigationStack {
            List {
                // Checking if list fishData is empty and showing the view based on it
                if fishData.isEmpty {
                    HStack(alignment: .center, content: {
                        VStack(alignment: .center) {
                            Image("Search")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 400, height: 170)

                            Text("Fish List is Empty!\nAdd some fishes.")
                                .multilineTextAlignment(.center)
                                .padding(20)
                        }

                    })
                }
                else {
                    // If After sorting and filtering the fishData based on 'search text',
                    // showing the relevent view to the user with message
                    if filteredAndSortedFish.isEmpty {
                        HStack(alignment: .center, content: {
                            VStack(alignment: .center) {
                                Image("Search")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 400, height: 170)

                                Text("No Fishes Found!\nTry changing filter options to keyword.")
                                    .multilineTextAlignment(.center)
                                    .padding(20)
                            }

                        })
                    }
                    else {
                        ForEach(filteredAndSortedFish, id: \.scientificName) { fish in

                            MyFishListItemView(fishData: fish, fishCount: fish.count, isUpdated: $isUpdated)
                                .swipeActions(edge: .trailing) {
                                    Button(role: .destructive) {
                                        // Deleting fish from persistence storage on swipe
                                        context.delete(fish)
                                        isDeleted.toggle()
                                        do {
                                            try context.save()
                                        }
                                        catch {
                                            print(error.localizedDescription)
                                        }
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                        }
                    }
                }
            }
            .toolbar(content: {
                // Filter Menu in toolbar
                ToolbarItem {
                    Menu("Filter", systemImage: "line.3.horizontal.decrease.circle") {
                        Picker(selection: $selectedFilterOption) {
                            Text("Keyword")
                                .tag(FilterOption.keyword)
                            Text("Title")
                                .tag(FilterOption.title)
                            Text("Scientific Name")
                                .tag(FilterOption.scientificName)
                            Text("Family Name")
                                .tag(FilterOption.familyName)
                            Text("Common Name")
                                .tag(FilterOption.commonName)
                            Text("Notes")
                                .tag(FilterOption.note)
                        } label: {
                            Text("Filter Options")
                        }
                    }
                }

                // Sort Menu in Tool bar
                ToolbarItem {
                    Menu("Sort", systemImage: "arrow.up.and.down.text.horizontal") {
                        Picker(selection: $selectedSortOption) {
                            Text("Date - High to Low")
                                .tag(SortOption.dateHighToLow)
                            Text("Date - Low to High")
                                .tag(SortOption.dateLowToHigh)
                            Text("A to Z (Scientific Name)")
                                .tag(SortOption.AtoZ)
                            Text("Z to A (Scientific Name)")
                                .tag(SortOption.ZtoA)
                        } label: {
                            Text("Sort Options")
                        }
                    }
                }
            })

            .searchable(text: $searchText)
            .navigationTitle("My Fish List")
        }
        .toast(isPresenting: $isDeleted) {
            AlertToast(displayMode: .banner(.pop), type: .complete(.green), title: "Deleted Successfully")
        }
        .toast(isPresenting: $isUpdated) {
            AlertToast(displayMode: .banner(.pop), type: .complete(.green), title: "Updated Successfully")
        }
    }
}

#Preview {
    MyFishListView()
}
