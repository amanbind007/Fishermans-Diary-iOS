//
//  AddNewFishView.swift
//  Fisherman's Keeper
//
//  Created by Aman Bind on 19/10/23.
//

import SwiftData
import SwiftUI

struct AddNewFishView: View {
    var fish: Fish
    
    @Environment(\.dismiss) var dismiss
    @State var hasCustomTitle: Bool = false
    @State var customTitle: String = ""
    
    var body: some View {
        NavigationStack {
            Form(content: {
                Section {
                    HStack {
                        Text("Current Title: ")
                        Text(fish.scientificName!)
                    }
                    
                    if let commonName = fish.commonEnglishName {
                        HStack {
                            Text("Common English Name: ")
                            Text(commonName)
                        }
                    }
                    HStack {
                        Text("Current Title: ")
                        Text(fish.familyName!)
                    }
                    HStack {
                        Toggle("Add Custom Title", isOn: $hasCustomTitle)
                    }
                    
                    if hasCustomTitle {
                        HStack {
                            TextField("Your Title", text: $customTitle)
                        }
                    }
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
