//
//  HappyFoodDeliveryAppApp.swift
//  HappyFoodDeliveryApp
//
//  Created by Khin Yadanar Thein on 27/10/2020.
//

import SwiftUI

@main
struct HappyFoodDeliveryAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
