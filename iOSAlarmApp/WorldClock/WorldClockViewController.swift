//
//  WorldClockViewController.swift
//  iOSAlarmApp
//
//  Created by Engy on 12/6/24.
//


import UIKit

class WorldClockViewController: UIViewController {
    // MARK: - UI Components
    private var tableView: UITableView!
    private var addButton: UIBarButtonItem!
    private var editButton: UIBarButtonItem!

    // MARK: - Properties
    private let timeZoneManager = TimeZoneManager()
    private var coreDataManager = CoreDataManager.shared
    private var isEditingButton = false
    private var timeZoneList: [TimeZoneInfo] = [] {
        didSet {
            handleEmptyList(isEmpty: timeZoneList.isEmpty)
            tableView.reloadData()
        }
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadTimeZones()
    }

    // MARK: - Setup Methods
    private func setupUI() {
        setupNavigationButtons()
        setupTableView()
        setupConstraints()
    }
    // MARK: - Actions
    @objc private func addButtonClicked() {
        let timeZoneVC = TimeZoneViewController()
        timeZoneVC.bindResult = {
            self.loadTimeZones()
        }
        present(timeZoneVC, animated: true)
    }

    @objc private func editButtonClicked() {
        isEditingButton.toggle()
        editButton.title = isEditingButton ? "Done" : "Edit"
        tableView.isEditing = isEditingButton
    }
}
// MARK: - Helper Method
extension WorldClockViewController {
    private func loadTimeZones() {
        timeZoneList = coreDataManager.fetchItems()
        tableView.reloadData()
    }

    private func handleEmptyList(isEmpty: Bool) {
        if isEmpty {
            tableView.displayEmptyMessage(.worldClockEmptyList)
        } else {
            tableView.removeEmptyMessage()
        }
    }

    private func setupNavigationButtons() {
        addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))
//        editButton = UIBarButtonItem(title: "Edit",style: .plain, target: self, action: #selector(editButtonClicked))
        navigationItem.rightBarButtonItem = addButton
        navigationItem.leftBarButtonItem = editButtonItem

    }

    private func setupTableView() {
        tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }

    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20)
        ])
    }
}


// MARK: - UITableViewDelegate and UITableViewDataSource
extension WorldClockViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeZoneList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = WorldClockTVCell(style: .default, reuseIdentifier: "cell")
        cell.configure(timeZoneList[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            coreDataManager.deleteItem(city: timeZoneList[indexPath.row].text)
//            timeZoneList.remove(at: indexPath.row)
//        }
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

//    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        let movedItem = data[sourceIndexPath.section].sectionNames[sourceIndexPath.row]
//        data[sourceIndexPath.section].sectionNames.remove(at: sourceIndexPath.row)
//        data[destinationIndexPath.section].sectionNames.insert(movedItem, at: destinationIndexPath.row)
//        tableView.reloadData()
//    }
}
