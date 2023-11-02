//
//  PageConfig.swift
//  Fisherman's Keeper
//
//  Created by Aman Bind on 01/11/23.
//

import Foundation

class PageConfig: ObservableObject {
    @Published var pageNumberStart: Int = 1
    @Published var pageNumberStop: Int = 1

    func incrementCurrentPage() {
        pageNumberStart += 1
    }
    
    func resetPageCount(){
        pageNumberStop = 1
        pageNumberStart = 1
    }
    
    

    func updatePageNumberStop(stopPage: Int) {
        pageNumberStop = 0
        pageNumberStop += stopPage
    }

    func canLoadMore() -> Bool {
        if pageNumberStart >= pageNumberStop {
            return false
        }
        else {
            return true
        }
    }
}
