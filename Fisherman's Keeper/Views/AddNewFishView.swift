//
//  AddNewFishView.swift
//  Fisherman's Keeper
//
//  Created by Aman Bind on 19/10/23.
//

import CachedAsyncImage
import SwiftData
import SwiftUI

struct AddNewFishView: View {
    var fish: Fish
    
    @Environment(\.dismiss) var dismiss
    @State var hasCustomTitle: Bool = false
    @State var hasNote: Bool = false
    @State var customTitle: String = ""
    @State var note: String = ""
    @State var hasFishCount: Bool = false
    @State var fishCount: Int = 0

    var body: some View {
        NavigationStack {
            Form(content: {
                Section {
                    HStack(alignment: .top) {
                        Text(fish.scientificName!)
                            .frame(alignment: .leading)
                        Spacer()
                        
                        CachedAsyncImage(url: URL(string: fish.imageURL!)) { image in
                            image
                                .resizable()
                                .cornerRadius(10)
                                
                        } placeholder: {
                            Image("fishPlaceholder", bundle: Bundle(path: "Assets"))
                                .resizable()
                                .cornerRadius(10)
                        }
                        .frame(width: 120, height: 80)
                    }
                    
                } header: {
                    Text("Current Title")
                        .font(.caption)
                }
                
                Section {
                    HStack {
                        Text(fish.scientificName!)
                            .font(Font.custom("PTSerif-BoldItalic", size: 20))
                    }
                    if let commonName = fish.commonEnglishName {
                        HStack {
                            Text(commonName)
                                .font(Font.custom("PTSerif-Regular", size: 17))
                        }
                    }
                    HStack {
                        Text(fish.familyName!)
                            .font(Font.custom("PTSerif-Regular", size: 15))
                    }
                } header: {
                    Text("Scientific Name, Common English Name, Family Name")
                        .font(.caption)
                }
                
                Section {
                    HStack {
                        Toggle("Add Custom Title", isOn: $hasCustomTitle)
                    }
                    if hasCustomTitle {
                        HStack {
                            TextField("Your Title", text: $customTitle)
                        }
                    }
                    
                    HStack {
                        Toggle("Add Note", isOn: $hasNote)
                    }
                    if hasNote {
                        HStack {
                            TextField("Enter Note", text: $note)
                                .lineLimit(3)
                        }
                    }
                    
                    HStack {
                        Toggle("Add Fish Count", isOn: $hasFishCount)
                    }
                    if hasFishCount {
                        HStack {
                            Stepper("Fish Count: \(fishCount)", value: $fishCount, in: 0 ... Int.max)
                        }
                    }
                        
                } header: {
                    Text("Title and Note")
                        .font(.caption)
                }
                
            })
            .navigationTitle(fish.scientificName!)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("Cancel")
                    })
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        // Add Save Functionality
                        
                        dismiss()
                    }, label: {
                        Text("Save")
                        
                    })
                }
            })
        }
    }
}

#Preview {
    NavigationStack {
        AddNewFishView(fish: FishPreviewProvider.fish)
    }
}
