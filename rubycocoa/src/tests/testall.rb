require 'test/unit'

`ls tc_*.rb`.each do |testcase|
  testcase.chop!
  $stderr.puts testcase
  require( testcase )
end
