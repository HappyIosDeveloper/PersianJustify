import class Foundation.NSPredicate

/// Regex that will be used against an arbitrary string,
/// to identify if it's in Arabic.
private let arabicRegex = "(?s).*\\p{Arabic}.*"

/// Wrapper around a predicate that will encapsulate the logic of identifying if a given string is in Arabic.
struct ArabicCharacterEvaluator {
    private static let _predicate = NSPredicate(format: "SELF MATCHES %@", arabicRegex)

    func evaluate(with character: Character) -> Bool {
        // Character must be converted to string before being fed to predicate.
        let stringRepresentation = String(character)

        return Self._predicate.evaluate(with: stringRepresentation)
    }
}
