# Assignment

This application is used to show the cars in the list and then plot them on the map.

**Features**

	- It shows the car fetched form the api and plot them on the map
	- Generic network layer
	- Localization
	- MVVM Design pattern.
	
**Usage**
	
	To use this app, first clone the application codebase
	then run 
			"pod install"
		on terminal
		
**App flow:**

**VehicleViewController** - This controller has table view which shows the car data into list and It have button "Map" which takes the user to map screen when all the cars are plotted.

**VehicleViewModel** - This class have all the buisness logic and api calling methods.

**Vehicle**: This is model class which have all the json properties to save response from the api.

**ServiceManager**: This is network manager which interacrs with server url nad fetch the response from server.

**Services**: This file is used to get all the list of the vehicles from the service manager.

**App UI:**
![Uploading Simulator Screen Shot - iPhone 12 - 2021-07-08 at 12.04.51.png…]()
![Uploading Simulator Screen Shot - iPhone 12 - 2021-07-08 at 12.05.26.png…]()

	
	

