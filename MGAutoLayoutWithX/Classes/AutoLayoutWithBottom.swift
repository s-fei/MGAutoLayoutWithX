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
        if subView.isUIView() {
            mg_autoLayoutBottomWithFrameHeight(subView: subView)
        }
        else {
            mg_autoLayoutBottomWithFrameBottom(subView: subView)
        }
    }
    
    /*! 约束自适应 */
    func mg_autoLayoutBottomWithConstraints(subView:UIView) {
        if subView.isUIView() {
            mg_autoLayoutBottomWithConstraintHeight(subView: subView)
        }
        else {
            mg_autoLayoutBottomWithConstraintBottom(subView: subView)
        }
    }
    
    
    /*! 坐标写死不改变高度 */
    func mg_autoLayoutBottomWithFrameBottom(subView:UIView) {
        var subFrame = subView.frame
        subFrame.origin.y -= bottomViewMargin
        subView.frame = subFrame
    }
    
    /*! 坐标写死改变高度 */
    func mg_autoLayoutBottomWithFrameHeight(subView:UIView) {
        var subFrame = subView.frame
        subFrame.origin.y -= bottomViewMargin
        subFrame.size.height += bottomViewMargin
        subView.frame = subFrame
        mg_layoutWithTopSubView(superView: subView)
    }
    
    /*! 约束不改变高度 */
    func mg_autoLayoutBottomWithConstraintBottom(subView:UIView) {
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
    
    /*! 约束改变高度 */
    func mg_autoLayoutBottomWithConstraintHeight(subView:UIView) {
        var isChangeHeight = false
        subView.constraints.forEach({ [weak subView] (constraint) in
            guard let `subView` = subView else { return }
            if let firstView = constraint.firstItem as? UIView, firstView == subView &&
                constraint.firstAttribute == .height {
                constraint.constant += bottomViewMargin
                isChangeHeight = true
            }
        })
        if isChangeHeight {
            subView.constraints.forEach({ [weak subView] (constraint) in
                guard let `subView` = subView else { return }
                if let firstView = constraint.firstItem as? UIView, firstView == subView &&
                    constraint.firstAttribute == .bottom {
                    constraint.constant += bottomViewMargin
                }
                else if let firstView = constraint.firstItem as? UIView, firstView == subView &&
                    constraint.firstAttribute == .centerY {
                    constraint.constant += bottomViewMargin/2
                }
                else if let secondView = constraint.secondItem as? UIView, secondView == subView &&
                    constraint.secondAttribute == .bottom {
                    constraint.constant -= bottomViewMargin
                }
                else if let secondView = constraint.secondItem as? UIView, secondView == subView &&
                    constraint.secondAttribute == .centerY {
                    constraint.constant -= bottomViewMargin/2
                }
            })
        }
    }
}

