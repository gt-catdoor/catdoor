# Cat Door Extraordinaire

DESCRIBE PROJECT

## Prerequisites

- Mac Computer
- Most recent version of XCode from the Apple App Store
- Apple ID

### Installing the App

- Make sure that you are on the master branch of this repository
![Where to find branches](AppInstallationImages/masterBranchImage.png)

- Then, you want to press the green clone of download button and choose to open the project in Xcode
![Cloning the project into Xcode](AppInstallationImages/clonetoXcode.png)

- Next, the project should open up in Xcode

- After this, you want to to select the Xcode tab in the upper left (next to the apple symbol) and then select preferences
![Navigate to Xcode Preferences](AppInstallationImages/XcodePreferences.png)

- Make sure you are on the accounts tab and then press the plus(+) button in the bottom left
![Add a new account](AppInstallationImages/addAccount.png)

- Make sure that Apple ID is selected and then press continue

- Now, login with your Apple ID credentials

- You should now see your Apple ID account listed

- You can then close out of this pop-up screen

- Next, you want to make sure you have the file named CatDoor with a blue symbol selected in the folder view and you also need to make sure that on the main screen, you are looking at the general tab
![CatDoor file selected on General Tab](AppInstallationImages/catDoorGeneralTab.png)

- You then want to scroll down to the section named Signing and select the drop down menu where it says team and select Personal Team (you will continue to see an error message even after this step)
![Setting the team under Signing](AppInstallationImages/personalTeam.png)

- You next should scroll up to the section named Identity and delete what is written in the text field for Bundle Identifier and replace it with your Apple ID username
![Replace Bundle Identifier with Apple ID](AppInstallationImages/bundleIdentifier.png)

- Next, you should scroll down again to the section named Deployment Info and make sure that the text field labelled Deployment Target is set to a number that is less than or equal to the current software version you are running on your iphone. In this case, the phone I was using had a version of software greater than version 10
![Change Deployment Target](AppInstallerImages/deploymentTarget.png)

- After this, you should connect your iPhone to your computer

- You then need to click on the tab located near the play button at the top of the application that will be labelled with the name of some type of iPhone. This tab will be directly next to another tab that says CatDoor
![Select iPhone Tab](AppInstallerImages/typeOfPhoneTab.png)

- You should select the option on the top that says iPhone and then click the play button(triangle)
![Select your Phone](AppInstallerImages/selectDevice.png)

- You can now wait for the app to install onto your phone. Once this is done, you can open up the app. However, you will receive an error message like the following:
![Deployment Error Message](AppInstallerImages/errorOnPhone.jpeg)

- Cancel out of this message and then open up the setttings app on your phone. Then, navigate to the general tab. You can then scroll down until you see an option called Device Managment- click on it.
![Device Management Tab](AppInstallerImages/DeviceManagementTab.jpeg)

- You will then see an option with your Apple ID- click on this

- Then select trust and confirm it in the popup window

- After this, you can open the Catronics App again and your app installation will be complete


### Installing the Computer Vision Program

A step by step series of examples that tell you how to get a development env running

Say what the step will be

```
Give the example
```

And repeat

```
until finished
```

### Installing the Hardware

A step by step series of examples that tell you how to get a development env running

Say what the step will be

```
Give the example
```

And repeat

```
until finished
```

## Troubleshooting

Possible errors user might run into

Say the error

```
Give the solution
```
