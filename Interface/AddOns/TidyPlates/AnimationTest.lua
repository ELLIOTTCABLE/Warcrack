BB_x=0
 BB_y=0     --Setting the x and y vars, these are global vars (also saved vars) that get changed to random points on the screen upon mouseover of the frame. Both start off with a default of 0, which is the centre of the screen.

 local newFrame1=CreateFrame("Frame","aniFrame")        --Makes a Frame called "newFrame1", and gives it the ID "aniFrame" (for identification later on).
 newFrame1:SetHeight(100)               --100 pixels in height.
 newFrame1:SetWidth(100)                    --100 pixels in width.
 newFrame1:EnableMouse(true)                --This line you need to have if you want the mouse to interact with the Frame, tells newFrame1 that it's going to be doing things with the mouse.
 newFrame1:RegisterEvent("ADDON_LOADED")            --The RegisterEvent method makes the "OnEvent" widget handler specifically look for an event, which in this case is "ADDON_LOADED".

 local tex1=newFrame1:CreateTexture()   --This makes a new Texture called tex1. And made as the child of newFrame1.
 tex1:SetAllPoints(newFrame1)       --Just like SetPoint, this will do the exact same thing that newFrame1 did with its SetPoint. And each time newFrame1 gets new points, tex1 will get those points along with it.
 tex1:SetTexture(0,0,0)         --RGB colouring. 0,0,0 is full black.

 local newFrame2=CreateFrame("Frame")   --Another Frame callled "newFrame2", this and its Texture are duplicates of newFrame1 and tex1.
 newFrame2:SetHeight(100)
 newFrame2:SetWidth(100)
 newFrame2:Hide()           --Makes this Frame hidden.

 local tex2=newFrame2:CreateTexture()   --Another Texture "tex2", just like tex1.
 tex2:SetAllPoints(newFrame2)
 tex2:SetTexture(0,0,0)

 local newAni=newFrame2:CreateAnimationGroup()      --This makes an AnimationGroup with the name "newAni", and attaches it to newFrame2 as its child. The Animations can only be housed in AnimationGroups it seems.

 local animation1=newAni:CreateAnimation("Translation")     --Creates an Animation, as a child of newAni. In this case, a Translation, which just has an offset amount that it moves about.
 animation1:SetDuration(1)                  --Duration is the time it takes to do the animation, from start to finish. This animation takes 1 second.
 animation1:SetSmoothing("OUT")                 --"IN", "OUT", or "IN_OUT". "IN" makes the animation start slow and gradually accelerate faster. "OUT" makes it slow down til it stops.

 local animation2=newAni:CreateAnimation("Rotation")        --Creating another Animation, a child of newAni. Rotations, well, they rotate. You can set the degrees or rotation, a radian and point of rotation.
 animation2:SetDuration(1)
 animation2:SetSmoothing("OUT")
 --As BB_x and BB_y are both saved vars, they need to only be used after the saved variables are loaded. So to do that, I've set up a SetScript to use these vars after the addon is loaded (which always happens after the saved vars are loaded), otherwise it will use thier defaults.
 newFrame1:SetScript("OnEvent",function(_,_,addon)      --Gives newFrame1 a SetScript with the "OnEvent" handler. I've not bothered with self and event in its function, they're both just underscores as, well, they're not used. The only event registered to this Frame is "ADDON_LOADED".
 if addon=="BlackBox" then                  --The third arg "addon" gets the name of the addon that just loaded. This OnEvent fires a bunch of time, but only does the code when the addon "BlackBox" is loaded.
   newFrame1:SetPoint("CENTER",nil,"CENTER",BB_x,BB_y)      --Puts the centre of newFrame1 at BB_x and BB_y.
 end
 end)                               --Ends the function, closes the SetScript.

 newFrame1:SetScript("OnUpdate",function()              --Makes another SetScript for newFrame1. "OnUpdate" fires each time the frames update, not Frames as in widget objects, but frames as in FPS. Not putting self and elapsed in the function as they're not used.
 if GetMouseFocus() and GetMouseFocus():GetName()=="aniFrame" then  --GetMouseFocus() checks in the mouse cursor is over a Frame with an ID, and if it is, it returns true. Then it checks for the ID of the Frame that the mouse cursor is over, and if the ID is "aniFrame"(the ID given to newFrame1) it returns true and starts doing the code in the if statement.
   newFrame1:Hide()                         --This will hide newFrame1, as this is not the Frame that has the Animation.
   newFrame2:SetPoint("CENTER",nil,"CENTER",BB_x,BB_y)          --Places newFrame2 at the starting line.
   newFrame2:Show()                         --Shows newFrame2, this is the frame that does the Animation.
   local x=random(100,460)                      --Makes a local var called x. In WoW API "random" is short for "math.random" in Lua.
   local y=random(100,280)                      --And another called y. A random number between 100 and 280.
   if BB_x>0 then                           --If BB_x is greater than 0. Or, if the horizontal position is to right side of the screen.
     BB_x=BB_x-x    --Itself minus the x random. Left.
     x=x*-1  --Turns the x random into its negative number. Negative numbers will make it go to the left.
   else                                 --Everything else. Or, the left side of the screen (or very centre).
     BB_x=BB_x+x                                --Itself plus the x random.
   end
   if BB_y>0 then                           --Does the same as BB_x var, only for the vertical.
     BB_y=BB_y-y
     y=y*-1
   else
     BB_y=BB_y+y
   end
   newFrame1:SetPoint("CENTER",nil,"CENTER",BB_x,BB_y)          --Places newFrame1 at the finish line. It's still hidden.
   animation1:SetOffset(x,y)                        --Gives animation1 a new offset. The Offset is how far the animation travels, not a point on the screen where the animation should travel.
   local rot=random(0,1)
   if rot==1 then
     animation2:SetDegrees(180) --Sets how much the animation rotates, in degrees.
   else
     animation2:SetDegrees(-180)    --50:50 chance the animation rotates clockwise or anti-clockwise.
   end
   newAni:Play()                                --This will play the Animations in AnimationGroup "newAni", playing all of its children.
 end
 end)                                   --Ends the function, closes the SetScript.

 newAni:SetScript("OnFinished",function()   --This gives the AnimationGroup newAni, the SetScript handler (AnimationGroups have very little in the way of handlers) "OnFinished" which fires when all the children Animations of this AnimationGroup finish playing.
 newFrame1:Show()               --Shows newFrame1, which is at the finish line, allowing its mouseover to be used once more.
 newFrame2:Hide()               --Hides newFrame2, which is still at the starting line.
 end)                       --Ends the function, closes the SetScript.