//
//  mainTabBarController.swift
//  iOSAlarmApp
//
//  Created by Engy on 12/6/24.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTabBarAppearance()
    }

    // MARK: -  Setup UI for Main TabBar
    private func setupUI() {
        let worlVC = createViewController(.worldClock)
        let alramVC = createViewController(.alram)
        let stopVC = createViewController(.stopWatch)
        let timerVC = createViewController(.timer)

        viewControllers = [worlVC, alramVC, stopVC, timerVC]
    }

    // MARK: -  Create ViewController
    private func createViewController(_ screenType: TabScreenType) -> UIViewController {
        let viewController = screenType.viewControllerType.init()
        let navigationController = UINavigationController(rootViewController: viewController)
        viewController.title = screenType.tabTitle
        viewController.tabBarItem.image = UIImage(systemName: screenType.tabIcon)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.tintColor = .orange
        return navigationController
    }

    // MARK: -  Setup TabBar Appearance
    private func setupTabBarAppearance() {
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .orange
        
        // Customize tab bar appearance
        tabBar.tintColor = UIColor.orange  // Icon and text color for selected items
        tabBar.unselectedItemTintColor = UIColor.gray // Icon and text color for unselected items
        tabBar.backgroundColor = UIColor.black
        tabBar.barTintColor = UIColor.black
        tabBar.isTranslucent = false
    }
    enum TabScreenType {
        case worldClock
        case alram
        case stopWatch
        case timer

        var tabTitle: String {
            switch self {
            case .worldClock: "World Clock"
            case .alram: "Alram"
            case .stopWatch: "StopWatch"
            case .timer: "Timer"
            }
        }

        var tabIcon: String {
            switch self {
            case .worldClock: "globe"
            case .alram: "alarm.fill"
            case .stopWatch: "stopwatch.fill"
            case .timer: "timer"
            }
        }

        var viewControllerType: UIViewController.Type {
            switch self {
            case .worldClock: WorldClockViewController.self
            case .alram: AlarmViewController.self
            case .stopWatch: StopwatchViewController.self
            case .timer: TimerViewController.self
            }
        }

    }

}


