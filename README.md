# Horse Racing Project

In this README.md I will outline any information I think will be helpful about my implementations. I will structure the readme split up by implementations, in an order which closely follows the order I implemented them.

## The File Reader

I opted for a statically embedded file in order to host my json data. I therefore needed to make sure I could read the data from the file itself before any decoding could be done. I wanted to create a layer of abstraction on top of the default way to read data from a bundle. 

The reasons for this follow:

- The default method requires four steps; you need to know and specify the correct bundle, then use that bundle to extract a path, convert the path to a url, and then grab the data from the contents at the url. I wanted the result to be much more straightforward and I wanted to supply a default bundle and file name since for this application, both will rarely change.
- I wanted to return my own error type so I can potentially display somthing meaningful to the user upon failure.
- Making the ability to read data from a file much simpler will reduce code duplication and avoid any possible differences in implementation.

## The JsonFileDecoder

I needed a way to convert a Data object containing json to any model. JsonFileDecoder is an abstraction on top of the default decoder which lets me use a custom error type on failure.

## Bottom Sheet

I have opted to use a bottom sheet in order to show the detailed information for each race. I like the way the bottom sheet looks and feels, and along with Apple releasing UISheetPresentationController in iOS 15 I feel like it makes a great addition to modern iOS apps. Since iOS 15 isn't released yet, I built my own take on it.

The relevant files are:

- ModalContainerView (UIView)
- ModalContainerViewController (UIViewController)
- ModalContainerViewDelegate (Protocol)
- BottomSheetAttachable (Protocol)
- BottomSheetDataSource (Protocol)

### ModalContainerView

This is where all of the view logic resides for the ModalContainerViewController. View entrance and exit animations reside here too.

I started by creating the background dimmed view and the bottom sheet container view and setting them so they are off-screen. A function is defined to animate the views on screen, which will be called from the ModalContainerViewController's viewDidAppear function. 
I also attach a pan gesture recognizer to the view so that I can change the bottom sheet container views height in relation to the users panning.
The dismiss animation is triggered after a couple of events take place, either; the user taps the dimmed view, or the user pans the container view down past a minimum threshold.
When the dismiss animation is complete, the delegate (ModalContainerViewDelegate) notifies it's listeners (ModalContainerViewController) that it should handle any dismissal tasks from a View Controller level.

### ModalContainerViewController

This is where all of the view controller specific logic resides.

I hand over all of the view logic to our ModalContainerView in the loadView function, whilst grabbing any configuration data from the BottomSheetDataSource, which will be implemented on the View Controller which expects to present the bottom sheet.
This View Controller also implements the ModalContainerViewDelegate, so we can listen to any events it might trigger and react accordingly. In this case we listen for when the view has finished its dismiss animation and hence should react be dismissing the view controller without any animation (since we already performed the animation).

### ModalContainerViewDelegate

Simple protocol to declare events which happen on the ModalContainerView

### BottomSheetAttachable

A protocol that gives it's implementor the ability to display a bottom sheet.
This protocol also ensures that BottomSheetDataSource is implemented on the presenting view controller so we can extract the data we need.

### BottomSheetDataSource

A protocol that asks its implementor for required data points needed in order to attach a bottom sheet:
    - viewControllerToPresent (Required): The View Controller which will be displayed within the bottom sheet.
    - backgroundDim (Required, Default = 0.6): The opacity value on the dimmed background. 
    - defaultHeight (Required, Default= 300): The default height of the bottom sheet container view.
    - dismissibleHeight (Required, Default = 200): The height at which the bottom sheet will be dismissed.
    - topPadding (Required, Default = 64): The amount of top padding on the bottom sheet container view.
