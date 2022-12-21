//
//  ChatApp2App.swift
//  ChatApp2
//
//  Created by Jonathan Born on 2022-04-01.
//

import SwiftUI
import Firebase

@main
struct ChatApp2App: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
