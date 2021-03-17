//
//  AddUserController.swift
//  LibraryManager
//
//  Created by Marcin Kuryło on 15/03/2021.
//

import Cocoa

class AddUserController: NSViewController {
    @IBOutlet weak var userFirstName: NSTextField!
    @IBOutlet weak var userLastName: NSTextField!
    let realm = RealmModel()
    let inputManager = InputManagerModel()
    @IBAction func addUser(_ sender: NSButton) {
        if inputManager.isValidString(userFirstName) && inputManager.isValidString(userLastName) {
            let userFirst = inputManager.getInput(userFirstName)
            let userLast = inputManager.getInput(userLastName)
            inputManager.clearInput(userFirstName)
            inputManager.clearInput(userLastName)
            realm.addReader(firstName: userFirst, lastName: userLast)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
}
