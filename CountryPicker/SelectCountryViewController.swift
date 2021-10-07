//
//  SelectCountryViewController.swift
//  CountryPicker
//
//  Created by Sobhi Imad on 07/10/2021.
//

import UIKit

protocol CountryDataSource:AnyObject {
    func didSelected(category:[String:Any])
}

import UIKit

class SelectCountryViewController: UIViewController {

    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var tableView:UITableView!{
        didSet{
            tableView.registerCell(id: CountryTableViewCell.self)
            tableView.dataSource = self
            tableView.delegate = self
            tableView.rowHeight = 50
            tableView.tableFooterView = UIView()
        }
    }
    var dataSource:[[String:Any]] = []
    var filteredDataSource:[[String:Any]] = []
    weak var delegate:CountryDataSource?
    var selectedId:Int = 1
    private var isFiltered:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()

        getCountries()
        confing()
    }
    private  func confing(){
        searchTF.placeholder = "search".localized
        searchTF.delegate = self
        searchTF.addTarget(self, action: #selector(self.searchCountry(_:)), for: .editingChanged)
    }
    @objc fileprivate func searchCountry(_ sender:UITextField){
        guard let text = sender.text , !text.isEmpty else {self.isFiltered = false; return}
        let filtered = self.dataSource.filter { object in
            if let name = object["name"] as? String ,let phone = object["dial_code"] as? String{
                self.isFiltered = true
                return name.lowercased().contains(text.lowercased()) || phone.lowercased().contains(text.lowercased())
            }
            return false
        }
        self.filteredDataSource = filtered
        tableView.reloadData()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationItem.title = "select_country".localized
    }
    fileprivate func getCountries()
    {
        if let path = Bundle.main.path(forResource: "CountryCodes", ofType: "json") {
            do {

                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? [[String : Any]] {
                    // do stuff
                    self.dataSource = jsonResult
                    self.dataSource.removeAll()
                    for (index,var value) in jsonResult.enumerated(){
                        var id = index
                        id +=  1
                        value["id"] = id
                        self.dataSource.append(value)
                    }
                    self.tableView.reloadData()
                }
            } catch let err {
                // handle error
                print(err)
                print(err.localizedDescription)
            }
        }


    }

}
//MARK:- UITableViewDataSource
extension SelectCountryViewController:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.isFiltered ? self.filteredDataSource.count : self.dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CountryTableViewCell = tableView.dequeueTVCell()
        let object = isFiltered ? self.filteredDataSource[indexPath.row] : self.dataSource[indexPath.row]
        if let image = object["image"] as?  String{
            let capitalImage = image.uppercased()
            cell.countryImage.image = UIImage(named: capitalImage)
        }
//        let  name = isRTL() ? object["name_ar"] : object["name"]
        let name =  object["name"]
        if let name = name as? String{
            cell.countryName.text = name
        }
        if let countryCode = object["dial_code"] as? String{
            cell.countryCode.text = "+" + countryCode
        }
        if let id = object["id"] as? Int {
            cell.accessoryType = self.selectedId == id ? .checkmark : .none
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let object = isFiltered ? self.filteredDataSource[indexPath.row] : self.dataSource[indexPath.row]
        if let id = object["id"] as? Int{
            self.selectedId = id
        }
        self.delegate?.didSelected(category: object)
        self.navigationController?.popViewController(animated: true)
        self.tableView.reloadData()
    }
}

//MARK:- UITextFieldDelegate
extension SelectCountryViewController: UITextFieldDelegate{
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.clearText()
        self.isFiltered = false
        self.tableView.reloadData()
        self.view.endEditing(true)
        return true
    }
}

