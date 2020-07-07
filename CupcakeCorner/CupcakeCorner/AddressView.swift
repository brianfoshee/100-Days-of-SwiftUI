//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Brian Foshee on 6/7/20.
//  Copyright © 2020 Brian Foshee. All rights reserved.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order

    var body: some View {
        Text("Hello, World!")
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
