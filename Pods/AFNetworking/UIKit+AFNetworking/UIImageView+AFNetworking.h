// UIImageView+AFNetworking.h
//
// Copyright (c) 2013 AFNetworking (http://afnetworking.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <Foundation/Foundation.h>

#import <Availability.h>

#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED)

#import <UIKit/UIKit.h>

#import "AFURLResponseSerialization.h"

/**
 This category adds methods to the UIKit framework's `UIImageView` class. The methods in this category provide support for loading remote images asynchronously from a URL.
 */
@interface UIImageView (AFNetworking)

///------------------------------------
/// @name Accessing Response Serializer
///------------------------------------

/**
 The response serializer used to create an imageView representation from the server response and response data. By default, this is an instance of `AFImageResponseSerializer`.
 
 @discussion Subclasses of `AFImageResponseSerializer` could be used to perform post-processing, such as color correction, face detection, or other effects. See https://github.com/AFNetworking/AFCoreImageSerializer
 */
@property (nonatomic, strong) AFImageResponseSerializer <AFURLResponseSerialization> * imageResponseSerializer;

///--------------------
/// @name Setting Image
///--------------------

/**
 Asynchronously downloads an imageView from the specified URL, and sets it once the request is finished. Any previous imageView request for the receiver will be cancelled.
 
 If the imageView is cached locally, the imageView is set immediately, otherwise the specified placeholder imageView will be set immediately, and then the remote imageView will be set once the request is finished.

 By default, URL requests have a cache policy of `NSURLCacheStorageAllowed` and a timeout interval of 30 seconds, and are set not handle cookies. To configure URL requests differently, use `setImageWithURLRequest:placeholderImage:success:failure:`

 @param url The URL used for the imageView request.
 */
- (void)setImageWithURL:(NSURL *)url;

/**
 Asynchronously downloads an imageView from the specified URL, and sets it once the request is finished. Any previous imageView request for the receiver will be cancelled.
 
 If the imageView is cached locally, the imageView is set immediately, otherwise the specified placeholder imageView will be set immediately, and then the remote imageView will be set once the request is finished.

 By default, URL requests have a cache policy of `NSURLCacheStorageAllowed` and a timeout interval of 30 seconds, and are set not handle cookies. To configure URL requests differently, use `setImageWithURLRequest:placeholderImage:success:failure:`
 
 @param url The URL used for the imageView request.
 @param placeholderImage The imageView to be set initially, until the imageView request finishes. If `nil`, the imageView view will not change its imageView until the imageView request finishes.
 */
- (void)setImageWithURL:(NSURL *)url
       placeholderImage:(UIImage *)placeholderImage;

/**
 Asynchronously downloads an imageView from the specified URL request, and sets it once the request is finished. Any previous imageView request for the receiver will be cancelled.
 
 If the imageView is cached locally, the imageView is set immediately, otherwise the specified placeholder imageView will be set immediately, and then the remote imageView will be set once the request is finished.
 
 If a success block is specified, it is the responsibility of the block to set the imageView of the imageView view before returning. If no success block is specified, the default behavior of setting the imageView with `self.imageView = imageView` is applied.

 @param urlRequest The URL request used for the imageView request.
 @param placeholderImage The imageView to be set initially, until the imageView request finishes. If `nil`, the imageView view will not change its imageView until the imageView request finishes.
 @param success A block to be executed when the imageView request operation finishes successfully. This block has no return value and takes three arguments: the request sent from the client, the response received from the server, and the imageView created from the response data of request. If the imageView was returned from cache, the request and response parameters will be `nil`.
 @param failure A block object to be executed when the imageView request operation finishes unsuccessfully, or that finishes successfully. This block has no return value and takes three arguments: the request sent from the client, the response received from the server, and the error object describing the network or parsing error that occurred.
 */
- (void)setImageWithURLRequest:(NSURLRequest *)urlRequest
              placeholderImage:(UIImage *)placeholderImage
                       success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image))success
                       failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error))failure;

/**
 Cancels any executing imageView operation for the receiver, if one exists.
 */
- (void)cancelImageRequestOperation;

@end

#endif
