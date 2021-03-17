//
//  MenuViewController.swift
//  LibraryManager
//
//  Created by Marcin Kuryło on 15/03/2021.
//

import Cocoa

class MenuViewController: NSViewController {

    @IBAction func goHome(_ sender: NSButton) {
        let detailView = parent?.children[1] as? DetailViewController?
        detailView??.selectedTabViewItemIndex = 0
    }
    @IBAction func goAddUser(_ sender: NSButton) {
        let detailView = parent?.children[1] as? DetailViewController?
        detailView??.selectedTabViewItemIndex = 1
    }
    @IBAction func goManageUser(_ sender: NSButton) {
        let detailView = parent?.children[1] as? DetailViewController?
        detailView??.selectedTabViewItemIndex = 2
    }
    @IBAction func goAddBook(_ sender: NSButton) {
        let detailView = parent?.children[1] as? DetailViewController?
        detailView??.selectedTabViewItemIndex = 3
    }
    @IBAction func goManageBook(_ sender: NSButton) {
        let detailView = parent?.children[1] as? DetailViewController?
        detailView??.selectedTabViewItemIndex = 4
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
