

# Persian Justify 

### Not very efficient way to justify Hebrew languages in iOS using the Swift language and CoreText.

<img src="Previews/Logo.png" alt="Image 1">

<img src="https://img.shields.io/badge/Swift_Package_Manager-compatible-green?style=flat-square"><img src="https://img.shields.io/badge/Platforms-macOS_iOS_tvOS-Green?style=flat-square">
| ⬇️ | ⬇️ |
| --- | --- |
|<img src="Previews/custom_font_1_preview.jpg" width="80%" height="80%" alt="Image 1">|<img width="80%" height="80%" src="Previews/original_font_preview.jpg" alt="Image 1">|
|<img src="Previews/custom_font_3_preview.jpg" width="80%" height="80%" alt="Image 1">|<img width="80%" height="80%" src="Previews/custom_font_2_preview.jpg" alt="Image 1">|

### Usage:
##### ✅ Add PersianJustify using SPM
##### ✅ Import PersianJustify in your class and use it like so:
```ruby
yourLabel.numberOfLines = 0
yourLabel.attributedText = yourText.toPIString(in: yourLabel)
```

### Example Project:
<img src="Previews/example.jpg" alt="Image 1">
##### Navigate to the "Example" folder with finder and open the example project while the main project is not open in XCode.

### Problems:
- Not optimized (yet) and consumes a lot of energy.
- Some weird UI issues in text with some fonts.
- Not tested with all Hebrew languages.
- It needs more tests.

#### PS:
##### I accept the helps to fix the bugs and improve the functionality with open arms.


### License:
PersianJustify is released under the MIT license. See [LICENSE] for details. 
[LICENSE]:https://github.com/HappyIosDeveloper/PersianJustify/blob/main/LICENSE
