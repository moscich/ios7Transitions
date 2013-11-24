//
// Created by Marek Mościchowski on 03.10.2013.
// Copyright (c) 2013 Marek Mościchowski. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "LoremPixumImporter.h"
#import "AFHTTPRequestOperation.h"


@implementation LoremPixumImporter {

}
- (void)getGrayImageWithWidth:(int)width withHeight:(int)height withCategory:(NSString *)category onCompletion:(void (^)(UIImage *))completion
{
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://lorempixel.com/g/%d/%d/%@",width, height, category]];
    [self getImageWithUrl:url onCompletion:completion];
}

- (void)getImageWithWidth:(int)width withHeight:(int)height onCompletion:(void (^)(UIImage *))completion
{
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://lorempixel.com/%d/%d/",width, height]];
    [self getImageWithUrl:url onCompletion:completion];
}

- (void)getImageWithWidth:(int)width withHeight:(int)height withIdentifier:(int)identifier onCompletion:(void (^)(UIImage *))completion
{
    NSURL *url;
    if(identifier == 0)
    {
        url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://lorempixel.com/%d/%d/",width, height]];
    }
    else
    {
        url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://lorempixel.com/%d/%d/cats/%d/",width, height, identifier]];
    }

    [self getImageWithUrl:url onCompletion:completion];
}

- (void)getImageWithUrl:(NSURL *)url onCompletion:(void (^)(UIImage *))completion
{
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    int lastImageNumber = [self getImageNo];
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"imageView-%d", lastImageNumber+1]];
    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:path append:NO];

    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Successfully downloaded file to %@", path);
        dispatch_async(dispatch_get_main_queue(), ^{completion([self getImageFromPath:path]);});
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

    [operation start];
}

- (int)getImageNo
{
    int imageNo = [[[NSUserDefaults standardUserDefaults] valueForKey:@"lastImageNo"] intValue];
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:imageNo +1] forKey:@"lastImageNo"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    return imageNo;
}

- (UIImage *)getImageFromPath:(NSString *)path
{
    NSData *fileData = [[NSData alloc] initWithContentsOfFile:path];
    return [[UIImage alloc] initWithData:fileData];
}

@end