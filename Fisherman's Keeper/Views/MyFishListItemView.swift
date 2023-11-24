//
//  MyFishListItemView.swift
//  Fisherman's Keeper
//
//  Created by Aman Bind on 31/10/23.
//

import CachedAsyncImage
import SwiftData
import SwiftUI

// A view representing an item in the user's fish list
struct MyFishListItemView: View {
    
    // Fish data to be displayed
    var fishData: FishData
    
    @Environment(\.modelContext) var context
    
    @State var isUpdateFishPresented = false
    @State var fishCount: Int
    
    @Binding var isUpdated: Bool
    
    // Function to update fish count in persistence storage
    func updateFishCount(context: ModelContext) {
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
                    .font(Font.custom(Constants.Fonts.PTSerifBold, size: 20))
                    .foregroundColor(.fishCardText)
            }
            else {
                Text("\(fishData.scientificName)")
                    .font(Font.custom(Constants.Fonts.PTSerifBold, size: 20))
                    .foregroundColor(.fishCardText)
            }
            
            ZStack {
                
                Image(uiImage: UIImage(data: fishData.imageData) ?? UIImage(named: "fishPlaceholder")!)
                    .resizable()
                    .frame(height: 170)
                    .cornerRadius(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 2.0)
                            .foregroundStyle(Color.fishCardText)
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
                .buttonStyle(BorderlessButtonStyle())
            }
            .offset(CGSize(width: 0.0, height: -5.0))
            
            HStack {
                Text(fishData.scientificName)
                    .font(Font.custom(Constants.Fonts.PTSerifBoldItalic, size: 19))
                    .foregroundColor(.fishCardText)
                    
                Spacer()
            }
            HStack {
                Text(fishData.commonName ?? "")
                    .font(Font.custom(Constants.Fonts.PTSerifRegular, size: 17))
                    .foregroundColor(.fishCardText)
                    
                Spacer()
                Text(fishData.familyName)
                    .font(Font.custom(Constants.Fonts.PTSerifRegular, size: 15))
                    .foregroundColor(.primary)
                    .opacity(1.0)
            }
            if let note = fishData.note {
                Divider()
                HStack {
                    Text("NOTE: \(note)")
                        .font(Font.custom(Constants.Fonts.PTSerifRegular, size: 15))
                        .foregroundColor(.primary)
                    
                    Spacer()
                }
                Divider()
            }
            
            if fishData.hasCount {
                Stepper("Fish Count: \(fishCount)", value: $fishCount, in: 0 ... Int.max)
            }
        }
        .sheet(isPresented: $isUpdateFishPresented, content: {
            UpdateFishView(fishData: fishData, viewModel: UpdateFishViewModel(fishData: fishData), isUpdated: $isUpdated)
        })
        .onChange(of: fishCount) {
            updateFishCount(context: context)
        }
    }
}

//#Preview {
//    MyFishListItemView(fishData: FishDataPreviewProvider.fishData1, fishCount: 10, isUpdated: .constant(false))
//}
