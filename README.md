# CTHelp2

[![Platform](http://img.shields.io/badge/platform-iOS-blue.svg?style=flat)](https://developer.apple.com/iphone/index.action)[![](http://img.shields.io/badge/language-Swift-brightgreen.svg?color=orange)](https://developer.apple.com/swift)![](https://img.shields.io/github/tag/stewartlynch/CTHelp2?style=flat)![](https://img.shields.io/github/last-commit/StewartLynch/CTHelp2)

### What is this?

![CTPicker](CTHelp2.gif)

**CTHelp** is a customizable drop in Help solution.  Each one of your viewControllers can have its own set of help 'cards'.  You can also optionally include a card that links to your web site and one that will initiate an email to your help desk.

### Requirements
- iOS 12.0+
- Xcode 11.0+
- Swift 5.0+
### YouTube Video

Watch this video to see installation and use as described below.

The video also provides tips and ideas on how to consolidate all of your help for all of your viewControllers

https://youtu.be/jbmQyQ3ggAQ

### Installation

1. From within Xcode 11 or later, choose **File > Swift Packages > Add Package Dependency**
2. At the next screen enter https://github.com/StewartLynch/CTHelp2.git when asked to choose a Package repository
3. Choose the latest available version.
4. Add the package to your target.

You now have the dependency installed and are ready to import CTHelp2

### Set up?

Setting up to use this solution on one or more of your viewControllers.

##### Step 1 - Import CTHelp2

In the ViewController where you are going to implement `CTHelp2` import CTHelp.

```swift
import CTHelp2
```

##### Step 2 - Create a button that will call the CTHelp2 presenter

In each viewController where you wish to display help, create a button that will perform an action that will build and present the help cards.

##### Step 3 - Create an instance of CTHelp

Within the action, create an instance of `CTHelp`.  There are two optional parameters; `ctString` and `ctColors` that are covered later on in this ReadMe.

```swift
let ctHelp = CTHelp()
```

##### Step 4 - Create the Help Cards

Each new card can be created using the `cthelp.new` function that takes one parameter, a `CTHelpItem`

The `CTHelpItem` has 3 `string` parameters; `title`, `helpText` and `imageName`.  All are required, but can also be empty strings.  If the string is empty, the parameter is ignored.

**Note:** The image with the name `imageName` must be available as one of your assets.

```swift
// Card 1 Displays a title and help text but no image
ctHelp.new(CTHelpItem(title:"List of books",
                      helpText: "This screen shows a list of all of the books that you have read.\nAs you read more books you read more books you can add to this list.\nYou can also remove books from the list as well.  See the other help screens here for more information.",
                      imageName:""))
// Card 2 displays title, help text and image
ctHelp.new(CTHelpItem(title:"Adding a Book",
                      helpText: "To add a book to your collection, tap on the '+' button on the navigation bar.\nEnter the book title and author and tap the 'Add' button",
                      imageName:"AddBook"))
// Card 3 displays title and helptext and image
ctHelp.new(CTHelpItem(title:"Removing a Book",
                      helpText: "To remove a book from your list, swipe from the right to the left and choose 'Remove Book'.",
                      imageName:"RemoveBook"))
```

**Note:** Images will be aspect scaled, but will always fit within the size of the card so it is best to design your images so that they are a maximum width of 260 px and a maximum height of 210 px.

The `helpText` field will scroll, but the maximum height for your image should only be used if you have not helpText otherwise the helpText may not be visible.

##### Step 4 - Optional Cards appendDefaults()

There are 2 optional cards that may be included by calling the `appendDefaults` function to your instance of `CTHelp`.  This function takes 5 parameters; `companyName` (String), `emailAddress` (String), `data` (data), `website` (String) and `companyImageName` (String)

###### Email Card

If you assign a value to `emailAddress`, a new card will be created and presented, asking the users if he/she wishes to contact the developer. The email address specified will be the address to which the email is sent. 

If, prior to calling the `appendDefaults` function, you gather data for your application and assign it to a Data() object, you can assign that to the `data` parameter. If this parameter not **nil**, the user will also be asked if he/she would like to attach application data to the email.

###### Website Card

If you assign a value to `webSite`, a card is displayed with an image using the name specified in `companyImageName` along with some text that asks the user to click on a button that will take the user to the company website defined in the `webSite` address. The image you use must be available as one of your assets.

Here is an example displaying both cards after gathering data.

```swift
// This gathers data from the application and encodes it as a JSON String
let books = StorageFunctions.retrieveBooks()
let encodedBooks = StorageFunctions.encodedBooks(books: books)
let bookData = encodedBooks.data(using: .utf8)
ctHelp.appendDefaults(companyName: "CreaTECH Solutions",
                      emailAddress: "books@createchsol.com",
                      data: bookData,
                      webSite: "https://www.createchsol.com",
                      companyImageName: "CreaTECH")
```

##### Step 5 - Present CTHelp

The final step is to present the help screens using the `presentHelp` function. This function is called by passing in the viewController to the function.

```swift
ctHelp.presentHelp(from: self)
```

### Optional Parameters

As mentioned above there are two additional optional parameters that you can use when creating your instance of `CTHelp`.  

##### Custom Strings

All of the strings used in CTHelp are fully customizable and each one is optional so you do not need to change every one of them.  To customize the strings, just create a new instance of  a `CTString` and povide a string value for one or more of the optional parameters.  For your reference, the example shown below duplicates the default strings used.

**Note:** in the example below **app name** and **company name** are just placeholders that, when using the default strings, will be replaced by the values provided by your application.  If you are replacing these strings, you must used the real values in your strings.

```swift
let ctString = CTString(contactTitle: "Contact Developer",
                        contactButtonTitle: "Contact Developer",
                        webButtonTitle: "Visit Web Site",
                        dataAlertTitle: "Attach application data",
                        dataAlertMessage: "Would you like to attach your application data to this message to assist the developer in troubleshooting?",
                        dataAlertActionNo: "No",
                        dataAlertActionYes: "Yes",
                        emailSubject: "**app name** Issue",
                        emailBody:  "Please describe the issue you are having in as much detail as possible:",
                        emailAttachNote: "<b>Note:</b>**app Name** data is attached.",
                        contactHelpText: "**company name** would very much like to assist you if you are having issues with **app name**. Please tap button below to initiate an email to the developer.",
                        includeDataText: "  If you agree, your data will be compiled and sent to the developer for analysis.",
                        webHelpText: "**app name** is created by **company name**.  Please visit our website for more information about our company.")
         
// Now you can pass this string when creating your instance of CTHelp
let ctHelp = CTHelp(ctString: ctString)
```

##### Custom Colors

CTHelp's default colors are ones that are compatible and support dark mode in iOS 13.  All are optional.

**Note:** If your application is runninng on an iOS 13 device the colors will change accordingly as your user change his view mode.  This is important to note as you will want to ensure that any custom colors you use have both a light and dark asset available.

To customize the colors, just create a new instance of  a `CTColors` and complete one or more of the optional parameters.  For your reference, the example shown below duplicates the default strings used.

**Note**: The mail form is Apple's mail form so the buttons will default to your application's default tint color.  If the buttons do not display well, you can change the color by changing the mailtintColor.

```swift
let ctColors = CTColors()        
if #available(iOS 13.0, *) {
            ctColors = CTColors(mailtintColor: .default,
                                bgViewColor: UIColor.systemBackground,
                                helpTextColor: UIColor.systemGray,
                                titleColor: UIColor.label,
                                actionButtonBGColor: UIColor.systemBlue,
                                actionButtonTextColor: UIColor.white,
                                closeButtonBGColor: UIColor.systemGray,
                                pageControlColor: UIColor.secondaryLabel)
        } else {
            ctColors = CTColors(mailtintColor: .default,
                                bgViewColor: UIColor.white,
                                helpTextColor: UIColor.systemGray,
                                titleColor: UIColor.black,
                                actionButtonBGColor: UIColor.systemBlue,
                                actionButtonTextColor: UIColor.white,
                                closeButtonBGColor: UIColor.systemGray,
                                pageControlColor: UIColor.darkGray)
        }

// Now you can pass this set of colors when creating your instance of CTHelp
let ctHelp = CTHelp(ctColors: ctColors)
```

You if you have declared an instance of both CTString and CTColors, you can pass both of them to your instance of ctHelp when you create it.

```swift
let ctHelp = CTHelp(ctString: ctString, ctColors: ctColors)
```

### Feedback invited

CTHelp2 is open source and your feedback for improvements and enhancements is invited.

Please feel free to contact me at slynch@createchsol.com
