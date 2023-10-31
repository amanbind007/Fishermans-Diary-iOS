//
//  MyFishListItemView.swift
//  Fisherman's Keeper
//
//  Created by Aman Bind on 31/10/23.
//

import CachedAsyncImage
import SwiftData
import SwiftUI

struct MyFishListItemView: View {
    var fishData: FishData
    
    @Environment(\.modelContext) var context
    @State var isUpdateFishPresented = false
    @State var fishCount: Int
    
    init(fishData: FishData) {
        self.fishCount = fishData.count
        self.fishData = fishData
    }
    
    func updateFishCount(context: ModelContext){
        fishData.count = fishCount
        
        context.insert(fishData)
        do {
            try context.save()
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    var body: some View {
        VStack {
            if fishData.hasTitle, let title = fishData.title {
                Text("\(title)")
                    .font(Font.custom("PTSerif-Bold", size: 20))
                    .foregroundColor(.fishCardText)
            }
            else {
                Text("\(fishData.scientificName)")
                    .font(Font.custom("PTSerif-Bold", size: 20))
                    .foregroundColor(.fishCardText)
            }
            
            ZStack {
                CachedAsyncImage(url: URL(string: fishData.imageURL)) { image in
                    image
                        .resizable()
                        .frame(height: 170)
                        .cornerRadius(10)
                } placeholder: {
                    Image("fishPlaceholder", bundle: Bundle(path: "Assets"))
                        .resizable()
                        .frame(height: 170)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    isUpdateFishPresented.toggle()
                }, label: {
                    Image(systemName: "square.and.pencil.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(2)
                        .background(Color.white)
                        .clipShape(Circle())
                        
                })
                .offset(CGSize(width: 133.0, height: -63.0))
            }
            .offset(CGSize(width: 0.0, height: -5.0))
            
            HStack {
                Text(fishData.scientificName)
                    .font(Font.custom("PTSerif-BoldItalic", size: 19))
                    .foregroundColor(.fishCardText)
                    
                Spacer()
            }
            HStack {
                Text(fishData.commonName ?? "")
                    .font(Font.custom("PTSerif-Regular", size: 17))
                    .foregroundColor(.fishCardText)
                    
                Spacer()
                Text(fishData.familyName)
                    .font(Font.custom("PTSerif-Regular", size: 15))
                    .foregroundColor(.primary)
                    .opacity(1.0)
            }
            
            Stepper("Fish Count: \(fishCount)", value: $fishCount, in: 0 ... Int.max)
        }
        .sheet(isPresented: $isUpdateFishPresented, content: {
            UpdateFishView(fishData: fishData)
        })
        .onChange(of: fishCount) {
            updateFishCount(context: context)
        }
    }
}

#Preview {
    MyFishListItemView(fishData: FishDataPreviewProvider.fishData1)
}
