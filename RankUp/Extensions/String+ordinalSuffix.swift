//
//  String+position.swift
//  RankUp
//
//  Created by Daniel Bernal on 8/19/19.
//

import Foundation

extension String {
    
    // Returns a formatted ordinal number like 1st, 2nd etc
    func withOrdinalSuffix() -> String {
        
        guard let number = Int(self) else {
            return ""
        }
        
        if(number == 0) {
            return "∞"
        }
        
        let mod10 = number % 10
        let mod100 = number % 100;
        
        if (number <= 0) {
            return self;
        }
        if (mod10 == 1 && mod100 != 11) {
            return "\(self)st";
        }
        if (mod10 == 2 && mod100 != 12) {
            return "\(self)nd";
        }
        if (mod10 == 3 && mod100 != 13) {
            return "\(self)rd";
        }
        return "\(self)th";
    }
    
}
