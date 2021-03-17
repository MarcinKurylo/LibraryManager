//
//  BookDetailsController.swift
//  LibraryManager
//
//  Created by Marcin Kuryło on 17/03/2021.
//

import Cocoa

class BookDetailsController: NSViewController {
    
    let realm = RealmModel()
    let inputManager = InputManagerModel()
    @IBOutlet weak var windowHeader: NSTextField!
    @IBOutlet weak var bookTitle: NSTextField!
    @IBOutlet weak var bookAuthor: NSTextField!
    @IBOutlet weak var bookReleaseYear: NSTextField!
    @IBOutlet weak var bookShelfCode: NSTextField!
    @IBOutlet weak var message: NSTextField!
    var book : Book?
    var parentVC : ManageBookController?
    @IBAction func updateBook(_ sender: NSButton) {
        if !(book?.isReserved())!{
            let title = inputManager.isValidString(bookTitle) ? bookTitle.stringValue : nil
            let author = inputManager.isValidString(bookAuthor) ? bookAuthor.stringValue : nil
            let releaseYear = inputManager.isValidInt(bookReleaseYear) ? Int(bookReleaseYear.stringValue) : nil
            let shelfCode = inputManager.isValidString(bookShelfCode) ? bookShelfCode.stringValue : nil
            realm.updateBook(book: book!, title: title, author: author, releaseYear: releaseYear, placeCode: shelfCode)
            parentVC?.tableView.reloadData()
            message.stringValue = "Successfully updated!"
            message.textColor = NSColor.green
        } else {
            message.stringValue = "Cannot update reserved book!"
            message.textColor = NSColor.red
        }
    }
    @IBAction func deleteBook(_ sender: NSButton) {
        if !(book?.isReserved())!{
            parentVC?.results.removeAll(where: {$0.id == book?.id})
            realm.deleteBook(book: book!)
            parentVC?.tableView.reloadData()
            self.view.window?.close()
        } else {
            message.stringValue = "Cannot delete reserved book!"
            message.textColor = NSColor.red
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let b = book {
            bookTitle.stringValue = b.getTitle()
            bookAuthor.stringValue = b.getAuthor()
            bookReleaseYear.stringValue = String(b.getReleaseYear())
            bookShelfCode.stringValue = b.getPlaceCode()
            if b.isReserved(){
                windowHeader.stringValue = "Book details (book is currently unavailable)"
            } else {
                windowHeader.stringValue = "Book details (book available)"
            }
            message.stringValue = ""
        }
    }
}
