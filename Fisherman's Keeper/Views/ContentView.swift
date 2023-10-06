//
//  ContentView.swift
//  Fisherman's Keeper
//
//  Created by Aman Bind on 06/10/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack{
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
            
        }
    }
}

#Preview {
    ContentView()
}
