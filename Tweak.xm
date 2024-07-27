#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <IOSurface/IOSurface.h>
#import <QuartzCore/QuartzCore2.h>
#import <QuartzCore/CAAnimation.h>
#import <UIKit/UIGraphics.h>
#import <objc/runtime.h>
#import <stdio.h>
#import <string.h>
#import <stdlib.h>
#import <notify.h>
#import <Foundation/NSTask.h>


//--------Rounded switches :D
%hook UISwitch

-(void)setFrame:(CGRect)frame{
	if(frame.origin.x <= 220){

	%orig(CGRectMake(frame.origin.x + 40, frame.origin.y, 60, 25));

}
else{
	%orig;
}
}




-(id)initWithFrame:(CGRect)frame{
		if(frame.origin.x <= 220){
	
	return %orig(CGRectMake(frame.origin.x + 40, frame.origin.y, 60, 25));

}
else{
	return %orig;
}
}

-(CGSize)sizeThatFits:(CGSize)fits{

	return CGSizeMake(60, 30);

}
%end

@interface _UISwitchSlider : UISlider{

}
	BOOL resizedFrames;
	UIImageView *thumb;
@end

%hook _UISwitchSlider

/*
-(id)initWithFrame:(CGRect)frame{
		if(frame.origin.x <= 220){
	frame = CGRectMake(frame.origin.x + 50, frame.origin.y, 60, 25);
}
self = %orig;
resizedFrames = FALSE;
if(self){

	}
	return self;

}
*/

-(CGSize)sizeThatFits:(CGSize)fits{

	return CGSizeMake(60, 25);

}




-(id)currentThumbImage{ 


	return [[UIImage imageWithContentsOfFile:@"/var/mobile/Whited00r/resources/SliderThumb.png"] stretchableImageWithLeftCapWidth:30 topCapHeight:-10];

}

-(void)_initSubviews{

	%orig;

NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
UIImage *minImage = [UIImage imageWithContentsOfFile:@"/var/mobile/Whited00r/resources/SliderMin.png"];
UIImage *maxImage = [UIImage imageWithContentsOfFile:@"/var/mobile/Whited00r/resources/SliderMax.png"];

minImage = [minImage stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0];
maxImage = [maxImage stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0];
// thumbImage = [minImage stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0];

[self setMinimumTrackImage:minImage forState:UIControlStateNormal];
[self setMaximumTrackImage:maxImage forState:UIControlStateNormal];
[pool drain];

}


-(void)layoutSubviews{

	%orig;

NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	//[[self valueForKey:@"maxTrackView"] removeFromSuperview];
	//[[self valueForKey:@"minTrackView"] removeFromSuperview];
self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, 60, 30);
	UIImageView *maxView = [self valueForKey:@"maxTrackView"];
	UIImageView *minView = [self valueForKey:@"minTrackView"];

	CGRect maxFrame = maxView.frame;
	CGRect minFrame = minView.frame;

	minView.frame = CGRectMake(minFrame.origin.x + 7, minFrame.origin.y, minFrame.size.width, minFrame.size.height);
	maxView.frame = CGRectMake(maxFrame.origin.x - 7, maxFrame.origin.y, maxFrame.size.width - 7, maxFrame.size.height);

	minView.layer.cornerRadius = minFrame.size.height / 2;
	maxView.layer.cornerRadius = maxFrame.size.height / 2;

	UIImageView *thumbView = [self valueForKey:@"thumbView"];
	CGRect thumbFrame = thumbView.frame;
	thumbView.frame = CGRectMake(thumbFrame.origin.x + 5, thumbFrame.origin.y, thumbFrame.size.width, thumbFrame.size.height + 2);
	thumbView.layer.cornerRadius = thumbFrame.size.height / 2;
	//thumbView.layer.clipsToBounds = FALSE;

	UIView *leftLabel = [self valueForKey:@"offLabelView"];
	UIView *rightLabel = [self valueForKey:@"onLabelView"];
	UIView *labelClip = [self valueForKey:@"labelClipView"];
	[leftLabel removeFromSuperview];
	[rightLabel removeFromSuperview];
	[labelClip removeFromSuperview];

[pool drain];

}

-(void)setBounds:(CGRect)bounds{

	%orig(CGRectMake(bounds.origin.x, bounds.origin.y, 60, 30));

}

%end