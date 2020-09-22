//
//  UpdateStore.swift
//  DesignCode
//
//  Created by James Allan on 9/21/20.
//

import SwiftUI
import Combine


class UpdateStore: ObservableObject {
    
    @Published var updates: [Update] = updateData
}
