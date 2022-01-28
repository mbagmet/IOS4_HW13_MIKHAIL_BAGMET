//
//  AlbumViewControllerNavBarMenu.swift
//  IOS4_HW13_MIKHAIL_BAGMET
//
//  Created by Михаил on 25.01.2022.
//

import UIKit

extension AlbumsViewController {

    // MARK : - Navigation bar menu

    func createMenu() -> UIMenu {
        let addAlbum = UIAction(title: "Новый альбом", image: UIImage(systemName: "rectangle.stack.badge.plus")) { _ in }
        let addFolder = UIAction(title: "Новая папка", image: UIImage(systemName: "plus.rectangle.on.folder")) { _ in }
        let addCommonAlbum = UIAction(title: "Новый общий альбом", image: UIImage(systemName: "rectangle.stack.badge.person.crop")) { _ in }

        let menu = UIMenu(title: "", children: [addAlbum, addFolder, addCommonAlbum])
        return menu
    }
}
