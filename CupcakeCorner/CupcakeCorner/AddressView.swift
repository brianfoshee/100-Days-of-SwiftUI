//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Brian Foshee on 1/5/22.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order

    var body: some View {
        Text("hello")
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
