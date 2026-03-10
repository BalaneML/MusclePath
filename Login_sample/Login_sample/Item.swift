//
//  Item.swift
//  Login_sample
//
//  Created by a2lab on 2026/02/14.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
