//
//  TitleTextField.swift
//  Calendar.NM.TZ
//
//  Created by Александр Гужавин on 26.07.2023.
//

import UIKit
import SnapKit

class TitleTextField: UITextField {
    
    private let lable: UILabel = {
       let lable = UILabel()
        lable.textColor = .systemGray
        lable.font = .boldSystemFont(ofSize: 14)
        return lable
    }()
    
    private let datePicker = UIDatePicker()

    init(title: String, with picker: Bool = false, pickerMode: UIDatePicker.Mode = .dateAndTime) {
        super .init(frame: .zero)
        lable.text = title
        
        if picker {
            self.inputView = datePicker
            datePicker.locale = Locale.current
            datePicker.datePickerMode = pickerMode
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.timeZone = .current
        }

        self.borderStyle = .roundedRect
        self.backgroundColor = .systemGray6
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(lable)
        lable.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.bottom.equalTo(self.snp.top).offset(-4)
        }
    }
    
    func addTargetPicker(target: Any, action: Selector) {
        datePicker.addTarget(target, action: action, for: .valueChanged)
    }
    
}
