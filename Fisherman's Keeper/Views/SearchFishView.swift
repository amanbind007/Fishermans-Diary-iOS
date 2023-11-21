//
//  SearchFishView.swift
//  Fisherman's Keeper
//
//  Created by Aman Bind on 09/11/23.
//

import AlertToast
import SwiftUI

// Enum for users fish filter option
enum FishFilterOption {
    case relevance
    case scientificName
    case commonName
    case familyName
}


// This view handles the search functionality for fishes
struct SearchFishView: View {
    // Search String
    @State var searchText: String?

    @Environment(\.colorScheme) var colorScheme

    @StateObject var viewModel = FishSearchViewModel()

    @State private var scrollViewID = UUID()

    // stores users selected filter option
    @State var sortOrder: FishFilterOption = .relevance

    @State var isAlreadyAdded: Bool = false
    @State var isAddedSuccessfully: Bool = false

    private let adaptiveColumn = [
        GridItem()
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                // Display fishes in a LazyVGrid
                LazyVGrid(columns: adaptiveColumn, content: {
                    ForEach(viewModel.fishes, id: \.scientificName) { fish in
                        NavigationLink {
                            // Navigate to a WebView when a fish is selected
                            WebView(url: URL(string: fish.articleURL)!)
                                .navigationTitle(fish.scientificName)

                        } label: {
                            // Display a FishCardView for each fish
                            FishCardView(fish: fish, isAlreadyAdded: $isAlreadyAdded, isAddedSuccessfully: $isAddedSuccessfully)
                                .padding(.horizontal)

                        }.buttonStyle(.plain)
                    }

                    // Load more fishes if there are more pages
                    if viewModel.htmlScraperUtility.currentPage < viewModel.htmlScraperUtility.totalPage {
                        Color.clear
                            .onAppear {
                                viewModel.getMoreFish(for: searchText ?? "", sortOrder: sortOrder)
                            }
                    }
                    else {
                        // Display loading, no results, or end of results messages
                        if viewModel.isLoading {
                            Spacer(minLength: 150)
                            VStack {
                                ProgressView("Loading")
                                    .scaleEffect(1.5, anchor: .center)
                            }
                            .padding()
                            .frame(width: 170, height: 170)
                            .background(
                                Material.regular
                            )
                            .cornerRadius(20)
                        }
                        else if viewModel.fishes.isEmpty {
                            Spacer(minLength: 200)
                            VStack {
                                Image("NotFound")
                                    .resizable()
                                    .scaledToFit()
                                    .padding()
                                Text("No Results Found")
                                    .font(.subheadline)
                            }
                            .padding()
                            .frame(width: 170, height: 170)
                            .background(
                                Material.regular
                            )
                            .cornerRadius(20)
                        }
                        else {
                            Spacer()
                            Text("No More Results")
                                .font(.headline)
                                .padding()
                                .background {
                                    RoundedRectangle(cornerRadius: 30)
                                        .foregroundStyle(Material.thin)
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 35))
                            Spacer()
                        }
                    }

                })
            }
            .id(self.scrollViewID)
            .background {
                // Set the background based on color scheme
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
                // Add a filter option to the toolbar
                ToolbarItem {
                    Menu {
                        Picker(selection: $sortOrder, label: Text("Filter options")) {
                            Text("Relevance").tag(FishFilterOption.relevance)
                            Text("Scientific Name").tag(FishFilterOption.scientificName)
                            Text("Common Name").tag(FishFilterOption.commonName)
                            Text("Family Name").tag(FishFilterOption.familyName)
                        }
                    }
                    label: {
                        Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
                    }
                }
            }
        }

        .onSubmit(of: .search) {
            scrollViewID = UUID()
            viewModel.getFish(for: searchText ?? "", sortOrder: sortOrder)
        }
        .onChange(of: sortOrder) {
            viewModel.getFish(for: searchText ?? "", sortOrder: sortOrder)
        }
        .onAppear(perform: {
            viewModel.getFish(for: searchText ?? "", sortOrder: sortOrder)
        })
        .toast(isPresenting: $isAlreadyAdded) {
            AlertToast(displayMode: .banner(.pop), type: .error(.red), title: "Already Added")
        }
        .toast(isPresenting: $isAddedSuccessfully) {
            AlertToast(displayMode: .banner(.pop), type: .complete(.green), title: "Added Successfully")
        }
    }
}

#Preview {
    SearchFishView()
}
