
//
//  AdvertisementViewModel.m
//  RDFuturesApp
//
//  Created by user on 2017/5/24.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "AdvertisementViewModel.h"
#import "AdvertisementModel.h"
@implementation AdvertisementViewModel
-(void)initialize{
    [self.advertisementCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"Advertisement_logo"];
        NSMutableDictionary *dictionary = (NSMutableDictionary *)x;
        NSURL *url = [NSURL URLWithString:dictionary[@"image"]];
        UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
        [self saveImage:image];
        [[NSUserDefaults standardUserDefaults] setObject:x forKey:@"Advertisement_data"];
    }];
}
-(RACCommand *)advertisementCommand{
    if (!_advertisementCommand) {
        _advertisementCommand= [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                NSDictionary *dataDictionary = [[NSDictionary alloc] init];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError *error;
                    RDRequestModel * model = [RDRequest postOpenAdvListWithParam:dataDictionary error:&error];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if ([model.State isEqualToString:@"1"]) {
                            
                            [subscriber sendNext:model.Data];
                        }
                        [subscriber sendCompleted];
                        
                    });
                    
                    
                });
                
                return nil;
            }];
            
        }];
    }
    return _advertisementCommand;
}
- (void)saveImage: (UIImage*)image
{
    if (image != nil)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString* path = [documentsDirectory stringByAppendingPathComponent:
                          @"advertisement.png"];
        NSData* data = UIImagePNGRepresentation(image);
        [data writeToFile:path atomically:YES];
    }
}

@end
