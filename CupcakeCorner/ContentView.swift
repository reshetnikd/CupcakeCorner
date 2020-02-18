//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Dmitry Reshetnik on 15.02.2020.
//  Copyright © 2020 Dmitry Reshetnik. All rights reserved.
//

import SwiftUI

class OrderWrapper: ObservableObject, Codable {
    enum CodingKeys: CodingKey {
        case order
    }
    
    @Published var order = Order()
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(order, forKey: .order)
    }
    
    init() { }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        order = try container.decode(Order.self, forKey: .order)
    }
}

struct ContentView: View {
    @ObservedObject var wrappedOrder = OrderWrapper()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $wrappedOrder.order.type) {
                        ForEach(0..<Order.types.count, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper(value: $wrappedOrder.order.quantity, in: 3...20) {
                        Text("Number of cakes: \(wrappedOrder.order.quantity)")
                    }
                }
                
                Section {
                    Toggle(isOn: $wrappedOrder.order.specialRequestEnabled.animation()) {
                        Text("Any special requests?")
                    }
                    
                    if wrappedOrder.order.specialRequestEnabled {
                        Toggle(isOn: $wrappedOrder.order.extraFrosting) {
                            Text("Add extra frosting")
                        }
                        
                        Toggle(isOn: $wrappedOrder.order.addSprinkles) {
                            Text("Add extra sprinkles")
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: AddressView(wrappedOrder: wrappedOrder)) {
                        Text("Delivery details")
                    }
                }
            }
            .navigationBarTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
