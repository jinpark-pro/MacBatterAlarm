//
//  BatterMotifier.swift
//  BatterAlarm
//
//  Created by Jungjin Park on 2024-07-21.
//

import Cocoa
import IOKit.ps

class BatteryNotifier {
    var timer: Timer?
    
    init() {
        startMonitoring()
    }
    
    func startMonitoring() {
        timer = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(checkBatterStatus), userInfo: nil, repeats: true)
    }
    
    func stopMonitoring() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc func checkBatterStatus() {
        print("check")
        let snapshot = IOPSCopyPowerSourcesInfo().takeRetainedValue()
        let sources = IOPSCopyPowerSourcesList(snapshot).takeRetainedValue() as Array
        if let source = sources.first {
            if let info = IOPSGetPowerSourceDescription(snapshot, source).takeUnretainedValue() as? [String: Any] {
                if let currentCapacity = info[kIOPSCurrentCapacityKey] as? Int,
                   let maxCapacity = info[kIOPSMaxCapacityKey] as? Int,
                   let isCharging = info[kIOPSIsChargingKey] as? Bool {
                    if true {
                        let batterLevel = (Double(currentCapacity) / Double(maxCapacity)) * 100
                        if batterLevel >= 80 {
                            print("batter is more than or equal to 80%")
                            sendNotification()
                        }
                    } else {
                        print("stop monitoring")
                        stopMonitoring()
                    }
                }
            }
        }
    }
    
    func sendNotification() {
        let notification = NSUserNotification()
        notification.title = "BatterAlert"
        notification.informativeText = "Battery level has reached 80%"
        notification.soundName = NSUserNotificationDefaultSoundName
        NSUserNotificationCenter.default.deliver(notification)
    }
}
