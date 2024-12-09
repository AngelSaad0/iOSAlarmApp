//
//  TimeZoneViewController.swift
//  iOSAlarmApp
//
//  Created by Engy on 12/6/24.
//


import UIKit
import IQKeyboardManagerSwift

class TimeZoneViewController: UIViewController {
    // MARK: - UI Components
    private var tableView: UITableView!
    private var titleLabel: UILabel!
    private var searchBar: UISearchBar!

    // MARK: - Properties
    private let timeZoneManager = TimeZoneManager()
    private var timeZoneList: [TimeZoneInfo] = []
    private var filteredTimeZoneList: [TimeZoneInfo] = [] {
        didSet {
            handleEmptyList(isEmptyList: timeZoneList.isEmpty)
            tableView.reloadData()
        }
    }
    var bindResult: (()->())?
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        setupConstraints()
    }
}
// MARK: - Helper
extension TimeZoneViewController {

    private func handleEmptyList(isEmptyList:Bool) {
        isEmptyList ? tableView.displayEmptyMessage(.worldClockEmptyList) : tableView.removeEmptyMessage()
    }

    private func extractCityName(from text: String) -> String {
        let regexPattern = "\\([^)]*\\)"
        let cleanedString = text.replacingOccurrences(of: regexPattern, with: "", options: .regularExpression)
        return cleanedString.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

// MARK: - UI Setup
extension TimeZoneViewController {
    private func setupUI() {
        configureKeyboardManager()
        setupLabels()
        setupSearchBar()
        setupTableView()
        loadTimeZones()
    }

    private func setupLabels() {
        titleLabel = UILabel()
        titleLabel.text = "Choose a City"
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
    }

    private func setupSearchBar() {
        searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = .minimal
        searchBar.showsCancelButton = true
        searchBar.delegate = self
        if let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton {
            cancelButton.isEnabled = true
        }
        view.addSubview(searchBar)
    }

    private func setupTableView() {
        tableView = UITableView()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }

    private func configureKeyboardManager() {
        IQKeyboardManager.shared.resignOnTouchOutside = true
        IQKeyboardManager.shared.keyboardDistance = 10
        IQKeyboardManager.shared.layoutIfNeededOnUpdate = true
    }

    private func loadTimeZones() {
        if let timeZones = timeZoneManager.loadTimeZones() {
            timeZoneList = timeZones
            filteredTimeZoneList = timeZones
        } else {
            timeZoneList = []
            filteredTimeZoneList = []
        }
    }
}

// MARK: - Constraints Setup
extension TimeZoneViewController {
    private func setupConstraints() {
        setLabelConstraints()
        setSearchBarConstraints()
        setTableViewConstraints()
    }

    private func setLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }

    private func setSearchBarConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func setTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: 20)
        ])
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource
extension TimeZoneViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTimeZoneList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        let cityName = extractCityName(from: filteredTimeZoneList[indexPath.row].text)
        cell.textLabel?.text = cityName
        cell.textLabel?.lineBreakMode = .byTruncatingTail
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        CoreDataManager.shared.saveTimeZoneItem(cityItem: filteredTimeZoneList[indexPath.row])
        bindResult?()
        dismiss(animated: true)
    }
}

// MARK: - UISearchBarDelegate
extension TimeZoneViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredTimeZoneList = timeZoneList
        } else {
            filteredTimeZoneList = timeZoneList.filter {
                $0.text.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismiss(animated: true)
    }

}
