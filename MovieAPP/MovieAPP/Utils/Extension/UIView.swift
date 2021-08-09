//
//  UIView.swift
//  MovieAPP
//
//  Created by Daniel Mondragón on 07/08/21.
//

import UIKit
public extension UIView {
    func createSpinnerFooter(view: UIView, color: UIColor) -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width ,height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        spinner.color = color
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
}
