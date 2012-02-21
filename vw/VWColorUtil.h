//
//  VWColorUtil.h
//
//  Created by vesperworks on 11/10/21.
//  Copyright 2011 vesperworks. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface VWColorUtil : NSObject

+ (VWColorUtil *)sharedInstance;

- (UIColor *)getUIColorWithHex: (int) hex;

@end