//
//  ReaderDetailsController.swift
//  LibraryManager
//
//  Created by Marcin Kuryło on 16/03/2021.
//

import Cocoa
import RealmSwift

class ReaderDetailsController: NSViewController, NSTableViewDelegate {
    var reader : Reader?
    let realm = RealmModel()
    let inputManager = InputManagerModel()
    var parentVC : ManageReaderController?
    var results : [Book] = []
    @IBOutlet weak var message: NSTextField!
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var readerFirst: NSTextField!
    @IBOutlet weak var readerLast: NSTextField!
    @IBAction func updateReader(_ sender: NSButton) {
        let first = inputManager.isValidString(readerFirst) ? readerFirst.stringValue : nil
        let last = inputManager.isValidString(readerLast) ? readerLast.stringValue : nil
        realm.updateReader(reader: reader!, firstName: first, lastName: last)
        parentVC?.tableView.reloadData()
        message.stringValue = "Updated successfully!"
        message.textColor = NSColor.green
    }
    @IBAction func deleteReader(_ sender: Any) {
        if (reader?.books.count == 0){
            parentVC?.results.removeAll(where: {$0.id == reader?.id})
            realm.deleteReader(reader: reader!)
            parentVC?.tableView.reloadData()
            self.view.window?.close()
        }
        message.stringValue = "Cannot delete user with borrowed books!"
        message.textColor = NSColor.red
    }
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        let sender = sender as! NSButton
        let borrowOrReadVC = segue.destinationController as! BorrowOrReturnController
        borrowOrReadVC.parentVC = self
        borrowOrReadVC.reader = reader
        switch sender.tag{
        case 1:
            borrowOrReadVC.actionText = "Add book to reader account"
            borrowOrReadVC.actionTag = 1
        case 2:
            borrowOrReadVC.actionText = "Delete book from reader account"
            borrowOrReadVC.actionTag = 2
        default:
            borrowOrReadVC.actionText = nil
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        results = Array(reader!.books)
        tableView.reloadData()
        if let r = reader {
            readerFirst.stringValue = r.firstName
            readerLast.stringValue = r.lastName
        }
        message.stringValue = ""
    }
}
extension ReaderDetailsController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return results.count
    }
    fileprivate enum CellIdentifiers {
        static let IdCell = "BookID"
        static let TitleCell = "BookTitle"
        static let AuthorCell = "BookAuthor"
    }
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var cellIdentifier : String?
        switch tableColumn{
        case tableView.tableColumns[0]:
            cellIdentifier = CellIdentifiers.IdCell
        case tableView.tableColumns[1]:
            cellIdentifier = CellIdentifiers.TitleCell
        case tableView.tableColumns[2]:
            cellIdentifier = CellIdentifiers.AuthorCell
        default:
            cellIdentifier = nil
        }
        if let cell = tableView.makeView(withIdentifier:NSUserInterfaceItemIdentifier(rawValue: cellIdentifier!), owner: nil) as? NSTableCellView {
            switch cellIdentifier{
            case CellIdentifiers.IdCell:
                cell.textField?.stringValue = results[row].id
                return cell
            case CellIdentifiers.TitleCell:
                cell.textField?.stringValue = results[row].getTitle()
                return cell
            case CellIdentifiers.AuthorCell:
                cell.textField?.stringValue = results[row].getAuthor()
                return cell
            default:
                return nil
            }
        }
        return nil
    }
    
}

