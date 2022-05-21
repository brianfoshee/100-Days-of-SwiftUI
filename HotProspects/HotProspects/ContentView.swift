//
//  ContentView.swift
//  HotProspects
//
//  Created by Brian Foshee on 20/5/22.
//

import SwiftUI
import UserNotifications


struct ContentView: View {
    @State private var backgroundColor = Color.red

    var body: some View {
        VStack {
            Button("Request Permission") {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set!")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }

            Button("Schedule Notification") {
                let content = UNMutableNotificationContent()
                content.title = "Feed the dog"
                content.subtitle = "It looks hungry"
                content.sound = UNNotificationSound.default

                // schedule for 5s in the future
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

                // choose a random identifier
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                // add the notifcation request
                UNUserNotificationCenter.current().add(request)
            }
        }
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
