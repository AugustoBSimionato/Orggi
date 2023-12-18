//
//  OrggiApp.swift
//  Orggi
//
//  Created by Augusto Simionato on 14/11/23.
//

import SwiftUI
import SwiftData

@main
struct OrggiApp: App {
    let container: ModelContainer = {
        let schema = Schema([Expense.self])
        let container = try! ModelContainer(for: schema, configurations: [])
        
        return container
    }()
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(container)
//        .modelContainer(for: [Expense.self])
    }
}
