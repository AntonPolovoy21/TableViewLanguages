//
//  ViewController.swift
//  LanguagePicker
//
//  Created by Admin on 12.10.23.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    private let arrayOfLanguages = ["English(Australia)", "English(US)", "Russian", "Chinese", "Italian", "German", "French"]
    private let arrayOfCountries = ["Australia", "USA", "Russia", "China", "Italy", "Germany", "France"]
    private let arrayOfIcons = ["australia" ,"usa", "russia", "china", "italy", "germany", "france"]
    
    private var filteredLanguages = [(language: String, country: String, icon: String)]()
    private var isFiltered = false
    
    private var currentlySelected = IndexPath()
    private var defaultLang = "USA"
    
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Choose language"
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 20)
        return lbl
    }()
    
    private let textFieldSearch: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Search"
        tf.adjustsFontSizeToFitWidth = true
        tf.textColor = .black
        tf.borderStyle = .roundedRect
        tf.backgroundColor = .systemGray6
        tf.layer.borderColor = UIColor.black.cgColor
        tf.keyboardType = .alphabet
        tf.keyboardAppearance = .dark
        tf.clearButtonMode = .always
        tf.returnKeyType = .done
        tf.autocorrectionType = .no
        return tf
    }()
    
    private lazy var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manageSubviews()
    }

    private func manageSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(textFieldSearch)
        view.addSubview(tableView)
        
        titleLabel.snp.makeConstraints(){
            $0.top.equalTo(60)
            $0.centerX.equalTo(view)
        }
        
        textFieldSearch.snp.makeConstraints(){
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.left.equalTo(30)
            $0.right.equalTo(-30)
            $0.height.equalTo(30)
        }
        textFieldSearch.delegate = self
        
        tableView.snp.makeConstraints(){
            $0.top.equalTo(textFieldSearch).offset(60)
            $0.left.right.bottom.equalToSuperview()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LanguageCell.self, forCellReuseIdentifier: LanguageCell.identifier)
        tableView.separatorColor = .gray
        tableView.separatorInset = .zero
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text {
            filterLanguages(withText: text)
        }
        return true
    }
    
    private func filterLanguages(withText text: String) {
        guard text != "" else { return }
        filteredLanguages.removeAll()
        for str in arrayOfLanguages {
            if str.lowercased().starts(with: text.lowercased()) {
                guard let ind = arrayOfLanguages.firstIndex(of: str) else { return }
                filteredLanguages.append((language: arrayOfLanguages[ind], country: arrayOfCountries[ind], icon: arrayOfIcons[ind]))
            }
        }
        print(filteredLanguages)
        tableView.reloadData()
        isFiltered = true
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if !filteredLanguages.isEmpty {
            return filteredLanguages.count
        }
        return arrayOfLanguages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LanguageCell.identifier) as? LanguageCell else {return UITableViewCell()}
        
        if !filteredLanguages.isEmpty {
            cell.configure(withLanguage: filteredLanguages[indexPath.row].language, withCaption: filteredLanguages[indexPath.row].country, withFlag: filteredLanguages[indexPath.row].icon)
            cell.selectionStyle = .none
        }
        else {
            guard arrayOfCountries[indexPath.row] != defaultLang else {
                currentlySelected = indexPath
                print(indexPath.row, filteredLanguages)
                cell.configure(withLanguage: arrayOfLanguages[indexPath.row], withCaption: arrayOfCountries[indexPath.row], withFlag: arrayOfIcons[indexPath.row], withSelection: "select_icon")
                cell.selectionStyle = .none
                return cell
            }
            
            cell.configure(withLanguage: arrayOfLanguages[indexPath.row], withCaption: arrayOfCountries[indexPath.row], withFlag: arrayOfIcons[indexPath.row])
            cell.selectionStyle = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard indexPath == currentlySelected else {
            
            let cellClicked = tableView.cellForRow(at: indexPath) as? LanguageCell
            let cellSelected = tableView.cellForRow(at: currentlySelected) as? LanguageCell
            cellSelected?.deselectCell()
            cellClicked?.selectCell()
            currentlySelected = indexPath
            return
        }
    }
}
