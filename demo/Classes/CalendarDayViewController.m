//
//  CalendarDayViewController.m
//  Demo
//
//  Created by Devin Ross on 3/16/13.
//
//

#import "CalendarDayViewController.h"

@implementation CalendarDayViewController

- (NSUInteger) supportedInterfaceOrientations{
	return  UIInterfaceOrientationMaskPortrait;
}
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}



- (void) viewDidLoad{
	[super viewDidLoad];
	
	self.data = @[
  @[@"Meeting with five random dudes", @"Five Guys", @5, @0, @10, @0],
  @[@"Unlimited bread rolls got me sprung", @"Olive Garden", @7, @0, @12, @0],
  @[@"Appointment", @"Dennys", @15, @0, @18, @0],
  @[@"Hamburger Bliss", @"Wendys", @15, @0, @18, @0],
  @[@"Fishy Fishy Fishfelayyyyyyyy", @"McDonalds", @5, @30, @6, @0],
  @[@"Turkey Time...... oh wait", @"Chick-fela", @14, @0, @19, @0],
  @[@"Greet the king at the castle", @"Burger King", @19, @30, @30, @0]];
	
}

#pragma mark TKCalendarDayViewDelegate
- (NSArray *) calendarDayTimelineView:(TKCalendarDayView*)calendarDayTimeline eventsForDate:(NSDate *)eventDate{
	
	if([eventDate compare:[NSDate dateWithTimeIntervalSinceNow:-24*60*60]] == NSOrderedAscending) return @[];
	if([eventDate compare:[NSDate dateWithTimeIntervalSinceNow:24*60*60]] == NSOrderedDescending) return @[];

	NSDateComponents *info = [[NSDate date] dateComponentsWithTimeZone:calendarDayTimeline.timeZone];
	info.second = 0;
	NSMutableArray *ret = [NSMutableArray array];
	
	for(NSArray *ar in self.data){
		
		TKCalendarDayEventView *event = [calendarDayTimeline dequeueReusableEventView];
		if(event == nil) event = [TKCalendarDayEventView eventView];
	
		event.identifier = nil;
		event.titleLabel.text = ar[0];
		event.locationLabel.text = ar[1];
		
		info.hour = [ar[2] intValue];
		info.minute = [ar[3] intValue];
		event.startDate = [NSDate dateWithDateComponents:info];
		
		info.hour = [ar[4] intValue];
		info.minute = [ar[5] intValue];
		event.endDate = [NSDate dateWithDateComponents:info];

		[ret addObject:event];
		
	}
	return ret;
	

}
- (void) calendarDayTimelineView:(TKCalendarDayView*)calendarDayTimeline eventViewWasSelected:(TKCalendarDayEventView *)eventView{
	TKLog(@"%@",eventView.titleLabel.text);
}


@end
