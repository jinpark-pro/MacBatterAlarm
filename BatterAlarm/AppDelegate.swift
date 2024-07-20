//
//  AppDelegate.swift
//  BatterAlarm
//
//  Created by Jungjin Park on 2024-07-21.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var batterNotifier: BatteryNotifier?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        batterNotifier = BatteryNotifier()
        batterNotifier?.startMonitoring()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }


}

