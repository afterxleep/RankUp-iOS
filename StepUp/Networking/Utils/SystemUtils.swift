//
//  SystemUtils.swift
//  StepUp
//
//  Created by Juan combariza on 7/26/19.
//

import Foundation

struct SystemUtils {
    static var isDebug: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
}
