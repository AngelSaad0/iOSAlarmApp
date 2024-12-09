////
////  TimeZoneTVCell.swift
////  iOSAlarmApp
////
////  Created by Engy on 12/6/24.
////
//
//import UIKit
//
//class TimeZoneTVCell: UITableViewCell {
//    var cityNameLabel: UILabel!
//    var mainContentStackView: UIStackView!
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style , reuseIdentifier: reuseIdentifier)
//        setupUI()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func configure(_ cell: TimeZoneInfo) {
//        cityNameLabel.text = extractCityName(from: cell.text)
//        timeOffsetLabel.text = "Today, \(cell.offset.formatted())HRS"
//        let timeData = calculateCityTime(fromOffset: cell.offset)
//        currentTimeLabel.text = timeData.0
//        timeOfDayLabel.text = timeData.1
//    }
//
//    private func calculateCityTime(fromOffset cityOffset: Double) -> (String, String) {
//        let currentDate = Date()
//        let userTimeZoneOffsetInHours = TimeZone.current.secondsFromGMT(for: currentDate) / 3600
//        let formattedTimeString = TimeFormatter.formatTime(currentDate: currentDate, userOffset: userTimeZoneOffsetInHours, cityOffset: cityOffset)
//        let timeComponents = formattedTimeString.components(separatedBy: " ")
//
//        return (timeComponents[0], timeComponents[1])
//    }
//
//    private func extractCityName(from text: String) -> String {
//        let regexPattern = "\\([^)]*\\)"
//        let cleanedString = text.replacingOccurrences(of: regexPattern, with: "", options: .regularExpression)
//        let result = cleanedString.trimmingCharacters(in: .whitespacesAndNewlines)
//        return result
//    }
//
//    // MARK: - Setup Methods
//    private func setupUI() {
//        setupLabels()
//        setupContainerView()
//        setupConstraints()
//    }
//
//    private func setupLabels() {
//        cityNameLabel = UILabel()
//        cityNameLabel.font = UIFont.systemFont(ofSize: 24, weight: .regular)
//        cityNameLabel.numberOfLines = 1
//        cityNameLabel.lineBreakMode = .byTruncatingTail
//        cityNameLabel.adjustsFontSizeToFitWidth = true
//        cityNameLabel.minimumScaleFactor = 0.5
//        cityNameLabel.textColor = .white
//
//    }
//
//    private func setupContainerView() {
//        contentView.backgroundColor = .black
//
//        cityDetailsStackView = UIStackView()
//        cityDetailsStackView.axis = .vertical
//        cityDetailsStackView.alignment = .fill
//        cityDetailsStackView.spacing = 4
//
//        timeStackView = UIStackView()
//        timeStackView.axis = .horizontal
//        timeStackView.alignment = .bottom
//        timeStackView.spacing = 1
//
//        mainContentStackView = UIStackView()
//        mainContentStackView.axis = .horizontal
//        mainContentStackView.alignment = .center
//        mainContentStackView.spacing = 20
//    }
//
//    private func setupConstraints() {
//        cityDetailsStackView.addArrangedSubview(timeOffsetLabel)
//        cityDetailsStackView.addArrangedSubview(cityNameLabel)
//
//        timeStackView.addArrangedSubview(currentTimeLabel)
//        timeStackView.addArrangedSubview(timeOfDayLabel)
//
//        mainContentStackView.addArrangedSubview(cityDetailsStackView)
//        mainContentStackView.addArrangedSubview(timeStackView)
//
//        contentView.addSubview(mainContentStackView)
//
//        mainContentStackView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            mainContentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            mainContentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//            mainContentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
//            mainContentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
//        ])
//    }
//}
