# Alert
A customisable alert view controller that can be presented within your application. This alert allows for three optional headers and an option to show a single button or two buttons providing the user with an option. The alert also provides optional support for a footer button to be displayed below the alert.
## Setup

There are a few options on how to instantiate and display the AlertView in your app. The first way is to instantiate your own AlertVC which then allows you to set any of the custom parameters and then show the alert with the showAlert() method, like so.

```swift
    	let alert = AlertVC()
   	 	alert.backgroundColor = UIColor.yellow
    	alert.subLabelText = "subLabel"
    	alert.labelText = "Message"
    	alert.forcedAlert = true
    	alert.labelFont = UIFont.boldSystemFont(ofSize: 40)
    	alert.showAlert()
```

The seocnd way is to use the initWith method which is a method with several optional parameters allowing you to easily set which properties you require while leaving others 'nil'. It is important to remember you can still alter or add any other parameter values to the alert once this method has been used.

```swift
        let alert = AlertVC()
        
        alert.setupWith(title: "test alert", subText: "heres a test alert", 
        image: nil, okTitle: "Confirm", cancelTitle: "Deny", bottomExtraButtonTitle: nil, 
        forced: false, okCompletion: nil, cancelCompletion: nil, bottomExtraButtonCompletion: nil, 
        backgroundColor: UIColor.red, buttonColors: nil)
        
        alert.labelFont = UIFont.boldSystemFont(ofSize: 40)
        alert.showAlert()
```

A third more simple function allows for showing a simple alert which just sets basic parameters and shows the alert straight away. This can be helpful for showing errors etc.

```swift
        let errorAlert = AlertVC()
        errorAlert.showError(message: "Oops. Something went wrong!", forced: true)
```
        
## Parameters
### Alert View
* **forcedAlert** Determines whether the alert shows a single OK button or both an OK and a CANCEL button (defaults to false - showing a cancel button)
* **cornerRadius** The corner radius of the AlertView (Defaults to 7.0)
* **canBeDismissedFromBackground** Determines wheter the alert can be dismissed by the user clicking on the background view. (Defaults to false)
* **backgroundColor** The background color of the alert view (Defaults to White)
* **iconImage** A UIImage property which can be set to display an image in the alert above the text.



### Labels
* **labelText** The main text to display in the alert
* **subLabelText** An optional subheader label which displays text below the main text in a smaller size. 
* **extraSubLabelText** An optional third subheader label which is displayed below the sub-label. 
* **labelFont** The font of the main title text
* **subLabelFont** The font of the subtitle text
* **extraSubLabelFont** The font of the third subheader text

### Buttons

* **okButtonText** The button title to display in the ok button (defaults to "OK")
* **cancelButtonText** The button title to display in the cancel button (defaults to "Cancel")
* **okButtonBackgroundColor** The background color of the alert view ok button (Defaults to White)
* **cancelButtonBackgroundColor** The background color of the alert view cancel button (Defaults to White)
* **okCompletion** A completion block to set on the action of the ok button
* **cancelCompletion**  A completion block to set on the action of the cancel button
* **buttonFont** The font used for the button title labels

### Footer Button

* **shouldShowBottomExtraButton** A boolean to determine whether the footer button should be displayed
* **bottomExtraButtonText** The text shown in the footer button
* **bottomExtraButtonCompletion** A completion block to set on the action of the footer button


## Credits
Made with ❤️ at [Nodes](http://nodesagency.com).

## 📄 License
**Alert** is available under the MIT license. See the [LICENSE](https://github.com/nodes-ios/Alert/blob/Dev/LICENSE) file for more info.