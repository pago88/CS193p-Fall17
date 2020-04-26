//
//  Card.swift
//  Set
//
//  Created by poltz on 4/24/20.
//  Copyright © 2020 Choo Choo Inc. All rights reserved.
//

import Foundation

struct Card {
    
    let shape: Int
    let number: Int
    let shading: Int
    let color: Int
    
    init(shape: Int, number: Int, shading: Int, color: Int) {
        self.shape = shape
        self.number = number
        self.shading = shading
        self.color = color
    }
    
}
