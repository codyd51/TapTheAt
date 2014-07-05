#import <Preferences/Preferences.h>

@interface TapTheAtListController: PSListController {
}
-(void)openPaypal;
-(void)openTwitter;
-(void)openGithub;
@end

@implementation TapTheAtListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"TapTheAt" target:self] retain];
	}
	return _specifiers;
}
-(void)openTwitter {
	NSString *user = @"phillipten";
	if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetbot:"]])
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"tweetbot:///user_profile/" stringByAppendingString:user]]];
	
	else if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitterrific:"]])
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"twitterrific:///profile?screen_name=" stringByAppendingString:user]]];
	
	else if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetings:"]])
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"tweetings:///user?screen_name=" stringByAppendingString:user]]];
	
	else if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter:"]])
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"twitter://user?screen_name=" stringByAppendingString:user]]];
	
	else
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"https://mobile.twitter.com/" stringByAppendingString:user]]];
}
-(void)openPaypal {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=PHQ8HBVC2MBY8"]];
}
-(void) openGithub
{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"ioc://"]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"ioc://github.com/codyd51/TapTheAt"]];
    }
    else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/codyd51/TapTheAt"]];
    }
}
@end

// vim:ft=objc
