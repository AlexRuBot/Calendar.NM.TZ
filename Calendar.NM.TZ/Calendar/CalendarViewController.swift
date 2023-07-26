//
//  CalendarViewController.swift
//  Calendar.NM.TZ
//
//  Created by Александр Гужавин on 25.07.2023.
//

import UIKit
import SnapKit

class CalendarViewController: UIViewController {
    
    private let barTitle: UILabel = {
        let lable = UILabel()
        lable.text = "Event Calendar"
        lable.textColor = .systemGray
        lable.font = .boldSystemFont(ofSize: 18)
        return lable
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(EventTableViewCell.self, forCellReuseIdentifier: EventTableViewCell.identifier)
        return tableView
    }()
    
    private let calendarView: UICalendarView = {
        let calendarView = UICalendarView()
        calendarView.backgroundColor = .secondarySystemBackground
        calendarView.layer.cornerRadius = 10
        calendarView.tintColor = UIColor.systemTeal
        calendarView.calendar = .current
        return calendarView
    }()
    
    var filterEvents: [Event] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        calendarView.delegate = self
        calendarView.selectionBehavior = dateSelection
        tableView.dataSource = self
        tableView.delegate = self
        view.backgroundColor = .white
        setupNavigationItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        calendarView.reloadDecorations(forDateComponents: DateDataBase.shared.dateComponents, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addViews()
        addConstraints()
        
    }
    
    private func setupNavigationItems() {
        navigationItem.titleView = barTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(addTapped))
        navigationItem.rightBarButtonItem?.tintColor = .black
        navigationItem.title = ""
    }
    
    private func addViews() {
        view.addSubview(calendarView)
        view.addSubview(tableView)
    }
    
    private func addConstraints() {
        calendarView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().inset(15)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(calendarView.snp.bottom).offset(18)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().inset(18)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    @objc func addTapped() {
        navigationController?.pushViewController(AddEventViewController(), animated: true)
    }
    
}

extension CalendarViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        guard let dateComponents = dateComponents else { return }
        print(dateComponents)
        filterEvents = DateDataBase.shared.filter(date: dateComponents)
        tableView.reloadData()
    }
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, canSelectDate dateComponents: DateComponents?) -> Bool {
        true
    }
}

extension CalendarViewController: UICalendarViewDelegate {
    
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        
        guard DateDataBase.shared.contains(date: dateComponents) else { return .none }
        
        return .image(UIImage(systemName: "noname"))
    }
}

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filterEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EventTableViewCell.identifier, for: indexPath) as! EventTableViewCell
        let event = filterEvents[indexPath.row]
        cell.setupCell(title: event.title,
                       time: "\(event.date.hour ?? 00):\(event.date.minute ?? 00)")
        return cell
    }
    
    
}
