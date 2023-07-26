//
//  EventTableViewCell.swift
//  Calendar.NM.TZ
//
//  Created by Александр Гужавин on 26.07.2023.
//

import UIKit
import SnapKit

class EventTableViewCell: UITableViewCell {
    
    public static let identifier = "EventTableViewCell"

    private let titleLable: UILabel = {
        let lable = UILabel()
        lable.font = .boldSystemFont(ofSize: 18)
        lable.numberOfLines = 1
        return lable
    }()
    
    private let timeLable: UILabel = {
        let lable = UILabel()
        lable.font = .boldSystemFont(ofSize: 18)
        return lable
    }()
    
    private let eventTypeView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 2
        return view
    }()
    
    func setupCell(title: String, time: String) {
        self.titleLable.text = title
        self.timeLable.text = time
        
        contentView.addSubview(titleLable)
        contentView.addSubview(timeLable)
        contentView.addSubview(eventTypeView)
        self.selectionStyle = .none
        
        contentView.layer.cornerRadius = 15
        contentView.backgroundColor = .systemGray6
        
        eventTypeView.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.width.equalTo(4)
        }
        
        titleLable.snp.makeConstraints { make in
            make.left.equalTo(eventTypeView.snp.right).offset(8)
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
        }
        timeLable.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
    }

    
}
