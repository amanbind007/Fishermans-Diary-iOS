# Fishermans-Diary
Fishermans Diary ia Simple and Minimal notes app for fishers to save fish information(like notes and count) they caught or search for fishes using Fishbase.org(thanks to fishbase) to know their habitat, diet, location, enviroment, size and many more.

## Special Thanks
I have created this after learning various concepts from the NYTimes app by TheCodeMonks

## ⛓ Features
<table style="width:100%">
  <tr>
    <th>Searching for fish various filter options</th>
    <th>Infinte Scrolling</th> 
  </tr>
  <tr>
    <td><img src="https://github.com/amanbind007/Fishermans-Diary-iOS/blob/main/Screenshots/search%20fish%20with%20filter.gif?raw=true" width=250 height=600 /></td> 
    <td><img src="https://github.com/amanbind007/Fishermans-Diary-iOS/blob/main/Screenshots/infinite%20scrolling.gif?raw=true" width=250 height=600 /></td> 
  </tr>
  <tr>
    <th>Web View for Detailed Fish Info</th>
    <th>Adding fishes to 'My Fish List'</th> 
  </tr>
  <tr>
    <td><img src="https://github.com/amanbind007/Fishermans-Diary-iOS/blob/main/Screenshots/fish%20web%20view%20info.gif?raw=true" width=250 height=600 /></td>
    <td><img src="https://github.com/amanbind007/Fishermans-Diary-iOS/blob/main/Screenshots/Add%20Fish%20to%20My%20Fish%20List.gif?raw=true" width=250 height=600 /></td>
  </tr>
    <tr>
    <th>Searching for fishes in 'My Fish List' using various Filter and Sort Options</th>
    <th>Updating Fishes in 'My Fish List'</th> 
  </tr>
  <tr>
    <td><img src="https://github.com/amanbind007/Fishermans-Diary-iOS/blob/main/Screenshots/search%20sort%20and%20filter%20My%20fish%20list.gif?raw=true" width=250 height=600 /></td>
    <td><img src="https://github.com/amanbind007/Fishermans-Diary-iOS/blob/main/Screenshots/My%20fish%20list%20Update.gif?raw=true" width=250 height=600 /></td>
  </tr>
</table>

## ⚙️ Requirements
```
iOS 17 & Above
Xcode 15 & Above
```

## 📚 What you can learn?
- You can learn Technologies like
  - SwiftUI
  - swiftData
  - Combine
  - Web Scraping
  - SwiftSoup
  - Swift Package Manager(SPM)

- You can learn various Design patterns from this project such as
  - Dependency injection
  - Repository 
  - Singleton
  - Observers

- You can learn MVVM Two way binding Architecture for SwiftUI with Combine framework

## 🛠 Technical Background
- Fishermans Diary App was made using SwiftUI as the Core interface with Two Way Binding MVVM Architecture using Combine framework. 
- SwiftData is used to store the Fish Information offline in device so that the user can access it at later time and modify it.
- SwiftSoup is used to scrap the required details from the Fishbase website.
- The User interface of this app mostly uses the inbuilt iOS components to keep the User experience close to the native feel.
- Fishes can be added to 'My Fish List' by clicking on the '+' icon on Fish Card in Home View
- App also has support for infinite scroll. It tracks the number of pages scraped for the results based on the search text to load more fishes when user reaches the end of the scroll.
- This project was built in the mindset of modularity and good coding patterns. Multiple design patterns like Dependency injection, Repository pattern, Singleton Pattern etc.

## 🔗 Dependencies

This project uses SPM (Swift Package Manager) as Dependency manager.

 - [SwiftSoup](https://github.com/scinfu/SwiftSoup)
 - [SwiftUI Cached Async Image](https://github.com/lorenzofiamingo/swiftui-cached-async-image)
 - [Alert Toast](https://github.com/elai950/AlertToast)

## ✏️ Contribute

If you want to contribute to this library, you're always welcome!

### What you can do
You can contribute us by filing issues, bugs and PRs.

### Before you do
Before you open a issue or report a bug, please check if the issue or bug is related to Xcode or SwiftUI.

## 📱 Contact

Have an project? DM me at 👇

Drop a mail to:- amanbind007@gmail.com





