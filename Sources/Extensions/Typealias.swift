#if canImport(UIKit)
import UIKit
public typealias Font = UIFont
public typealias View = UIView
#elseif canImport(AppKit)
import AppKit
public typealias Font = NSFont
public typealias View = NSView
#endif
