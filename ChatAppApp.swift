//
//  ChatAppApp.swift
//  ChatApp
//
//  Created by Jonathan Born on 2022-03-29.
//

import SwiftUI
import Firebase

@main
struct ChatAppApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
