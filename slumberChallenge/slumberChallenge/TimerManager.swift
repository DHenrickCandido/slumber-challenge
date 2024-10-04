//
//  TimerManager.swift
//  slumberChallenge
//
//  Created by Diego Henrick on 02/10/24.
//

import Foundation

class TimerManager {

    var timer: Timer?
    var timePassed: TimeInterval = 0
    var onUpdate: ((String) -> Void)?

    func startTimer() {
        timePassed = 0

        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        timePassed += 0.001
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second, .nanosecond]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = [.pad]
        
        let timeString = formatter.string(from: timePassed) ?? "00:00:00"
        
        let milliseconds = Int((timePassed - Double(Int(timePassed))) * 1000)
        
        let finalTimeString = "\(timeString).\(String(format: "%03d", milliseconds))"
        
        onUpdate?(finalTimeString)
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func resetTimer() {
        stopTimer()
        startTimer()
    }

    deinit {
        stopTimer()
    }
}
