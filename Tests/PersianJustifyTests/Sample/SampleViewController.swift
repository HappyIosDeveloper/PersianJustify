// Based on the Example project

#if canImport(UIKit)
import UIKit
import PersianJustify

class SampleViewController: UIViewController {

    var fullWidthLabel1 = UILabel()
    var fullWidthLabel2 = UILabel()
    var halfWidthLabel1 = UILabel()
    var halfWidthLabel2 = UILabel()

    override func loadView() {
        super.loadView()
        defer { viewDidLoad() }

        /// Add views
        let scrollView = UIScrollView(frame: view.frame)
        view.addSubview(scrollView)

        let horizontalStack = UIStackView(arrangedSubviews: [halfWidthLabel1, halfWidthLabel2])
        horizontalStack.axis = .horizontal
        horizontalStack.spacing = 20

        let verticalStack = UIStackView(arrangedSubviews: [fullWidthLabel1, fullWidthLabel2, horizontalStack])
        verticalStack.axis = .vertical
        verticalStack.spacing = 20
        scrollView.addSubview(verticalStack)

        /// Layout views
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true

        verticalStack.translatesAutoresizingMaskIntoConstraints = false

        verticalStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        verticalStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive = true
        verticalStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: 0).isActive = true
        verticalStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0).isActive = true
        verticalStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0).isActive = true
    }
    
    enum FontNames: String {
        case khodkar = "B Titr Bold"
        case dastNevis = "Dast Nevis"
        case paeez = "Digi Paeez Regular"
        case shahgoosh = "shahgosh"
        case shokuh = "Shokoh Bold"
        case yekan = "MT_Yekan Square Boom Bold"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRTLDirection()
        setFont(name: .paeez)
        fillLabels()
    }
}

// MARK: - Setup Functions
extension SampleViewController {

    func setupRTLDirection() {
        fullWidthLabel1.textAlignment = .right
        fullWidthLabel2.textAlignment = .right
        halfWidthLabel1.textAlignment = .right
        halfWidthLabel2.textAlignment = .right
        fullWidthLabel1.numberOfLines = 0
        fullWidthLabel2.numberOfLines = 0
        halfWidthLabel1.numberOfLines = 0
        halfWidthLabel2.numberOfLines = 0
    }
    
    func fillLabels() {
        let font = fullWidthLabel1.font!
        let width = view.bounds.width
        fullWidthLabel1.attributedText = shortDemoText.toPJString(fittingWidth: width, font: font)
        fullWidthLabel2.attributedText = longDemoText.toPJString(fittingWidth: width, font: font)
        halfWidthLabel1.attributedText = shortDemoText.toPJString(fittingWidth: width, font: font)
        halfWidthLabel2.attributedText = longDemoText.toPJString(fittingWidth: width, font: font)
        fullWidthLabel1.sizeToFit()
        fullWidthLabel2.sizeToFit()
        halfWidthLabel1.sizeToFit()
        halfWidthLabel2.sizeToFit()
    }
    
    func addBorder() {
        fullWidthLabel1.addBorder()
        fullWidthLabel2.addBorder()
        halfWidthLabel1.addBorder()
        halfWidthLabel2.addBorder()
    }
    
    func setFont(name: FontNames) {
        fullWidthLabel1.font = UIFont(name: name.rawValue, size: 17)
        fullWidthLabel2.font = UIFont(name: name.rawValue, size: 17)
        halfWidthLabel1.font = UIFont(name: name.rawValue, size: 17)
        halfWidthLabel2.font = UIFont(name: name.rawValue, size: 17)
    }
}

// MARK: - UIView Extensions
extension UIView {
    
    func addBorder() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.red.cgColor
    }
}
#endif
