//
//  UILabel.fixDirectionForiOS26.swift
//  PersianJustify
//
//  Created by Ahmadreza on 10/13/25.
//

#if canImport(UIKit)
import UIKit
public extension UILabel {
    
    @available(iOS 26.0, *)
    public func fixDirectionForiOS26() {
        if let traitOverrides = value(forKey: "traitOverrides") as? NSObject {
            if traitOverrides.responds(to: NSSelectorFromString("setResolvesNaturalAlignmentWithBaseWritingDirection:")) {
                traitOverrides.setValue(true, forKey: "resolvesNaturalAlignmentWithBaseWritingDirection")
            }
        }
    }
}
#endif
