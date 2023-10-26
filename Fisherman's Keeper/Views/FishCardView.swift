//
//  FishCardView.swift
//  Fisherman's Keeper
//
//  Created by Aman Bind on 06/10/23.
//

import CachedAsyncImage
import SwiftUI
import SwiftData

struct FishCardView: View {
    var fish: Fish?

    var fishData: FishData?
    
    @Environment(\.modelContext) var context

    var isMyListView: Bool {
        if let _ = fishData {
            return true
        }
        return false
    }
    @State var isAddFishPresented: Bool = false
    @State var fishCount: Int = 0
    
    init(fish: Fish?, fishData: FishData?){
        if let fishData = fishData {
            fishCount = fishData.count
            self.fish = nil
            self.fishData = fishData
        }else{
            self.fish = fish
            self.fishData = nil
        }
        
    }
    
    
    
    func updateFishCount(context: ModelContext){
        if let fishData = fishData {
            fishData.count = fishCount
            
            do {
                try context.save()
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }

    var body: some View {
        
            ZStack {
                VStack(alignment: .leading) {
                    CachedAsyncImage(url: URL(string: isMyListView ? fishData!.imageURL : fish!.imageURL)) { image in
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
                    
                    if isMyListView {
                        VStack(alignment: .leading) {
                            Text("Custom Tile will be here ")
                                .font(Font.custom("PTSerif-Bold", size: 20))
                                .foregroundColor(.fishCardText)
                            Divider()
                        }
                        .padding(.horizontal, 7)
                    }
                    
                    HStack {
                        Text(isMyListView ? fishData!.scientificName : fish!.scientificName)
                            .font(Font.custom("PTSerif-BoldItalic", size: 19))
                            .foregroundColor(.fishCardText)
                    }
                    .padding(.horizontal, 7)
                    HStack {
                        Text(isMyListView ? (fishData?.commonName ?? "") : (fish?.commonEnglishName ?? ""))
                            .font(Font.custom("PTSerif-Regular", size: 17))
                            .foregroundColor(.fishCardText)
                        
                        Spacer()
                        Text(isMyListView ? (fishData?.familyName ?? "") : (fish?.familyName ?? ""))
                            .font(Font.custom("PTSerif-Regular", size: 15))
                            .foregroundColor(.primary)
                            .opacity(1.0)
                    }
                    .padding(.horizontal, 7)
                    
                    if isMyListView {
                        Divider()
                        HStack {
                            Stepper("Fish Count: \(fishCount)", value: $fishCount, in: 0 ... Int.max)
                        }
                        .onChange(of: fishCount, {
                            updateFishCount(context: context)
                        })
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
                    Image(systemName: isMyListView ? "square.and.pencil.circle.fill" : "plus.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(2)
                        .background(Color.white)
                        .clipShape(Circle())
                    
                })
                .offset(CGSize(width: 150.0, height: -105.0))
            }
            .sheet(isPresented: $isAddFishPresented, content: {
                
                if isMyListView {
                    UpdateFishView(fishData: fishData!)
                }
                else {
                    AddNewFishView(fish: fish!)
                }
                
                
            })
            .padding(.top, 8)
        }
}

#Preview {
    FishCardView(fish: FishPreviewProvider.fish, fishData: nil)
}
