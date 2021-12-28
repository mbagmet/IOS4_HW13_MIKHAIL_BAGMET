//
//  AppDelegate.swift
//  IOS4_HW13_MIKHAIL_BAGMET
//
//  Created by Михаил on 27.12.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let tabBarController = UITabBarController()

        // MARK: - "Media Libruary" tab
        let mediaLibruaryViewController = MediaLibruaryViewController()
        let mediaLibruaryNavigationController = UINavigationController(rootViewController: mediaLibruaryViewController)
        mediaLibruaryViewController.tabBarItem = UITabBarItem(title: MediaLibruaryViewController.Strings.navigationTitle,
                                                              image: UIImage(systemName: "photo.fill.on.rectangle.fill"),
                                                              tag: 0)

        // MARK: - "For You" tab
        let forYouViewController = ForYouViewController()
        let forYouNavigationController = UINavigationController(rootViewController: forYouViewController)
        forYouViewController.tabBarItem = UITabBarItem(title: ForYouViewController.Strings.navigationTitle,
                                                       image: UIImage(systemName: "heart.text.square.fill"),
                                                       tag: 1)

        // MARK: - "Albums" tab
        let albumsLayout = UICollectionViewLayout()
        let albumsCollectionViewController = AlbumsCollectionViewController(collectionViewLayout: albumsLayout)
        let albumsNavigationController = UINavigationController(rootViewController: albumsCollectionViewController)
        albumsCollectionViewController.tabBarItem = UITabBarItem(title: AlbumsCollectionViewController.Strings.navigationTitle,
                                                       image: UIImage(systemName: "rectangle.stack.fill"),
                                                       tag: 2)

        // MARK: - "Search" tab
        let searchViewController = SearchViewController()
        let searchNavigationController = UINavigationController(rootViewController: searchViewController)
        searchViewController.tabBarItem = UITabBarItem(title: SearchViewController.Strings.navigationTitle,
                                                       image: UIImage(systemName: "magnifyingglass"),
                                                       tag: 3)

        // MARK: - tabBarController settings
        tabBarController.setViewControllers([
            mediaLibruaryNavigationController,
            forYouNavigationController,
            albumsNavigationController,
            searchNavigationController
        ], animated: true)

        tabBarController.selectedIndex = 2

        // MARK: - window settings
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()

        return true
    }
}

