//
//  HappyFoodDeliveryAppApp.swift
//  HappyFoodDeliveryApp
//
//  Created by Khin Yadanar Thein on 27/10/2020.
//

import SwiftUI
import Firebase
import CoreData

@main
struct HappyFoodDeliveryAppApp: App {
    let persistenceController = PersistenceController.shared
    let context = PersistentCloudKitContainer.persistentContainer.viewContext
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            HomeStyle1UIView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
