//
//  AddBookController.swift
//  LibraryManager
//
//  Created by Marcin Kuryło on 16/03/2021.
//

import Cocoa

class AddBookController: NSViewController {
    @IBOutlet weak var bookTitle: NSTextField!
    @IBOutlet weak var bookAuthor: NSTextField!
    @IBOutlet weak var bookReleaseYear: NSTextField!
    @IBOutlet weak var bookPlaceCode: NSTextField!
    let realm = RealmModel()
    let inputManager = InputManagerModel()
    @IBAction func addBook(_ sender: NSButton) {
        if inputManager.isValidString(bookTitle) && inputManager.isValidString(bookAuthor)
            && inputManager.isValidInt(bookReleaseYear) && inputManager.isValidString(bookPlaceCode){
            let title = inputManager.getInput(bookTitle)
            let author = inputManager.getInput(bookAuthor)
            let releaseYear = inputManager.getInput(bookReleaseYear)
            let placeCode = inputManager.getInput(bookPlaceCode)
            inputManager.clearInput(bookTitle)
            inputManager.clearInput(bookAuthor)
            inputManager.clearInput(bookReleaseYear)
            inputManager.clearInput(bookPlaceCode)
            realm.addBook(title: title, author: author, releaseYear: releaseYear, placeCode: placeCode)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
}
