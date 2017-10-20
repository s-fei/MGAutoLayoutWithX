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
    
    /*! 是否使用UILayoutGuide来约束 如果使用 就无需手动添加自适应啦 */
    func isUseUILayoutGuideWithTop() -> Bool {
        guard let `superView` = superview else { return false }
        for constraint in superView.constraints {
            if let firstView = constraint.firstItem as? UIView,
                let secondItem = constraint.secondItem,
                firstView == self {
                if secondItem.classForCoder == NSClassFromString("_UILayoutGuide") &&
                    constraint.secondAttribute == .bottom  {
                    return true
                }
                if secondItem.classForCoder == NSClassFromString("UILayoutGuide") &&
                    constraint.secondAttribute == .top {
                    return true
                }
            }
            if let firstItem = constraint.firstItem,
                let secondView = constraint.secondItem as? UIView,
                secondView == self{
                if firstItem.classForCoder == NSClassFromString("_UILayoutGuide") &&
                    constraint.firstAttribute == .bottom  {
                    return true
                }
                if firstItem.classForCoder == NSClassFromString("UILayoutGuide") &&
                    constraint.firstAttribute == .top {
                    return true
                }
            }
        }
        return false
    }
    
    /*! 是否使用UILayoutGuide来约束 如果使用 就无需手动添加自适应啦 */
    func isUseUILayoutGuideWithBottom() -> Bool {
        guard let `superView` = superview else { return false }
        for constraint in superView.constraints {
            if let firstView = constraint.firstItem as? UIView,
                let secondItem = constraint.secondItem,
                firstView == self {
                if secondItem.classForCoder == NSClassFromString("_UILayoutGuide") &&
                    constraint.secondAttribute == .top  {
                    return true
                }
                if secondItem.classForCoder == NSClassFromString("UILayoutGuide") &&
                    constraint.secondAttribute == .bottom {
                    return true
                }
            }
            if let firstItem = constraint.firstItem,
                let secondView = constraint.secondItem as? UIView,
                secondView == self{
                if firstItem.classForCoder == NSClassFromString("_UILayoutGuide") &&
                    constraint.firstAttribute == .top  {
                    return true
                }
                if firstItem.classForCoder == NSClassFromString("UILayoutGuide") &&
                    constraint.firstAttribute == .bottom {
                    return true
                }
            }
        }
        return false
    }
    
    func isUIView() -> Bool {
        return self.isMember(of: UIView.self)
    }
}
