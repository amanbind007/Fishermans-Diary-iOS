//
//  Fisherman_s_KeeperApp.swift
//  Fisherman's Keeper
//
//  Created by Aman Bind on 06/10/23.
//

import SwiftData
import SwiftUI

@main
struct Fisherman_s_KeeperApp: App {
    
    @StateObject var networkMonitor = NetworkMonitor()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(networkMonitor)
            // injecting network monitor to know internet availability in child views
            
        }
        .modelContainer(for: [FishData.self])
        // injecting model context
        
    }
}
