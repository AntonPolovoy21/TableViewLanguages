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
    
    private var currentlySelected = IndexPath()
    private var defaultLang = Settings.sellectedLanguage ?? "English(US)"
    
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Choose language"
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 20)
        return lbl
    }()
    
    private lazy var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manageSubviews()
    }

    private func manageSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        
        titleLabel.snp.makeConstraints(){
            $0.top.equalTo(60)
            $0.centerX.equalTo(view)
        }
        
        tableView.snp.makeConstraints(){
            $0.top.equalTo(titleLabel).offset(60)
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
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return arrayOfLanguages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LanguageCell.identifier) as? LanguageCell else {return UITableViewCell()}
        
        guard arrayOfLanguages[indexPath.row] != defaultLang else {
            currentlySelected = indexPath
            cell.configure(withLanguage: arrayOfLanguages[indexPath.row], withCaption: arrayOfCountries[indexPath.row], withFlag: arrayOfIcons[indexPath.row], withSelection: "select_icon")
            cell.selectionStyle = .none
            return cell
        }
        
        cell.configure(withLanguage: arrayOfLanguages[indexPath.row], withCaption: arrayOfCountries[indexPath.row], withFlag: arrayOfIcons[indexPath.row])
        cell.selectionStyle = .none
        
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
