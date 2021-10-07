//
//  ViewController.swift
//  CountryPicker
//
//  Created by Sobhi Imad on 07/10/2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var CountryView: UIView!
    @IBOutlet weak var countryCodeLbl: UILabel!
    @IBOutlet weak var countryImage: UIImageView!
    @IBOutlet weak var countryPhoneLbl: UILabel!
    private var selectedIndex:Int = 1
    @IBOutlet weak var languageBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.pickerCountry))
        self.CountryView.addGestureRecognizer(tapGes)
        if  isRTL(){
            languageBtn.setTitle("english", for: .normal)
        }else{
            languageBtn.setTitle("arabic".localized, for: .normal)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationItem.title = ""
    }
    @objc fileprivate func pickerCountry(){
        let screen = self.storyboard?.instantiateViewController(withIdentifier: "SelectCountryViewController") as! SelectCountryViewController
        screen.delegate = self
        screen.selectedId = self.selectedIndex
        self.navigationController?.pushViewController(screen, animated: true)
        
    }
    @IBAction func changeLanguage(_ sender: Any) {
        if isRTL(){
            self.EnglishLanguage()
        }else{
            ArabicLanguage()
        }
        var transition = UIView.AnimationOptions.transitionFlipFromRight
        if !isRTL() {
            transition = .transitionFlipFromLeft
        }
        
        let navroot = self.storyboard?.instantiateViewController(withIdentifier: "nav") as! UINavigationController
        UIView.transition(with: UIApplication.shared.windows.first!, duration: 0.5, options: transition, animations: {
            
            let oldState: Bool = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            UIApplication.shared.windows.first?.rootViewController = navroot
            UIApplication.shared.windows.first?.makeKeyAndVisible()
            UIView.setAnimationsEnabled(oldState)
        }, completion: { (finished: Bool) -> () in
            
            //             if (completion != nil) {
            //                completion!()
            //            }
        })
        
        
        
    }
    func ArabicLanguage()
    {
        LanguageManager.saveLanguage(by: 1)
        let defaults = UserDefaults.standard
        defaults.set(["ar"], forKey: "AppleLanguages")
        defaults.synchronize()
        if #available(iOS 9.0, *) {
            UIPageControl.appearance().semanticContentAttribute = .forceRightToLeft
            UIControl.appearance().semanticContentAttribute = .forceRightToLeft
            UINavigationBar.appearance().semanticContentAttribute = .forceRightToLeft
            UITextField.appearance().semanticContentAttribute = .forceRightToLeft
            UILabel.appearance().semanticContentAttribute = .forceRightToLeft
            UITextView.appearance().semanticContentAttribute = .forceRightToLeft
            UIImageView.appearance().semanticContentAttribute = .forceRightToLeft
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            UINavigationController().view.semanticContentAttribute = .forceRightToLeft
            UITableView.appearance().semanticContentAttribute = .forceRightToLeft
            UINavigationController().navigationBar.semanticContentAttribute = .forceRightToLeft
            UITabBarController().view.semanticContentAttribute  = .forceRightToLeft
            UISwitch.appearance().semanticContentAttribute = .forceRightToLeft
            UITextField.appearance().setLabelTextAlignment(Alignment: .right)
            UITextView.appearance().setLabelTextAlignment(Alignment: .right)
            UISegmentedControl.appearance().semanticContentAttribute = .forceRightToLeft
            /// if you add library rating
            //            CosmosView.appearance().semanticContentAttribute = .forceRightToLeft
            
        } else {
            // Fallback on earlier versions
        }
        LanguageManager.setupCurrentLanguage()
        
    }
    
    func EnglishLanguage()
    {
        LanguageManager.saveLanguage(by: 0)
        let defaults = UserDefaults.standard
        defaults.set(["en"], forKey: "AppleLanguages")
        if #available(iOS 9.0, *) {
            UIPageControl.appearance().semanticContentAttribute = .forceLeftToRight
            UIControl.appearance().semanticContentAttribute = .forceLeftToRight
            UINavigationBar.appearance().semanticContentAttribute = .forceLeftToRight
            UITextField.appearance().semanticContentAttribute = .forceLeftToRight
            UILabel.appearance().semanticContentAttribute = .forceLeftToRight
            UITextView.appearance().semanticContentAttribute = .forceLeftToRight
            UIImageView.appearance().semanticContentAttribute = .forceLeftToRight
            UITableView.appearance().semanticContentAttribute = .forceLeftToRight
            UITextField.appearance().setLabelTextAlignment(Alignment: .left)
            UITextView.appearance().setLabelTextAlignment(Alignment: .left)
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            UISwitch.appearance().semanticContentAttribute = .forceLeftToRight
            UINavigationController().navigationBar.semanticContentAttribute = .forceLeftToRight
            UISegmentedControl.appearance().semanticContentAttribute = .forceLeftToRight
            UINavigationController().view.semanticContentAttribute = .forceLeftToRight
            UITabBarController().view.semanticContentAttribute  = .forceLeftToRight
            /// if you add library rating
            //            CosmosView.appearance().semanticContentAttribute = .forceLeftToRight
        } else {
            // Fallback on earlier versions
        }
        LanguageManager.setupCurrentLanguage()
    }
    
    
    
}
//MARK:-CountryDataSource
extension ViewController:CountryDataSource{
    func didSelected(category: [String : Any]) {
        print(category)
        if let id = category["id"] as?  Int{
            self.selectedIndex = id
        }
        if let phone =  category["dial_code"] as? String{
            self.countryPhoneLbl.text  = "+" + phone
        }
        if let code = category["code"] as? String{
            self.countryCodeLbl.text = code.uppercased()
        }
        if let image = category["image"] as? String{
            self.countryImage.image = UIImage(named: image.uppercased())
        }
        
        
    }
    
    
}
