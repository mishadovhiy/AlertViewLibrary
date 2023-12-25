# AlertViewLibrary

<div style="display:flex;flex-direction: row;">

<img src="https://github.com/mishadovhiy/AlertViewLibrary/assets/44978117/4528b64f-7b93-48c6-b90f-c1a784995cf9" width="45%">
<img src="https://github.com/mishadovhiy/AlertViewLibrary/assets/44978117/61b6ca7f-a91b-434b-94fe-de278a0d8ef59" width="45%">

</div>

# Compatibility
- iOS 11 and higher
- MacOS 10.15 and higher

# Installation
### Add AlertViewLibrary Package Dependency to your project
<img width="862" alt="Screenshot 2023-12-25 at 03 03 42" src="https://github.com/mishadovhiy/AlertViewLibrary/assets/44978117/27f8e18a-0ae1-4cd0-af13-d003bfb81dbd">

<p><br><br></p>

### <p><b>Search for</b>: <a href="https://github.com/mishadovhiy/AlertViewLibrary">https://github.com/mishadovhiy/AlertViewLibrary</a></p>
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

### Alert Types



https://github.com/mishadovhiy/AlertViewLibrary/assets/44978117/662eb63e-11e4-4b16-a1d8-937e0b197c8b




```
alert.showAlert(title: nil, appearence: .type(.error))
```

<p>appearence: Declared in <a href="https://github.com/mishadovhiy/AlertViewLibrary/blob/main/Sources/AlertViewLibrary/AlertViewLibrary/Extensions_AlertViewLibrary.swift#L74" target="blank">https://github.com/mishadovhiy/AlertViewLibrary/blob/main/Sources/AlertViewLibrary/AlertViewLibrary/Extensions_AlertViewLibrary.swift#L74</a></p>

#### ViewType
primary types:
- error
- standard (default)
- succsess
<p>Note: <small><b>.error</b> and <b>.success</b> types are setting default title (when alert title is nill) and default image</small><br>
default image or title can be setted when initializing AlertManager</p>

To Show error or success without default image, set
```
alert.showAlert(title: nil, appearence: .with({
    $0.type = .error
    $0.image = AlertViewLibrary.AIImage.none
}))
```

# Customization

![customAlert](https://github.com/mishadovhiy/AlertViewLibrary/assets/44978117/ecc32cd9-7c90-48a5-9a74-154a30d2be2c)


```
AlertManager.init(appearence:.with({
    $0.colors = .with({
        $0.alertState = .with({
            $0.view = blue
            $0.background = .black.withAlphaComponent(0.5)
        })
        $0.activityState = .with({
            $0.view = orange.withAlphaComponent(0.8)
            $0.background = .black.withAlphaComponent(0.1)
        })
        $0.texts = .with({
            $0.title = .black
            $0.description = .black.withAlphaComponent(0.5)
        })
        $0.buttom = .with({
            $0.link = .black
            $0.normal = .gray
        })
    })
    $0.animations = .with({
        $0.setBackground = 0.8
        $0.alertShow = 0.5
        $0.performHide1 = 0.5
        $0.performHide2 = 0.3
        $0.loadingShow1 = 0.4
        $0.loadingShow2 = 0.5
    })
    $0.images = .with({
        $0.alertError = nil
        $0.alertSuccess = nil
    })
}))
```
Appearence declaration: https://github.com/mishadovhiy/AlertViewLibrary/blob/main/Sources/AlertViewLibrary/Model/AIAppearence.swift#L10



<div style="display:flex;flex-direction: row;">

<img src="https://github.com/mishadovhiy/AlertViewLibrary/assets/44978117/5e8fa7ad-b873-41eb-ae41-33faff514874" width="45%">
<img src="https://github.com/mishadovhiy/AlertViewLibrary/assets/44978117/adab9d13-b696-43ef-ae78-6d76bfe3176e" width="45%">

</div>


# Features
- Manages unseen alerts
When Alert View is presenting - all new alerts would be added to the query and would be presented later
# Usage example in apps
- Budget Tracker App https://github.com/mishadovhiy/Budget-Tracker/blob/master/Budget%20Tracker/AppDelegate/AppDelegate.swift#L31

<p><br><br><br>Created by <a href="https://www.mishadovhiy.com">Misha Dovhiy</a><br><br></p>
