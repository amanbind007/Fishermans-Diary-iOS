//
//  NoInternetCardView.swift
//  Fisherman's Keeper
//
//  Created by Aman Bind on 10/11/23.
//

import SwiftUI

// A view to show if there is no internet Access
struct NoInternetCardView: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack {
            ZStack {
                if colorScheme == .dark {
                    Image("DarkBackground", bundle: Bundle(path: "Assets"))
                        .resizable()
                        .ignoresSafeArea()
                } else {
                    Image("LightBackground", bundle: Bundle(path: "Assets"))
                        .resizable()
                        .ignoresSafeArea()
                }

                VStack {
                    Image(systemName: "network.slash")
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 130, height: 130)

                    Text("It seems we're not connected to the Internet")
                        .multilineTextAlignment(.center)
                }
                .padding()
                .frame(width: 250, height: 250)

                .background(
                    Material.thin
                )
                .cornerRadius(20)
            }
        }
    }
}

#Preview {
    NoInternetCardView()
}
