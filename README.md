# AlertViewLibrary

<div style="display:flex;flex-direction: row;">

<img src="https://github.com/mishadovhiy/AlertViewLibrary/assets/44978117/4528b64f-7b93-48c6-b90f-c1a784995cf9" width="45%">
<img src="https://github.com/mishadovhiy/AlertViewLibrary/assets/44978117/61b6ca7f-a91b-434b-94fe-de278a0d8ef59" width="45%">

</div>

# Compatibility
- iOS 11 and higher
- MacOS 10.15 and higher

# Installation
#### Add AlertViewLibrary Package Dependency to your project
<img width="862" alt="Screenshot 2023-12-25 at 03 03 42" src="https://github.com/mishadovhiy/AlertViewLibrary/assets/44978117/27f8e18a-0ae1-4cd0-af13-d003bfb81dbd">

#### <p><br><br>
#### <b>Search for</b>: <a href="https://github.com/mishadovhiy/AlertViewLibrary">https://github.com/mishadovhiy/AlertViewLibrary</a></p>
<img width="1278" alt="Screenshot 2023-12-25 at 03 04 25" src="https://github.com/mishadovhiy/AlertViewLibrary/assets/44978117/a6ace39a-ae5a-4a28-a945-5ef0b4024184">



# Usage
## Initialization
### Import Library
```
import AlertViewLibrary
```
### Initialize Library
```
lazy var alert:AlertManager = .init()
```
Done! And now you can use the Library
## Basic Usage Examples
<div style="display:flex;flex-direction: row;">

<img src="https://github.com/mishadovhiy/AlertViewLibrary/assets/44978117/67196cbf-f216-4b2a-a5b3-48a782ddc874" width="35%">
<img src="https://github.com/mishadovhiy/AlertViewLibrary/assets/44978117/86d540c8-1dcb-4094-b08b-4e8099c39840" width = "30%">
<img src="https://github.com/mishadovhiy/AlertViewLibrary/assets/44978117/125d72c7-8656-4d92-9443-cf3c10013b0d" width ="30%">

</div>

### Show Loading indicator
```
alert.showLoading(description: "Your loading description")
```
### Show Alert
```
alert.showAlert(title: "Your Title", description: "Your Description", appearence: .with({
    $0.image = .image(.init(named: "screen1")!)
    $0.primaryButton = .with({
        $0.close = false
        $0.action = self.test2Perform
    })
}))
```

##### Error Alert


https://github.com/mishadovhiy/AlertViewLibrary/assets/44978117/0853c578-579b-429b-9887-eaffed4f1a5c



```
alert.showAlert(title: nil, appearence: .type(.error))
```


# Customization

## Features
- Manages unseen alerts
When Alert View is presenting - all new alerts would be added to the query and would be presented later

created by Misha Dovhiy 
Developer website: https://www.mishadovhiy.com<br/ ><br/ >
  Implementation example: Budget Tracker App https://github.com/mishadovhiy/Budget-Tracker/blob/master/Budget%20Tracker/AppDelegate/AppDelegate.swift#L31

