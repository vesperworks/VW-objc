//
//  AsyncImageView.m
//
//  Created by vesperworks on 11/06/14.
//  Copyright 2011 vesperworks. All rights reserved.
//
//

#import <Foundation/Foundation.h>
@interface VWAsyncImageView : UIImageView {
	NSURLConnection *conn;
	NSMutableData *data;
	UIActivityIndicatorView *refreshSpinner;
}
- (void)loadImageURL: (NSString *) url withCollor:(UIColor *)color;
- (void)cancel;
@end