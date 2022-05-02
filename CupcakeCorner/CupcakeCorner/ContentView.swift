//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Brian Foshee on 1/5/22.
//

import SwiftUI

struct ContentView: View {
    // the one place this data is created and stored. all other views will be
    // passed this object.
    @StateObject var orderWrapper = OrderWrapper()

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $orderWrapper.order.type) {
                        ForEach(Order.types.indices, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }

                    Stepper("Number of cakes \(orderWrapper.order.quantity)", value: $orderWrapper.order.quantity)
                }

                Section {
                    // .animation here so that upon changing the other two toggles smoothly
                    // animate in and out.
                    Toggle("Any special requests?", isOn: $orderWrapper.order.specialRequestEnabled.animation())

                    if orderWrapper.order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $orderWrapper.order.extraFrosting)

                        Toggle("Add extra sprinkles", isOn: $orderWrapper.order.addSprinkles)
                    }
                }

                Section {
                    NavigationLink {
                        AddressView(orderWrapper: orderWrapper)
                    } label: {
                        Text("Delivery Details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
