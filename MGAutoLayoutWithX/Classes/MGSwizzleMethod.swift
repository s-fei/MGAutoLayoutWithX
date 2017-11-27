//
//  MGSwizzleMethod.swift
//  Tex
//
//  Created by song on 2017/10/19.
//  Copyright © 2017年 song. All rights reserved.
//

import UIKit



internal func mgSwizzleMethod(_ cls: Swift.AnyClass!,_ originalSelector:Selector,_ swizzledSelector:Selector){
    DispatchQueue.once(token: NSUUID().uuidString) {
        if let originalMethod = class_getInstanceMethod(cls, originalSelector),
            let swizzledMethod = class_getInstanceMethod(cls, swizzledSelector) {
            let didAddMethod: Bool = class_addMethod(cls, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
            
            if didAddMethod {
                class_replaceMethod(cls, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod)
            }
        }
    }
}

extension DispatchQueue {
    private static var onceTracker = [String]()
    
    open class func once(token: String, block:() -> Void) {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        
        if onceTracker.contains(token) {
            return
        }
        
        onceTracker.append(token)
        block()
    }
}
