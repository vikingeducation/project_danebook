class StaticPagesController < ApplicationController
  
  def timeline
    @friends = [ "Ron<br>Weasley", "Hermione<br>Granger", "Ginny<br>Weasley", 
                 "paragraph<br>text", "paragraph<br>text", "paragraph<br>text"]
    NUM_FRIENDS = 6
  end
  
end
