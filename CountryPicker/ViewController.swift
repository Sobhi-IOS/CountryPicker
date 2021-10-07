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
    }
    @objc fileprivate func pickerCountry(){
        let screen = self.storyboard?.instantiateViewController(withIdentifier: "SelectCountryViewController") as! SelectCountryViewController
        screen.delegate = self
        screen.selectedId = self.selectedIndex
        self.navigationController?.pushViewController(screen, animated: true)

    }
    @IBAction func changeLanguage(_ sender: Any) {

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
