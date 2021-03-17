//
//  MainController.swift
//  LibraryManager
//
//  Created by Marcin Kuryło on 15/03/2021.
//

import Cocoa

class MainController: NSSplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let detailView = parent?.children[1] as? NSTabViewController?
        detailView??.selectedTabViewItemIndex = 1
    }
    
}
