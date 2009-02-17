#
#  ÇFILENAMEÈ
#  ÇPROJECTNAMEÈ
#
#  Created by ÇFULLUSERNAMEÈ on ÇDATEÈ.
#  Copyright (c) 2001 ÇORGANIZATIONNAMEÈ. All rights reserved.
#

require 'osx/cocoa'

class ÇFILEBASENAMEASIDENTIFIERÈ <  OSX::NSView

  ns_overrides 'initWithFrame:', 'drawRect:'

  def initWithFrame (frame)
    super_initWithFrame(frame)
    # Initialization code here.
    return self
  end

  def drawRect (rect)
    # Drawing code here.
  end

end
