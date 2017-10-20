//
//  AutoLayoutWithBottom.swift
//  MGAutoLayoutWithX
//
//  Created by song on 2017/10/20.
//

import UIKit

/*! 自适应顶部View */
extension UIViewController{
    /*! 坐标写死的自适应 */
    func mg_autoLayoutBottomWithFrame(subView:UIView) {
        mg_autoLayoutWithFrameBottom(subView: subView)
    }
    
    /*! 约束自适应 */
    func mg_autoLayoutBottomWithConstraints(subView:UIView) {
        mg_autoLayoutWithConstraintBottom(subView: subView)
    }
    
    /*! 坐标写死不改变高度 */
    func mg_autoLayoutWithFrameBottom(subView:UIView) {
        var subFrame = subView.frame
        subFrame.origin.y -= bottomViewMargin
        subView.frame = subFrame
    }
    
    /*! 约束不改变高度 */
    func mg_autoLayoutWithConstraintBottom(subView:UIView) {
        guard let superview = subView.superview else { return }
        superview.constraints.forEach { [weak subView](constraint) in
            guard let `subView` = subView else { return }
            if let firstView = constraint.firstItem as? UIView, firstView == subView &&
                constraint.firstAttribute == .bottom  {
                constraint.constant -= bottomViewMargin
            }
            else if let secondView = constraint.secondItem as? UIView, secondView == subView &&
                constraint.secondAttribute == .bottom  {
                constraint.constant += bottomViewMargin
            }
        }
    }
}

