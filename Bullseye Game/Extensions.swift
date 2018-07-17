//
//  Extensions.swift
//  Bullseye Game
//
//  Created by Christopher Villanueva on 6/6/18.
//  Copyright © 2018 Christopher Villanueva. All rights reserved.
//

import UIKit

extension UIViewController {

    func createLabel(titleText: String, isBolded: Bool) -> UILabel {
        let label = UILabel()
        label.text = titleText
        label.textAlignment = .center
        label.textColor = .white
        label.font = isBolded ? UIFont.boldSystemFont(ofSize: 18) : UIFont.systemFont(ofSize: 18)
        label.adjustsFontSizeToFitWidth = true
        return label
    }

    func createStackView(axis: UILayoutConstraintAxis, distribution: UIStackViewDistribution, spacing: CGFloat) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.distribution = distribution
        return stackView
    }

    func createButtonWithTitle(title: String, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }

    func createButtonWithTitleAndBackground(title: String, background: UIImage, action: Selector) -> UIButton {
        let button = UIButton(type: .custom)
        button.setAttributedTitle(NSAttributedString(
            string: title,
            attributes: [
                NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 20),
                NSAttributedStringKey.foregroundColor : UIColor(red: 96/255, green: 0, blue: 0, alpha: 1)
            ]),
        for: .normal
        )
        button.setBackgroundImage(background, for: .normal)
        //button.setTitle(title, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }

    func createButtonWithImage(image: UIImage, action: Selector) -> UIButton {
        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }

    func createButtonWithImageAndBackground(image: UIImage, background: UIImage, action: Selector) -> UIButton {
        let button = UIButton(type: .custom)
        button.setBackgroundImage(background, for: .normal)
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
}

extension UIView {
    // custom anchor functions to make using auto layout easier and less tedious
    func anchor(top: NSLayoutYAxisAnchor?, paddingTop: CGFloat, left: NSLayoutXAxisAnchor?, paddingLeft: CGFloat, bottom: NSLayoutYAxisAnchor?, paddingBotton: CGFloat, right: NSLayoutXAxisAnchor?, paddingRight: CGFloat, width: CGFloat, height: CGFloat){

        translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBotton).isActive = true
        }
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }

}
