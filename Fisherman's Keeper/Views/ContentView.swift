//
//  ContentView.swift
//  Fisherman's Keeper
//
//  Created by Aman Bind on 06/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var searchText : String  = ""
    
    var body: some View {
        NavigationStack{
            
            TabView{
                
                VStack{
                    ScrollView {
                        Grid{
                            HStack{
                                FishCardView()
                                FishCardView()
                            }
                            
                        }
                        
                    }
                }
                
                
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search Fish")
                }
                
                MyFishListView()
                    .tabItem {
                        Image(systemName: "fish")
                        Text("My Fish List")
                        
                    }
                
                
                    
                
                
            }
            .searchable(text: $searchText)
            .navigationTitle("Search Fish")
        }
    }
}

#Preview {
    ContentView()
}
