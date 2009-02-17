#import "RBRuntime.h"

int main(int argc, const char *argv[]) {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	int ret = RBApplicationMain("main.rb", argc, argv);
	[pool release];
	return ret;
}
