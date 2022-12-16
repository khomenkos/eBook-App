# EBook App

![](https://badgen.net/badge/iOS/16/blue) ![](https://badgen.net/badge/Swift/5.7/orange)

- **All data is fetched from API:** [Google Books API](https://developers.google.com/books) 
___

## About
A simple Book Search App using the public API.

<img src="./Screenshots/ScreenShot.png"/>

 - Home screen - shows a list of recommended books.
 - Detail screen - shows information about the selected book.
 - Search screen - search for books by title or author.
 - My Books screen - shows a list of books that the user marked as favorites. 

## Features
- UI Framework: UIKit
- UI layout: Programmatically
- Architecture pattern: MVC
- Favorite list using User Defaults.
- PdfKit for reading books by link.
- WebKit to buy a book or view additional information.
- Search filtering.
- Sorting by relevance/newest.

## Third Party Libraries

- **[SDWebImage](https://github.com/SDWebImage/SDWebImage):** For handling downloading, displaying and caching photos given an url.
- **[ProgressHUD](https://github.com/relatedcode/ProgressHUD):** A convenient way to show a loading indicator while our network request is pending.
