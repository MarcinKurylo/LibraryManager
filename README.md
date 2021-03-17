# LibraryManager

MacOS app designed to help with library management.
Local data persistance provided with realm database.

<img src="./images/main.png" width="250" height="250">

# Functionalities

* Create Reader and Book
* Read Reader and Book (search by one ore more key)
* Update Reader and Book
* Delete Reader and Book

## Create

<img src="./images/addBook.png" width="250" height="250">  <img src="./images/addBook.png" width="250" height="250">

## Read

<img src="./images/manageBook.png" width="250" height="250">  <img src="./images/manageReaderb4.png" width="250" height="250"> <img src="./images/manageReader.png" width="250" height="250">

To displayt more detailed information - click on a cell

<img src="./images/readerDetails.png" width="250" height="250">

## Update

You can easily edit user or book info in detailed view.
User can also add a book to reader account (maximum amount of borrowed books == 5)

<img src="./images/borrowBook.png" width="250" height="250">

## Delete

Reader may be deleted from db if the reader doesn't have any borrowed books assigned to accout.
Book can be dropped if isn't owned by any user.
