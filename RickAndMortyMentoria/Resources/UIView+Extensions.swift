//
//  UIView+Extensions.swift
//  RickAndMortyMentoria
//
//  Created by Henrique Ladeira on 05/10/23.
//

import UIKit

extension UIView {
    func addSubview(_ subview: UIView, constrainedToSuperview: Bool) {
        guard constrainedToSuperview else {
            addSubview(subview)
            return
        }

        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        subview.constrainEdgesToSuperview()
    }

    func constrainEdgesToSuperview(with insets: UIEdgeInsets = .zero) {
        guard let superview = superview else { return }
        superview.addConstraints([leadingAnchor.constraint(equalTo: superview.leadingAnchor,
                                                           constant: insets.left),
                                  trailingAnchor.constraint(equalTo: superview.trailingAnchor,
                                                            constant: -insets.right),
                                  topAnchor.constraint(equalTo: superview.topAnchor,
                                                       constant: insets.top),
                                  bottomAnchor.constraint(equalTo: superview.bottomAnchor,
                                                          constant: -insets.bottom)])
    }
}
