//
//  AddEventViewController.swift
//  Calendar.NM.TZ
//
//  Created by Александр Гужавин on 25.07.2023.
//

import UIKit

class AddEventViewController: UIViewController {
    
    private let eventNameTextField: TitleTextField = TitleTextField(title: "Event title")
    private let dateTextField: TitleTextField = TitleTextField(title: "Date",
                                                               with: true)
    private let timeTExtField: TitleTextField = TitleTextField(title: "Time")
    
    private var dateComponents: DateComponents?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationItems()
        timeTExtField.isEnabled = false
        dateTextField.addTargetPicker(target: self, action: #selector(setDate(picker:)))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addViews()
        addConstraints()
    }
    
    private func setupNavigationItems() {
        let barTitle: UILabel = {
            let lable = UILabel()
            lable.text = "Event Calendar"
            lable.textColor = .systemGray
            lable.font = .boldSystemFont(ofSize: 18)
            return lable
        }()
        
        navigationItem.titleView = barTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem?.tintColor = .systemBlue
    }
    
    
    private func addViews() {
        view.addSubview(eventNameTextField)
        view.addSubview(dateTextField)
        view.addSubview(timeTExtField)
    }
    
    private func addConstraints() {
        eventNameTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(32)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().inset(16)
        }
        
        dateTextField.snp.makeConstraints { make in
            make.top.equalTo(eventNameTextField.snp.bottom).offset(32)
            make.left.equalToSuperview().inset(16)
            make.right.equalTo(view.snp.centerX).offset(50)
        }
        
        timeTExtField.snp.makeConstraints { make in
            make.top.equalTo(dateTextField.snp.top)
            make.left.equalTo(dateTextField.snp.right).offset(16)
            make.right.equalToSuperview().inset(16)
        }
    }
    
    
    @objc private func addTapped() {
        guard let dateComponents = self.dateComponents else { return }
        let event = Event(title: eventNameTextField.text!, date: dateComponents)
        DateDataBase.shared.add(event: event)
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func setDate(picker: UIDatePicker) {
        
        dateComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: picker.date)
        
        let dateFormat = DateFormatter()
        let timeFormat = DateFormatter()
        
        dateFormat.dateFormat = "dd.MM.yyyy"
        timeFormat.dateFormat = "HH:mm"

        timeTExtField.text = timeFormat.string(from: picker.date)
        dateTextField.text = dateFormat.string(from: picker.date)
    }
    
}
