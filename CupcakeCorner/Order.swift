//
//  Order.swift
//  CupcakeCorner
//
//  Created by Dmitry Reshetnik on 16.02.2020.
//  Copyright © 2020 Dmitry Reshetnik. All rights reserved.
//

import Foundation

class Order: ObservableObject {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    @Published var type = 0
    @Published var quantity = 3
    
    
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    @Published var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
}
