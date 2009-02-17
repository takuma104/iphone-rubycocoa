#
#  Spotlight.rb
#  Spotlight
#
#  Created by Norberto Ortigoza on 9/12/05.
#  Copyright (c) 2005 CrossHorizons. All rights reserved.
#

require 'osx/cocoa'
include OSX

class Spotlight < NSObject

  attr :query, true
  attr :predicate, true
  ns_override :dealloc
  
  def init
    @query = NSMetadataQuery.alloc.init
    return self
  end
  
  def search
    begin
      predicateToRun = NSPredicate.predicateWithFormat(@predicate, nil)
    rescue OCException
      p "FIX IT: I haven't find a way to check if the predicate's format is valid"
      predicateToRun = NSPredicate.predicateWithFormat("kMDItemDisplayName == ''", nil)
    end
      @query.setPredicate(predicateToRun)
      @query.startQuery()
  end

  def stop
    @query.stopQuery()
  end
  
  def register_for_notification(aDelegate, methodName)
    @query.setDelegate(aDelegate)
    NSNotificationCenter.defaultCenter.addObserver(aDelegate,
           :selector, methodName,
           :name, :NSMetadataQueryDidFinishGatheringNotification, 
           :object, @query);
  end
  
  def remove_delegate (aDelegate)
    NSNotificationCenter.defaultCenter.removeObserver(aDelegate,
                  :name, :NSMetadataQueryDidFinishGatheringNotification,
                  :object, nil);
  end
  
  def dealloc
    stop()
    super_dealloc()
  end
  
end
