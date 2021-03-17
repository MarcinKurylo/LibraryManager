//
//  ManageBookController.swift
//  LibraryManager
//
//  Created by Marcin Kuryło on 16/03/2021.
//

import Cocoa

class ManageBookController: NSViewController, NSTableViewDelegate {
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var bookTitle: NSTextField!
    @IBOutlet weak var bookAuthor: NSTextField!
    @IBOutlet weak var bookReleaseYear: NSTextField!
    @IBOutlet weak var bookPlaceCode: NSTextField!
    var results : [Book] = []
    let realm = RealmModel()
    let inputManager = InputManagerModel()
    @IBAction func searchClicked(_ sender: NSButton) {
        if !inputManager.isValidString(bookTitle) && !inputManager.isValidString(bookAuthor)
            && !inputManager.isValidInt(bookReleaseYear) && !inputManager.isValidString(bookPlaceCode){
            results = realm.search(object: Book.init(), with: nil)
            tableView.reloadData()
        } else {
            let filter = inputManager.makeBookFilter(bookTitle: bookTitle, bookAuthor: bookAuthor, bookReleaseYear: bookReleaseYear, bookShelfCode: bookPlaceCode)
            results = realm.search(object: Book.init(), with: filter)
            inputManager.clearInput(bookTitle)
            inputManager.clearInput(bookAuthor)
            inputManager.clearInput(bookReleaseYear)
            inputManager.clearInput(bookPlaceCode)
            tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.action = #selector(onItemClicked)
    }
    override func viewWillAppear() {
        results = realm.search(object: Book.init(), with: nil)
        tableView.reloadData()
    }
    @objc private func onItemClicked() {
        if (tableView.clickedRow > -1){
            performSegue(withIdentifier: "DisplayBookDetails", sender: tableView.cell)
        }
    }
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        let bookDetailsVC = segue.destinationController as! BookDetailsController
        let row = tableView.clickedRow
        let toSend = results[row]
        bookDetailsVC.book = toSend
        bookDetailsVC.parentVC = self
    }
}
extension ManageBookController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return results.count
    }
    fileprivate enum CellIdentifiers {
        static let IdCell = "BookID"
        static let TitleCell = "BookTitle"
        static let AuthorCell = "BookAuthor"
        static let ReleaseYearCell = "BookReleaseYear"
        static let ShelfCodeCell = "BookShelfCode"
        static let ReservedCell = "BookReserved"
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
        case tableView.tableColumns[3]:
            cellIdentifier = CellIdentifiers.ReleaseYearCell
        case tableView.tableColumns[4]:
            cellIdentifier = CellIdentifiers.ShelfCodeCell
        case tableView.tableColumns[5]:
            cellIdentifier = CellIdentifiers.ReservedCell
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
            case CellIdentifiers.ReleaseYearCell:
                cell.textField?.stringValue = String(results[row].getReleaseYear())
                return cell
            case CellIdentifiers.ShelfCodeCell:
                cell.textField?.stringValue = results[row].getPlaceCode()
                return cell
            case CellIdentifiers.ReservedCell:
                cell.textField?.stringValue = String(results[row].isReserved())
                return cell
            default:
                return nil
            }
        }
        return nil
    }
}


