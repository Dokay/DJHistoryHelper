DJHistoryHelper
==========

![License MIT](https://img.shields.io/github/license/mashape/apistatus.svg?maxAge=2592000)
![Pod version](https://img.shields.io/cocoapods/v/DJHistoryHelper.svg?style=flat)
[![Platform info](https://img.shields.io/cocoapods/p/DJHistoryHelper.svg?style=flat)](http://cocoadocs.org/docsets/DJHistoryHelper)

## What

__DJHistoryHelper supplies unitization of interface for iOS APP cache with sqlite、coredata and plist.__

## Features
* simple and unified method;
* sort with date default;

## Requirements
* Xcode 7 or higher
* Apple LLVM compiler
* iOS 6.0 or higher
* ARC

## Demo 

Build and run the `DJComponentHistoryHelper.xcodeproj` in Xcode and run the unit test.


## Installation

###  CocoaPods
Edit your Podfile and add DJHistoryHelper:

``` bash
pod 'DJHistoryHelper'
```

## API
```objc
@protocol DJHistoryDelegate <NSObject>

- (id)initWithName:(NSString *)strName;

- (void)insertItem:(NSObject *)item withPrimaryKey:(NSString *)strKey;

- (NSObject *)readFromLocalWithObject:(NSObject *)object;

- (NSArray *)readFromLoacl;

- (void)removeItemBy:(NSObject *)object;

- (void)removeAllItem;

@end
```

## Contact

Dokay Dou

- https://github.com/Dokay
- http://www.douzhongxu.com
- dokay_dou@163.com

## License

DJHistoryHelper is available under the MIT license.

Copyright © 2016 Dokay Dou.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
