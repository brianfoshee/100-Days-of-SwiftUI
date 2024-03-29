//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Brian Foshee on 1/5/22.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var orderWrapper: OrderWrapper

    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false

    @State private var errorMessage = ""
    @State private var showingError = false

    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .accessibilityHidden(true)

                } placeholder: {
                    ProgressView()
                        .accessibilityHidden(true)
                }
                .frame(height: 233)

                Text("Your total is \(orderWrapper.order.cost, format: .currency(code: "USA"))")
                    .font(.title)

                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                    .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Thank You!", isPresented: $showingConfirmation) {
            Button("OK") { }
        } message: {
            Text(confirmationMessage)
        }
        .alert("Sorry, an error occurred", isPresented: $showingError) {
            Button("OK") { }
        } message: {
            Text(errorMessage)
        }
    }

    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(orderWrapper.order) else {
            print("failed to encode order")
            return
        }

        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"

        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
        } catch {
            print("error uploading data")
            errorMessage = "there was an error making your request"
            showingError = true
        }
    }

}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(orderWrapper: OrderWrapper())
    }
}
