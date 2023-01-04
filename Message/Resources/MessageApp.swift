//
//  MessageApp.swift
//  Message
//
//  Created by Matthew Titi on 6/15/22.
//

import SwiftUI
import Firebase

@main
struct MessageApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate: AppDelegate
    @State var selectedIndex: Int = 0
    @State var action: Int? = 0
    @State var isPresented: Bool = false
    @State var messageUsername: String = ""


    var body: some Scene {
        WindowGroup {
            Navigation(selectedIndex: $selectedIndex, action: $action, isPresented: $isPresented, messageUsername: $messageUsername)
                .environmentObject(AppStateModel())
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
