//
//  FishCardView.swift
//  Fisherman's Keeper
//
//  Created by Aman Bind on 06/10/23.
//

import AlertToast
import CachedAsyncImage
import SwiftData
import SwiftUI

// A view representing a fish card with options to add to the user's list
struct FishCardView: View {
    // The fish data to be displayed
    var fish: Fish
    
    @Environment(\.modelContext) var context

    // State variables for sheet presentation, count & alert
    @State var isAddFishPresented: Bool = false
    @State var fishCount: Int = 0
    @State var showAlert: Bool = false
    
    // Binding for checking if the fish is already added
    @Binding var isAlreadyAdded: Bool
    @Binding var isAddedSuccessfully: Bool
    
    // Query for fetching fish data
    @Query var fishes: [FishData]
    
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
                        ProgressView()
                            .scaleEffect(CGSize(width: 2.0, height: 2.0), anchor: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)
                            .frame(width: UIScreen.main.bounds.width-35, height: 200)
                    }
                    
                    Button(action: {
                        // Checking if this fish is already added in Persistence Storage
                        for fishData in fishes {
                            if fishData.scientificName == fish.scientificName {
                                isAlreadyAdded.toggle()
                                return
                            }
                        }
                        
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
                    .buttonStyle(BorderlessButtonStyle())
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
            .background(.thickMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
        .sheet(isPresented: $isAddFishPresented, content: {
            AddNewFishView(fish: fish, isAddedSuccessfully: $isAddedSuccessfully)
            
        })
        .padding(.top, 8)
    }
}

//#Preview {
//    FishCardView(fish: FishPreviewProvider.fish, isAlreadyAdded: .constant(false), isAddedSuccessfully: .constant(false))
//}
