//
//  LanguageCell.swift
//  LanguagePicker
//
//  Created by Admin on 12.10.23.
//

import UIKit

class LanguageCell: UITableViewCell {

    static let identifier = "LanguageCell"
    
    private let labelLanguage: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 15, weight: .light)
        lbl.textColor = .systemGray
        return lbl
    }()
    
    private let labelCountry: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 9, weight: .light)
        lbl.textColor = .systemGray
        return lbl
    }()
    
    private let flag = UIImageView()
    private let select = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addSubview(flag)
        addSubview(labelLanguage)
        addSubview(labelCountry)
        addSubview(select)
        
        flag.snp.makeConstraints(){
            $0.left.equalTo(20)
            $0.centerY.equalToSuperview()
            $0.height.width.equalTo(30)
        }
        
        labelLanguage.snp.makeConstraints(){
            $0.top.equalToSuperview().offset(5)
            $0.left.equalTo(flag).offset(40)
        }
        
        labelCountry.snp.makeConstraints(){
            $0.top.equalTo(labelLanguage.snp.bottom)
            $0.left.equalTo(flag).offset(40)
        }
        
        select.snp.makeConstraints(){
            $0.right.equalTo(-20)
            $0.centerY.equalToSuperview()
            $0.height.width.equalTo(20)
        }
    }
    
    func configure(withLanguage language: String, withCaption caption: String, withFlag icon: String) {
        labelLanguage.text = language
        labelCountry.text = caption
        flag.image = UIImage(named: icon)
    }
    
    func configure(withLanguage language: String, withCaption caption: String, withFlag icon: String, withSelection iconSelect: String) {
        labelLanguage.text = language
        labelCountry.text = caption
        flag.image = UIImage(named: icon)
        select.image = UIImage(named: iconSelect)
    }
    
    public func selectCell() {
        Settings.sellectedLanguage = labelLanguage.text
        labelLanguage.textColor = .black
        labelCountry.textColor = .black
        select.image = UIImage(named: "select_icon")
    }
    
    public func deselectCell() {
        labelLanguage.textColor = .systemGray
        labelCountry.textColor = .systemGray
        select.image = nil
    }

}


