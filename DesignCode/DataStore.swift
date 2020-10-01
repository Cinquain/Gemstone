//
//  DataStore.swift
//  DesignCode
//
//  Created by James Allan on 9/26/20.
//

import SwiftUI
import Combine




class DataStore: ObservableObject {
    
    @Published var posts: [Post] = []
    
    
    init() {
        getPost()
    }
    
    func getPost() {
        
        API().getPost { (posts) in
            self.posts = posts
        }
    }
    
}
