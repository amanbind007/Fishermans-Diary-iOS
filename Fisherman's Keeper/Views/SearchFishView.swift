//
//  SearchFishView.swift
//  Fisherman's Keeper
//
//  Created by Aman Bind on 09/11/23.
//

import SwiftUI

enum FishSortOrder {
    case relevance
    case scientificName
    case commonName
    case familyName
}

struct SearchFishView: View {
    @State var searchText: String?

    @Environment(\.colorScheme) var colorScheme

    @StateObject var fishbase = FishbaseSearch()

    @State private var scrollViewID = UUID()

    @State var sortOrder: FishSortOrder = .relevance

    private let adaptiveColumn = [
        GridItem()
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: adaptiveColumn, content: {
                    ForEach(fishbase.fishes, id: \.scientificName) { fish in
                        NavigationLink {
                            WebView(url: URL(string: fish.articleURL)!)
                                .navigationTitle(fish.scientificName)

                        } label: {
                            FishCardView(fish: fish)
                                .padding(.horizontal)

                        }.buttonStyle(.plain)
                    }

                    if fishbase.htmlScraperUtility.currentPage < fishbase.htmlScraperUtility.totalPage {
                        Color.clear
                            .onAppear {
                                fishbase.getMoreFish(for: searchText ?? "", sortOrder: sortOrder)
                            }

                    } else {
                        Spacer()
                        Text("No More Results")
                            .font(.headline)
                            .foregroundStyle(Color.white)
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 30)
                                    .background(Material.regular)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 35))
                        Spacer()
                    }

                })
            }
            .id(self.scrollViewID)
            .background {
                let darkBackground = Image("DarkBackground", bundle: Bundle(path: "Assets"))
                    .resizable()
                    .ignoresSafeArea()
                let lightBackground = Image("LightBackground", bundle: Bundle(path: "Assets"))
                    .resizable()
                    .ignoresSafeArea()

                colorScheme == .dark ? darkBackground : lightBackground
            }
            .navigationTitle("Search Fish")
            .searchable(text: $searchText ?? "", prompt: Text("Enter Fish Name"))
            .autocorrectionDisabled()

            .toolbar {
                ToolbarItem {
                    Menu {
                        Picker(selection: $sortOrder, label: Text("Sorting options")) {
                            Text("Relevance").tag(FishSortOrder.relevance)
                            Text("Scientific Name").tag(FishSortOrder.scientificName)
                            Text("Common Name").tag(FishSortOrder.commonName)
                            Text("Family Name").tag(FishSortOrder.familyName)
                        }
                    }
                    label: {
                        Label("Sort", systemImage: "arrow.up.arrow.down")
                    }
                }
            }
        }

        .onSubmit(of: .search) {
            scrollViewID = UUID()
            fishbase.getFish(for: searchText ?? "", sortOrder: sortOrder)
        }
        .onChange(of: sortOrder) {
            fishbase.getFish(for: searchText ?? "", sortOrder: sortOrder)
        }
        .onAppear(perform: {
            fishbase.getFish(for: searchText ?? "", sortOrder: sortOrder)
        })
    }
}

#Preview {
    SearchFishView()
}
