# Yassir iOS App

Rick App is an application that is created for Yassir task.
The main functionality of the app is to load data from [Rick and Morty API](https://rickandmortyapi.com/api).

![simulator_screenshot_E7C3B240-0997-40B2-9904-F432570725C5](https://github.com/user-attachments/assets/4af58907-d65b-412f-ae16-2fe2a01f6be8)
![simulator_screenshot_BE0002BD-3FBD-4521-A9F8-7DF7BBA0335D](https://github.com/user-attachments/assets/fb8dd86e-b0fe-4027-aeae-c8b2218648fb)



## Instructions for building and running

1- Clone the Repo 

2- Download the code as a file Or usine and Github Desktop apps 

3- open yasserTask File -> open YassirTask.xcodeproj using Xcode 

4- Run and enjoy the app  

## Features

- Filter data based on status 
- Show character details 
- Localization support for Arabic 
- Load data while scrolling (Pagination)

## Localization

The application provide the ability to run on Arabic language.
to run the app on Arabic language please follow instructions: 
- in Xcode select the schema "YasserTask"
- select "edit Schema"
- select options
- in the options section scroll down and select "App Language" drop down 
- select Arabic language 
- re-run the application

## Design Pattern 

Using the MVVM UI design pattern with Repository to get data from network client with dependency injection.


## Unit test & UI test 

The app includes unite test with coverage up to 92% 

## Challenges

- Deciding the design pattern: the design pattern using in the app is the most important part of developing it. The MVVM pattern is used for supporting UI presentation without having reference from view so it can pass the data supported using object of it, that will support maintainability, scaling and testing. 
- using the Repository for communicating with the network client and to form the model used in the app, that will support us to implement any type of caching or changing the network layer anytime without any dependency issues.
- implementing the table view cells in swiftUI and add it to the table view.
- Filtering logic for the data available. 
- The ability to have pagination to reduce memory usage while opening the app and scrolling. 
- showing details for specific item and passing the data to Details view controller.   
