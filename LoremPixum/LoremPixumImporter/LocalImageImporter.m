//
// Created by Marek Mościchowski on 03.10.2013.
// Copyright (c) 2013 Marek Mościchowski. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "LocalImageImporter.h"


@implementation LocalImageImporter {

}
- (void)getImageWithWidth:(int)width withHeight:(int)height onCompletion:(void (^)(UIImage *))completion
{
    NSString *directory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSArray *fileArray = [fileMgr contentsOfDirectoryAtPath:directory error:nil];
    
    NSUInteger random = (NSUInteger)rand() % fileArray.count;
    NSString *fileName = [fileArray objectAtIndex:random];
    NSData *fileData = [[NSData alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",directory,fileName]];
    UIImage *image = [[UIImage alloc] initWithData:fileData];
    ^{completion(image);};
}

- (UIImage *)getImageFromPath:(NSString *)path
{
    NSData *fileData = [[NSData alloc] initWithContentsOfFile:path];
    return [[UIImage alloc] initWithData:fileData];
}

@end