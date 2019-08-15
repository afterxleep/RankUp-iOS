//
//  Date+ElapsedTime.swift
//  RankUp
//
//  Created by Miguel Rojas on 8/11/19.
//

import Foundation

extension Date {
    
    func formattedElapsedTime() -> String {
        let elapsedSeconds = (self.timeIntervalSinceNow / 60) * -1
        let elapsedMinutes = Int(elapsedSeconds / 60)
        
        switch elapsedMinutes {
        case 0...59:
            return "\(elapsedMinutes)m"
        case 60...1440:
            return "\(elapsedMinutes / 60)h"
        default:
            return "\((elapsedMinutes / 60) / 24)d"
        }
    }
    
}
