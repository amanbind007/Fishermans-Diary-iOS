//
//  FishCardView.swift
//  Fisherman's Keeper
//
//  Created by Aman Bind on 06/10/23.
//

import CachedAsyncImage
import SwiftUI

struct FishCardView: View {
    let fish: Fish

    let fishData: FishData?

    @State var isMyList: Bool = true
    @State var isAddFishPresented: Bool = false
    @State var fishCount: Int = 0

    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
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

                if isMyList {
                    VStack(alignment: .leading) {
                        Text("Custom Tile will be here ")
                            .font(Font.custom("PTSerif-Bold", size: 20))
                            .foregroundColor(.fishCardText)
                        Divider()
                    }
                    .padding(.horizontal, 7)
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

                if isMyList {
                    Divider()
                    HStack {
                        Stepper("Fish Count: \(fishCount)", value: $fishCount, in: 0 ... Int.max)
                    }
                    .padding(.horizontal, 7)
                }
            }
            .padding(5)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .shadow(color: .black, radius: 10)

            Button(action: {
                isAddFishPresented.toggle()
            }, label: {
                Image(systemName: isMyList ? "square.and.pencil.circle.fill" : "plus.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding(2)
                    .background(Color.white)
                    .clipShape(Circle())

            })
            .offset(CGSize(width: 150.0, height: -105.0))
        }
        .sheet(isPresented: $isAddFishPresented, content: {
            AddNewFishView(fish: fish)

        })
        .padding(.top, 8)
    }
}

#Preview {
    FishCardView(fish: FishPreviewProvider.fish, fishData: nil)
}
