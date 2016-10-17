# Alert
A customisable alert view controller that can be presented within your application. This alert allows for three optional headers and an option to show a single button or two buttons providing the user with an option. The alert also provides optional support for a footer button to be displayed below the alert.

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