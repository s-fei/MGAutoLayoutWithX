//
//  AutoLayoutFetching.swift
//  MGAutoLayoutWithX
//
//  Created by song on 2017/10/20.
//
import UIKit

/*! 判断是否是约束 */
internal protocol AutoLayoutFetching {
    
    var autoIdentifier: String? { get set }
    
    func isAutoLayout() -> Bool
    
    func isUIView() -> Bool
    
}

private var autoIdentifierKey: Void?

extension UIView: AutoLayoutFetching {
    
    internal var autoIdentifier: String? {
        get {
            return (objc_getAssociatedObject(self, &autoIdentifierKey) as? String)
        }
        set(newValue) {
            objc_setAssociatedObject(self, &autoIdentifierKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /*! 是否使用约束来写坐标 */
    func isAutoLayout() -> Bool {
        guard let `superView` = superview else { return false }
        let subConstraints = superView.constraints.filter({ (constraint) -> Bool in
            if let firstView = constraint.firstItem as? UIView, firstView == self {
                return true
            }
            if let secondView = constraint.secondItem as? UIView, secondView == self {
                return true
            }
            return false
        })
        return !(constraints.isEmpty && subConstraints.isEmpty)
    }
    
    func isUIView() -> Bool {
        return self.isMember(of: UIView.self)
    }
}
