

# Persian Justify 

### Not very efficient way to justify Hebrew languages in iOS using the Swift language and CoreText.

<img src="Previews/Logo.png" alt="Image 1">

<img src="https://img.shields.io/badge/Swift_Package_Manager-compatible-green?style=flat-round"> <img src="https://img.shields.io/badge/Platforms-iOS%20|%20macOS%20|%20tvOS-green?style=flat-round"> <img src="https://img.shields.io/badge/Swift-%20+4.0-orange?style=flat-round"> <img src="https://img.shields.io/badge/license-MIT-black?style=flat-round">
| ⬇️ | ⬇️ |
| --- | --- |
|<img src="Previews/custom_font_1_preview.jpg" height="650" width="300">|<img src="Previews/original_font_preview.jpg" height="650" width="300">|
|<img src="Previews/custom_font_3_preview.jpg" height="650" width="300">|<img src="Previews/custom_font_2_preview.jpg" height="650" width="300">|

### Usage:
##### ✅ Add PersianJustify using SPM
##### ✅ Import PersianJustify in your class and use it like so:
```ruby
yourLabel.numberOfLines = 0
yourLabel.attributedText = yourText.toPJString(in: yourLabel)
```


### Example Project:
<img src="Previews/example.jpg" alt="Image 1">
Navigate to the "Example" folder with finder and open the example project while the main project is not open in XCode.

### Problems:
- Not optimized (yet) and consumes a lot of energy.
- Some weird UI issues in text with some fonts.
- Not tested with all Hebrew languages.
- It needs more tests.

#### PS:
##### I accept the helps to fix the bugs and improve the functionality with open arms.

### Credits:
I'm very thankful to my dear brother and teacher [MR.Mojtaba Hosseini](https://github.com/MojtabaHs) to be a big part of this.'
<img src="Previews/founders.jpg" alt="Image 1">

### License:
PersianJustify is released under the MIT license. See [LICENSE](https://github.com/HappyIosDeveloper/PersianJustify/blob/main/LICENSE) for details. 
