focus (not yet functional)
=====

### The answer to "What and where was I?" for terminal users.  Just type _focus_

####Quickly Remember and switch between recent projects.

*focus* is an app to maintain recent project directory paths with minimal effort.  (WHAT!?)

For those of us who work on a new project every week, you can keep your latest X projects in a focus group, 
and switch among them with this single command.

## Example

*Go to your directory of your latest project*

    $~: cd Projects/Client/resources/web/
    
*Use focus to set this directory*

    $~/Projects/Client/resources/web/: focus set
  
*Next time you load up a terminal, return with ease*

    $~: focus
    $~/Projects/Client/resources/web/: 

*Also, cycle backward through previous focus paths with the same exact command

     $~/Projects/Client/resources/web/: focus   
     $~/Projects/PreviousProject/ios/ipad/app:      

No more need to remember each project's structure and location.  Simply return!
  
####
*DISCLAIMER* Yes, you can do this with system's `pushd` and `popd`, but I've honestly found their workflow annoying (changing dir on pushd, removing on use of popd).  
Additionally, a stack is generally annoying to clean/order/adjust.  Focus is meant to keep things clear.

