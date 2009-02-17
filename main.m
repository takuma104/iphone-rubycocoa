#import <UIKit/UIKit.h>
#import "ruby.h"

int main(int argc, char *argv[]) {
    {
        RUBY_INIT_STACK
        ruby_init();
        ruby_options(argc, argv);
        ruby_run();
    }
    return 0;
}
