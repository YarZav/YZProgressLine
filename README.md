# YZProgressLine
IOS framework to show progress as line. Can update start, update and finish progress.

![](YZProgressLineExample.gif)

## Features
- Swift 4.2.
- Show simple animation to show pogress.

## Setup

**import YZProgressLine**

And now can start, update or finish prgress.

**let progressLine = YZProgressLine()**  
**progressLine.startLoading(animated: true)**
**progressLine.setProgressPercent(50, animated: true)**
**progressLine.stopLoading(animated: true)**

## Instalation
### Cocoapods

To install it, simply add the following line to your Podfile:

pod 'YZProgressLine', :git => 'https://github.com/YarZav/YZProgressLine.git', :branch => 'master'

## Feedback

Feel free to create a pull request.
