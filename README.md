![App Banner](https://github.com/amanbind007/Fishermans-Diary-iOS/blob/main/Screenshots/Screenshot%20Images/fishermans_diary_cover_rounded_new_small.png?raw=true)

![Swift](https://img.shields.io/badge/Language-Swift-FF5733)
![SwiftUI](https://img.shields.io/badge/Interface-SwfitUI-red)
![Architecture](https://img.shields.io/badge/Architecture-MVVM-green)
![GitHub forks](https://img.shields.io/github/forks/amanbind007/Fishermans-Diary-iOS?label=Fork&style=social)
![GitHub Stars](https://img.shields.io/github/stars/amanbind007/Fishermans-Diary-iOS?label=Stars&style=social)
![GitHub Watchers](https://img.shields.io/github/watchers/amanbind007/Fishermans-Diary-iOS?label=Watchers&style=social)

### Libraries & Tools
![SwiftSoup](https://img.shields.io/badge/SwiftSoup-DE3163)
![XCode](https://img.shields.io/badge/XCode-2874A6)
![Swift Package Manager](https://img.shields.io/badge/Swift%20Package%20Manager-D35400)
![Combine](https://img.shields.io/badge/Combine_Framework-28B463)
![SwiftData](https://img.shields.io/badge/SwiftData-7D3C98)

# Fishermans-Diary
Fishermans Diary is Simple and Minimal notes app created using SwiftSoup library for fishers to save fish information(like notes and count) they caught or search for fishes by webscraping Fishbase.org(thanks to fishbase) to know their habitat, diet, location, enviroment, size and many more.

## Special Thanks
I have created this after learning various concepts from the NYTimes app by TheCodeMonks

## 📝 Table of Contents  
- [Features](#features)
- [Requirements](#requirements)
- [What you can learn?](#whatyoucanlearn)
- [Technical Background](#techbackground)
- [Dependencies](#dependencies)
- [Project Structure](#projectstructure)
- [Contribute](#contribute)
- [Contact](#contact)

<a name="features"/>

## ⛓ Features
<table style="width:100%">
  <tr>
    <th>Searching for fish various filter options</th>
    <th>Infinte Scrolling</th> 
  </tr>
  <tr>
    <td><video src="https://github.com/amanbind007/Fishermans-Diary-iOS/assets/75306571/62c5d670-7dae-47a5-9f9e-a33a3480bec6" width=250 /></td> 
    <td><video src="https://github.com/amanbind007/Fishermans-Diary-iOS/assets/75306571/d0cffef4-d8df-4e06-8e67-937c39e753f9" width=250/></td> 
  </tr>
  <tr>
    <th>Web View for Detailed Fish Info</th>
    <th>Adding fishes to 'My Fish List'</th> 
  </tr>
  <tr>
    <td><video src="https://github.com/amanbind007/Fishermans-Diary-iOS/assets/75306571/d89022b5-a958-4846-86ef-4a4c225bc4c8" width=250/></td>
    <td><video src="https://github.com/amanbind007/Fishermans-Diary-iOS/assets/75306571/fe30ee82-1580-4588-9cf4-27581a150a44" width=250/></td>
  </tr>
    <tr>
    <th>Searching for fishes in 'My Fish List' using various Filter and Sort Options</th>
    <th>Updating Fishes in 'My Fish List'</th> 
  </tr>
  <tr>
    <td><video src="https://github.com/amanbind007/Fishermans-Diary-iOS/assets/75306571/fe8223de-2553-426b-9aa8-e2decba3e2e0" width=250 /></td>
    <td><video src="https://github.com/amanbind007/Fishermans-Diary-iOS/assets/75306571/c91a3972-8a82-4e3a-a6dc-fa96e24c5434" width=250 /></td>
  </tr>
</table>

<a name="requirements"/>

## ⚙️ Requirements
```
iOS 17 & Above
Xcode 15 & Above
```
<a name="whatyoucanlearn"/>

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

<a name="techbackground"/>

## 🛠 Technical Background
- Fishermans Diary App was made using SwiftUI as the Core interface with Two Way Binding MVVM Architecture using Combine framework. 
- SwiftData is used to store the Fish Information offline in device so that the user can access it at later time and modify it.
- SwiftSoup is used to scrap the required details from the Fishbase website.
- The User interface of this app mostly uses the inbuilt iOS components to keep the User experience close to the native feel.
- Fishes can be added to 'My Fish List' by clicking on the '+' icon on Fish Card in Home View
- App also has support for infinite scroll. It tracks the number of pages scraped for the results based on the search text to load more fishes when user reaches the end of the scroll.
- This project was built in the mindset of modularity and good coding patterns. Multiple design patterns like Dependency injection, Repository pattern, Singleton Pattern etc.

<a name="dependencies"/>

## 🔗 Dependencies

This project uses SPM (Swift Package Manager) as Dependency manager.

 - [SwiftSoup](https://github.com/scinfu/SwiftSoup)
 - [SwiftUI Cached Async Image](https://github.com/lorenzofiamingo/swiftui-cached-async-image)
 - [Alert Toast](https://github.com/elai950/AlertToast)

<a name="projectstructure"/>

## ⛓ Project Structure

    Fisherman's Keeper        # Root Group
    .
    ├── Utilities             # Utilities for Fetching data and Scraping HTML
    ├── Extensions            # Some useful extensions 
    ├── Fonts                 # Custom Fonts
    ├── Globals               # Contains App constants
    ├── Views                 # SwiftUI Views
    ├── ViewModel             # Viewmodels for SwiftUI Views
    ├── Model                 # Model files
    |   └── SwiftData Model   # SwiftData model for Persistence Storage
    |
    └── Preview Content       # Dummy Data Files for supporting SwiftUI Previews

<a name="contribute"/>

## ✏️ Contribute

If you want to contribute to this project, you're always welcome!

### What you can do
You can contribute us by filing issues, bugs and PRs.

### Before you do
Before you open a issue or report a bug, please check if the issue or bug is related to Xcode or SwiftUI.

<a name="contact"/>

## 📱 Contact

Have an project? DM me at 👇
LinkedIn: <a href="https://www.linkedin.com/in/amanbind/">Aman Bind</a>

Drop a mail to:- amanbind007@gmail.com

