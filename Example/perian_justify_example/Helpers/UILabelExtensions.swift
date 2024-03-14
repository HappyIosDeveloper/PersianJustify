//
//  UILabelExtensions.swift
//  perian_justify
//
//  Created by Ahmadreza on 2/17/24.
//

import UIKit

extension UILabel {
    
    // MARK: This will mess with the applied attributions
    func markExtenders() {
        let attributedText = self.text!.reduce(NSMutableAttributedString()) {
            $0.append(NSAttributedString(string: String($1),attributes: [.foregroundColor: $1 == "ـ" ? UIColor.systemPink : .black]))
            return $0
        }
        self.attributedText = attributedText
    }
}
