//
//  FishCardView.swift
//  Fisherman's Keeper
//
//  Created by Aman Bind on 06/10/23.
//

import SwiftUI

struct FishCardView: View {
    var body: some View {
        VStack{
            
            AsyncImage(url: URL(string: "link to image")) { image in
                image
                    .cornerRadius(10)
            } placeholder: {
                Image("fishPlaceholder", bundle: Bundle(path: "Assets"))
                    .cornerRadius(10)
            }

            
            Text("Fish Name")
                .font(.body)
            
        }
        .padding(5)
        .background(.pink)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    FishCardView()
}
