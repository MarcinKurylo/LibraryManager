//
//  BorrowOrReturnController.swift
//  LibraryManager
//
//  Created by Marcin Kuryło on 17/03/2021.
//

import Cocoa
class BorrowOrReturnController: NSViewController {
    let realm = RealmModel()
    let inputManager = InputManagerModel()
    var parentVC : ReaderDetailsController?
    var actionText : String?
    var reader : Reader?
    var actionTag : Int?
    var bookResults : [Book] = []
    @IBOutlet weak var actionLabel: NSTextField!
    @IBOutlet weak var bookID: NSTextField!
    @IBOutlet weak var bookTitle: NSTextField!
    @IBOutlet weak var message: NSTextField!
    @IBAction func proceedAction(_ sender: Any) {
        if actionTag==1 {
            addBook()
        } else {
            removeBook()
        }
    }
    @IBAction func cancelAction(_ sender: Any) {
        self.view.window?.close()
    }
    func addBook(){
        if !inputManager.isValidString(bookID) && !inputManager.isValidString(bookTitle){
            message.stringValue = "Pass any book detail"
            message.textColor = NSColor.red
        } else {
            let filter = inputManager.makeBookFilter(bookID: bookID, bookTitle: bookTitle)
            bookResults = realm.search(object: Book.init(), with: filter)
            inputManager.clearInput(bookID)
            inputManager.clearInput(bookTitle)
            if bookResults.count > 0 {
                let toAdd = bookResults[0]
                let finishWithSuccess = realm.addReaderBooks(reader: reader!, book: toAdd)
                if finishWithSuccess {
                    message.stringValue = "Book successfully added to account. Fetch a book from \(toAdd.getPlaceCode())"
                    message.textColor = NSColor.green
                    parentVC?.results.append(toAdd)
                    parentVC?.tableView.reloadData()
                } else {
                    message.stringValue = "Reader can't borrow more than five books"
                    message.textColor = NSColor.red
                }
            }
        }
    }
    func removeBook(){
        if !inputManager.isValidString(bookID) && !inputManager.isValidString(bookTitle){
            message.stringValue = "Pass any book detail"
            message.textColor = NSColor.red
        } else {
            let id = inputManager.getInput(bookID)
            let title = inputManager.getInput(bookTitle)
            let toRemove = reader?.books.first(where: {$0.id == id || $0.title == title})
            if let foundToRemove = toRemove {
                realm.deleteReaderBooks(reader: reader!, book: foundToRemove)
                inputManager.clearInput(bookID)
                inputManager.clearInput(bookTitle)
                message.stringValue = "Book successfully removed from account. Return book to \(foundToRemove.getPlaceCode())"
                message.textColor = NSColor.green
                parentVC?.results.removeAll(where: {$0.id == foundToRemove.id})
                parentVC?.tableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let action = actionText {
            actionLabel.stringValue = action
        }
    }
    
}
