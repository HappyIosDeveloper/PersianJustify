//
//  ViewController.swift
//  PersianJustify
//
//  Created by Ahmadreza on 2/17/24.
//

import UIKit
import PersianJustify

class ViewController: UIViewController {
    
    @IBOutlet weak var fullWidthLabel1: UILabel!
    @IBOutlet weak var fullWidthLabel2: UILabel!
    @IBOutlet weak var halfWidthLabel1: UILabel!
    @IBOutlet weak var halfWidthLabel2: UILabel!
    
    let text1 = """
خودروهایی که نام‌شان در این لیست قیمت وجود ندارد، محصولاتی هستند که در اردیبهشت‌ماه سال 1402، یا تولید نشده‌اند یا هنوز زمان عرضه و تحویل آنها فرا نرسیده است.
"""
    let text2 = """
داشتن خواب باکیفیت برای سلامتی انسان اهمیت بسیار زیادی دارد. همه‌ی افراد در طول روز ساعت‌های زیادی را در حال فعالیت هستند و استرس‌های مختلفی را تحمل می‌کنند، بنابراین اتاق خواب باید یک جای راحت و آرامبخش باشد. هیچ‌کس از اهمیت داشتن یک تخت خواب و تشک راحت بی‌خیر نیست، اما نکته‌ی پر اهمیت بعدی روتختی، رو بالشی، پتو، لحاف و کاور و در واقع ست سرویس خوابی است که استفاده می‌کنید. رنگ‌هایی که در اتاق خواب استفاده می‌کنید باید آرامبخش باشند و یک سرویس خواب طوسی یا آبی می‌تواند بسیار مناسب باشد. باتوجه به خواب آور بودن رنگ بنفش یک سرویس خواب بنفش شیک هم گزینه‌ی خوبی است. پارچه‌ی به کار رفته برای دوخت روتختی هم بسیار مهم است، زیرا باید به‌راحتی شسته شود و عرق بدن را هم جذب کند. یک روبالشتی خوب هم باید نرم و لطیف باشد تا موها آسیب نبیننند. پارچه‌های نخی و کتان برای روتختی بسیار مناسب‌اند و از ساتن و ابریشم می‌توانید برای روبالشتی استفاده کنید.

"""
    
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
extension ViewController {
    
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
        fullWidthLabel1.attributedText = text1.toPJString(in: fullWidthLabel1)
        fullWidthLabel2.attributedText = text2.toPJString(in: fullWidthLabel2)
        halfWidthLabel1.attributedText = text1.toPJString(in: halfWidthLabel1)
        halfWidthLabel2.attributedText = text2.toPJString(in: halfWidthLabel2)
        fullWidthLabel1.sizeToFit()
        fullWidthLabel2.sizeToFit()
        halfWidthLabel1.sizeToFit()
        halfWidthLabel2.sizeToFit()
//        addBorder()
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
