//
//  UIColor+Extensions.swift
//  RickAndMortyMentoria
//
//  Created by Henrique Ladeira on 26/10/23.
//

import UIKit

extension UIColor {
    static func random() -> UIColor {
        let colors: [UIColor] = [.blue, .brown, .cyan, .green, .magenta, .orange, .purple, .red, .yellow]
        let randomIndex = Int.random(in: 0..<colors.count)
        return colors[randomIndex]
    }
}
