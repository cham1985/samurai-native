//
//     ____    _                        __     _      _____
//    / ___\  /_\     /\/\    /\ /\    /__\   /_\     \_   \
//    \ \    //_\\   /    \  / / \ \  / \//  //_\\     / /\/
//  /\_\ \  /  _  \ / /\/\ \ \ \_/ / / _  \ /  _  \ /\/ /_
//  \____/  \_/ \_/ \/    \/  \___/  \/ \_/ \_/ \_/ \____/
//
//	Copyright Samurai development team and other contributors
//
//	http://www.samurai-framework.com
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

#import "Samurai_HtmlRenderWorklet_30UpdateFrame.h"

#import "_pragma_push.h"

#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)

#import "Samurai_HtmlRenderStyle.h"
#import "Samurai_HtmlMediaQuery.h"

#import "Samurai_HtmlSharedResource.h"

#import "Samurai_CssParser.h"
#import "Samurai_CssStyleSheet.h"

// ----------------------------------
// Source code
// ----------------------------------

#pragma mark -

@implementation SamuraiHtmlRenderWorklet_30UpdateFrame

- (BOOL)processWithContext:(SamuraiHtmlRenderObject *)renderObject
{
	if ( NO == CGSizeEqualToSize( renderObject.view.frame.size, CGSizeZero ) )
	{
		CGRect bound = renderObject.view.frame;
		CGRect frame = [renderObject computeFrame:bound.size origin:bound.origin];

		if ( NO == CGRectEqualToRect( frame, CGRectZero ) )
		{
			[self applyViewFrameForRender:renderObject];
		}
		else
		{
			[self clearViewFrameForRender:renderObject];
		}

	#if __SAMURAI_DEBUG__
		[renderObject dump];
	#endif	// #if __SAMURAI_DEBUG__
	}

	return YES;
}

#pragma mark -

- (void)applyViewFrameForRender:(SamuraiHtmlRenderObject *)renderObject
{
	if ( renderObject.view )
	{
		[renderObject.view applyFrame:renderObject.frame];
	}
	
	for ( SamuraiHtmlRenderObject * childRender in renderObject.childs )
	{
		[self applyViewFrameForRender:childRender];
	}
}

- (void)clearViewFrameForRender:(SamuraiHtmlRenderObject *)renderObject
{
	if ( renderObject.view )
	{
		[renderObject.view applyFrame:CGRectZero];
	}
	
	for ( SamuraiHtmlRenderObject * childRender in renderObject.childs )
	{
		[self applyViewFrameForRender:childRender];
	}
}

@end

// ----------------------------------
// Unit test
// ----------------------------------

#pragma mark -

#if __SAMURAI_TESTING__

TEST_CASE( UI, HtmlRenderWorklet_30UpdateFrame )
{
	//	TODO( @"test case" )
}
TEST_CASE_END

#endif	// #if __SAMURAI_TESTING__

#endif	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)

#import "_pragma_pop.h"
