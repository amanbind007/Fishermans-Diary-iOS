//
//  FishCardView.swift
//  Fisherman's Keeper
//
//  Created by Aman Bind on 06/10/23.
//

import SwiftUI

struct FishCardView: View {
    var body: some View {
        ZStack{
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
            
            Button(action: {
                //action
            }, label: {
                Image(systemName: "plus.circle.fill")
                    .font(.title)
                    .foregroundColor(.mint)
            })
            .offset(x: 60.0, y: -76.0)
            
        }
        
    }
}

#Preview {
    FishCardView()
}
