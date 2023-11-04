//
//  FishCardView.swift
//  Fisherman's Keeper
//
//  Created by Aman Bind on 06/10/23.
//

import CachedAsyncImage
import SwiftData
import SwiftUI

struct FishCardView: View {
    var fish: Fish
    
    @Environment(\.modelContext) var context

    @State var isAddFishPresented: Bool = false
    @State var fishCount: Int = 0
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                ZStack {
                    CachedAsyncImage(url: URL(string: fish.imageURL)) { image in
                        image
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width-35, height: 200)
                            .cornerRadius(10)
                            
                    } placeholder: {
                        Image("fishPlaceholder", bundle: Bundle(path: "Assets"))
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width-35, height: 200)
                            .cornerRadius(10)
                    }
                        
                    Button(action: {
                        isAddFishPresented.toggle()
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding(2)
                            .background(Color.white)
                            .clipShape(Circle())
                            
                    })
                    .offset(CGSize(width: 154.0, height: -75.0))
                }
                    
                HStack {
                    Text(fish.scientificName)
                        .font(Font.custom("PTSerif-BoldItalic", size: 19))
                        .foregroundColor(.fishCardText)
                }
                .padding(.horizontal, 7)
                HStack {
                    Text(fish.commonEnglishName ?? "")
                        .font(Font.custom("PTSerif-Regular", size: 17))
                        .foregroundColor(.fishCardText)
                        
                    Spacer()
                    Text(fish.familyName)
                        .font(Font.custom("PTSerif-Regular", size: 15))
                        .foregroundColor(.primary)
                        .opacity(1.0)
                }
                .padding(.horizontal, 7)
            }
            .padding(5)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .shadow(color: .black, radius: 10)
        }
        .sheet(isPresented: $isAddFishPresented, content: {
            AddNewFishView(fish: fish)
            
        })
        .padding(.top, 8)
        .onAppear {
            print(fish.imageURL)
        }
    }
}

#Preview {
    FishCardView(fish: FishPreviewProvider.fish)
}
