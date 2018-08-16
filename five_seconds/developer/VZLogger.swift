//
//  VZLogger.swift
//  5second
//
//  Created by Maximal Mac on 16.08.2018.
//  Copyright © 2018 vz. All rights reserved.
//

import Foundation

class VZLogger {
    enum VZLoggerConfig {
        case loggingAllEvents
        case loggingOnlyErrorsAndDebugEvents
        case loggingOnlyErrorsEvents
        case loggingOnlyFatalErrorsEvents
    }
    
    enum MessageType: String {
        case info = "💭"
        case debug = "♠️"
        case error = "💥"
        case fatalError = "☠️"
    }
    
    static var loggerConfig: VZLoggerConfig = VZLogger.VZLoggerConfig.loggingAllEvents
    
    class func info(_ message: String?) {
        guard VZLogger.loggerConfig == .loggingAllEvents else { return }
        VZLogger.print(.info, message: message)
    }
    
    class func debug(_ message: String?) {
        guard VZLogger.loggerConfig == .loggingAllEvents || VZLogger.loggerConfig == .loggingOnlyErrorsAndDebugEvents  else { return }
        VZLogger.print(.debug, message: message)
    }
    
    class func error(_ message: String?) {
        guard VZLogger.loggerConfig != .loggingOnlyFatalErrorsEvents else { return }
        VZLogger.print(.error, message: message)
    }
    
    class func fatalError(_ message: String?) {
        VZLogger.print(.fatalError, message: message)
        Swift.fatalError()
    }
    
    private class func print(_ type: MessageType, message: String?) {
        Swift.print(type.rawValue + " " + (message ?? "value is nil"))
    }
}
