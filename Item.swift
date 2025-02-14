//
//  Item.swift
//  Lab1- Waisiman Maimaiti -101465611
//
//  Created by Family Vide on 2025-02-13.
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
