//
//  FirstViewController.m
//  autocellheight
//
//
//	Copyright 2011 by Rodney Degracia (rdegraci@gmail.com)
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in
//	all copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//	THE SOFTWARE.
//
//

#import "FirstViewController.h"
#import "MyTableViewCell.h"

@implementation FirstViewController

@synthesize labelTextArray;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	self.labelTextArray = [NSMutableArray array];
	
	[labelTextArray addObject:@"UILabel text body 0 UILabel text body 0 UILabel text body 0 UILabel text body 0 UILabel text body 0 UILabel text body 0"];
	[labelTextArray addObject:@"UILabel text body 1 UILabel text body 1 UILabel text body 1 UILabel text body 1 UILabel text body 1 UILabel text body 1 UILabel text body 1 UILabel text body 1 UILabel text body 1 UILabel text body 1 UILabel text body 1 UILabel text body 1"];
	[labelTextArray addObject:@"UILabel text body 2 UILabel text body 2 UILabel text body 2 UILabel text body 2 UILabel text body 2 UILabel text body 2 UILabel text body 2 UILabel text body 2 UILabel text body 2 UILabel text body 2 UILabel text body 2 UILabel text body 2 UILabel text body 2 UILabel text body 2 UILabel text body 2 UILabel text body 2"];
	
	
    [super viewDidLoad];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	
	myTableView = nil;
	
	self.labelTextArray = nil;
	
	[super viewDidUnload];
}


- (void)dealloc {
	
	self.labelTextArray = nil;
	
    [super dealloc];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	
	NSString* label = [NSString stringWithString:[labelTextArray objectAtIndex:[indexPath row]]];
	
	CGSize labelTextSizeConstraint = { 280.f, 999.0f };	// The width of the label is specified in MyCell.xib as 280.0f
	CGSize labelTextSize = [label sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:labelTextSizeConstraint lineBreakMode:UILineBreakModeWordWrap];
	

	// The height of the Cell's view is specified in MyCell.xib as 300.0f
	// therefore to maintain the correct metrics, we must add 300.f to the height.
	// In all cases, we must _never_ add less than Cell's view height that is
	// specified in MyCell.xib, or else the screen drawing will be wrong.
	return (labelTextSize.height + 300.0f);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	
	MyTableViewCell* cell = (MyTableViewCell*) [tableView dequeueReusableCellWithIdentifier:@"MyTableViewCell"];
	
	// Load the cell from its NIB
	if (cell == nil) {
		NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"MyCell" owner:self options:nil];
		
		for (id oneObject in nib) {
			if ([oneObject isKindOfClass:[MyTableViewCell class]]) {
				cell = (MyTableViewCell*)oneObject;
			}; 
		}
	}
	
	// The width of the label is specified in MyCell.xib as 280.f and the label is specified in MyCell.xib to word wrap
	NSString* labelText = [NSString stringWithString:[labelTextArray objectAtIndex:[indexPath row]]];
	CGSize	labelTextSizeConstraint = { 280.f, 999.0f };
	CGSize labelTextSize = [labelText sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:labelTextSizeConstraint lineBreakMode:UILineBreakModeWordWrap];
	
	NSAssert(cell.label != nil, @"cell.label is nil!");
	cell.label.text = labelText;
	
	//Resize the UILabel, to fit the text
	CGRect labelRect = CGRectMake (cell.label.frame.origin.x , cell.label.frame.origin.y, cell.label.frame.size.width, labelTextSize.height);
	cell.label.frame = labelRect;
	
	// Move button element in the UIView downward to compensate for the resize due to the UILabel
	NSAssert(cell.button != nil, @"cell.button is nil!");
	CGRect buttonRect = CGRectMake (cell.button.frame.origin.x , (cell.button.frame.origin.y + labelTextSize.height) , cell.button.frame.size.width, cell.button.frame.size.height);
	cell.button.frame = buttonRect;
	
	// Move imageView element in the UIView downward to compensate for the resize due to the UILabel
	NSAssert(cell.imageView != nil, @"cell.imageView is nil!");
	CGRect imageViewRect = CGRectMake (cell.imageView.frame.origin.x , (cell.imageView.frame.origin.y + labelTextSize.height), cell.imageView.frame.size.width, cell.imageView.frame.size.height);
	cell.imageView.frame = imageViewRect;
	
	return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	return [labelTextArray count];
}


@end
