//
//  VWStepper.h
//
//  Created by vesperworks on 11/10/16.
//  Copyright 2011 vesperworks. All rights reserved.
//

#import <Foundation/Foundation.h>
@class VWStepper;


@protocol VWStepperDelegate <NSObject>

- (void)stepperPageChanged: (VWStepper *) stepper;
- (void)stepperPageNext: (VWStepper *) stepper;
- (void)stepperPageprev: (VWStepper *) stepper;
- (void)stepperPageMax: (VWStepper *) stepper;
- (void)stepperPageMin: (VWStepper *) stepper;

@end


@interface VWStepper : NSObject {
	NSString *_identifier;
	NSString *_CHANGED;
	NSString *_NEXT;
	NSString *_PREV;
	NSString *_IS_MAX;
	NSString *_IS_MIN;

	BOOL isInitialized;

	int _page;
	int _pPage;

	int _min;
	int _max;
}

@property (nonatomic, retain) NSString *CHANGED;
@property (nonatomic, retain) NSString *NEXT;
@property (nonatomic, retain) NSString *PREV;
@property (nonatomic, retain) NSString *IS_MAX;
@property (nonatomic, retain) NSString *IS_MIN;

@property (nonatomic) BOOL doNotDispathEvent;

@property (nonatomic,assign) id delegate;

@property (nonatomic) int page;
@property (nonatomic) int previousPage;
@property (nonatomic) int max;
@property (nonatomic) int min;

- (id)initWithMinPage: (int) min andMax: (int) max;
- (void)resetWithMinPage: (int) min andMax: (int) max;
- (void)next;
- (void)prev;
- (void)jumpTo: (int) newPage;
- (void)update;
- (void)forceUpdate;
- (void)changeTo: (int) newPage;
- (int)validateTo: (int) newPage;

@end