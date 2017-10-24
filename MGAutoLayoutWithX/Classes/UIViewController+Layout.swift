//
//  UIViewController+Layout.swift
//  MGAutoLayoutWithX
//
//  Created by song on 2017/10/19.
//

import UIKit
import MapKit
import WebKit


extension UIViewController{
    
    static func mgawake(){
        mgSwizzleMethod(self, #selector(UIViewController.viewDidLayoutSubviews), #selector(UIViewController.mg_viewDidLayoutSubviews))
    }
    
    func mg_viewDidLayoutSubviews() {
        mg_viewDidLayoutSubviews()
        if self.isKind(of: UINavigationController.self) { return }
        if !MGAutoLayoutWithX.shared.isAutoLayout { return }
        mg_layoutWithSubviews(superView: view)
    }
    
    func mg_layoutWithSubviews(superView: UIView){
        superView.subviews.forEach { [weak self] (subView) in
            guard let `self` = self else { return }
            self.mg_autoLayoutWithTopView(subView:subView)
        }
    }
    
    func mg_autoLayoutWithTopView(subView:UIView) {
        if subView.autoIdentifier == "isAutoLayout"  { return }
        if subView.bounds == CGRect.zero { return }
        if subView.isKind(of: UITabBar.self) { return }
        if subView.isKind(of: UINavigationBar.self) { return }
        if subView.isKind(of: UIScrollView.self) { return }
        if subView.isKind(of: MKMapView.self) { return }
        if subView.isKind(of: UIWebView.self) { return }
        if subView.isKind(of: WKWebView.self) { return }
        if subView.classForCoder == NSClassFromString("_UILayoutGuide") { return }
        guard let window = UIApplication.shared.delegate?.window else { return }
        let statusBarFrame = UIApplication.shared.statusBarFrame
        let rectForW = subView.convert(subView.bounds, to: window)
        
        if statusBarFrame.intersects(rectForW) {
            if subView.isAutoLayout() {
                if !subView.isUseUILayoutGuideWithTop(){
                    mg_autoLayoutTopWithConstraints(subView: subView)
                }
            }
            else {
                mg_autoLayoutTopWithFrame(subView: subView)
            }
        }
        
        let bottomAppFrame = CGRect(x: 0, y: UIScreen.main.bounds.height - bottomViewMargin, width: UIScreen.main.bounds.width, height:bottomViewMargin )
        if bottomAppFrame.intersects(rectForW) {
            if subView.isAutoLayout() {
                if !subView.isUseUILayoutGuideWithBottom() {
                    mg_autoLayoutBottomWithConstraints(subView: subView)
                }
            }
            else {
                mg_autoLayoutBottomWithFrame(subView: subView)
            }
        }
        
        subView.autoIdentifier = "isAutoLayout"
    }
}
