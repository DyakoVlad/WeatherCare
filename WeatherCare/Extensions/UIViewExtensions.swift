//
//  UIViewExtensions.swift
//  Egogo
//
//  Created by Stanly Shiyanovskiy on 08.05.2020.
//  Copyright © 2020 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

protocol TypeName: AnyObject {
    static var typeName: String { get }
}

extension TypeName {
    static var typeName: String {
        let type = String(describing: self)
        return type
    }
}

extension NSObject: TypeName {
    class var typeName: String {
        let type = String(describing: self)
        return type
    }
}

public extension UIView {
    
    @discardableResult
    func xibConfigure() -> UIView {
        let view: UIView = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        return view
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName: String = type(of: self).typeName
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView
        if view != nil {
            return view!
        } else {
            return UIView()
        }
    }

    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
