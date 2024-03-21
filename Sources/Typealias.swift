import Foundation

/// File will contain only headers.

#if canImport(UIKit)
import UIKit

public typealias Font = UIFont
public typealias View = UIView
public typealias Label = UILabel
#elseif canImport(AppKit)
import AppKit

public typealias Font = NSFont
public typealias View = NSView
public typealias Label = NSTextView
#endif
