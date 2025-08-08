# LibGit2-iOS

This repository provides a pre-compiled `libgit2.xcframework` for use with CocoaPods on iOS projects.

## Installation

To install `LibGit2-iOS` using CocoaPods, add the following line to your `Podfile`:

```ruby
pod 'LibGit2-iOS', '~>1.9.2'
```

## Usage

After installing the pod, you can import the libgit2 headers in your source files:

```c
#import <git2.h>
```

Now you can use the `libgit2` API in your project.

## Building

This `xcframework` was built from the official [libgit2](https://github.com/libgit2/libgit2) repository.
