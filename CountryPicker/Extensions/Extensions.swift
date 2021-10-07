//
//  Extensions.swift
//  CountryPicker
//
//  Created by Sobhi Imad on 07/10/2021.
//

import UIKit
extension String {
    // Locale is the most important extension variable we need in all apps
    var localized : String {
        return NSLocalizedString(self, comment: "")
    }

    //Other extensions to string can be added here (e.g. md5, or validations ...)
}

extension UITableView {
    func dequeueTVCell<T: UITableViewCell>() -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: T.self)) as? T else {
            fatalError("Could not locate viewcontroller with identifier \(String(describing: T.self)) in storyboard.")
        }
        return cell
    }

    func registerCell(id: String) {
        self.register(UINib(nibName: id, bundle: nil), forCellReuseIdentifier: id)
    }

    func registerCell(id: UITableViewCell.Type) {
        let _id = String(describing: id)
        self.register(UINib(nibName: _id, bundle: nil), forCellReuseIdentifier: _id)
    }



}


extension UITextField {
    func clearText(){
        self.text = ""
    }
    func setLabelTextAlignment(Alignment:NSTextAlignment){
        if(textAlignment == .left || textAlignment == .right)
        {
            textAlignment = Alignment
        }
    }
}
extension UITextView{
    func setLabelTextAlignment(Alignment:NSTextAlignment){

        if(textAlignment == .left || textAlignment == .right)
        {
            textAlignment = Alignment
        }
    }
}
func isRTL() -> Bool
{
    if LanguageManager.currentLanguageCode() == "ar"
    {
        return true
    }
    return false
}

