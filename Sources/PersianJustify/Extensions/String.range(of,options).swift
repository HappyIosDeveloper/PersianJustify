import Foundation

extension String {

    /// Finds and returns the range of the first occurrence of a given string within the string, subject to given options.
    func range(of searchString: String, options mask: NSString.CompareOptions = []) -> NSRange {
        (self as NSString).range(of: searchString, options: mask)
    }
}
