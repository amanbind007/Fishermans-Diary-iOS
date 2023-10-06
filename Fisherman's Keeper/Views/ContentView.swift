//
//  ContentView.swift
//  Fisherman's Keeper
//
//  Created by Aman Bind on 06/10/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            ScrollView {
                FishCardView()
            }
        }
    }
}

#Preview {
    ContentView()
}
