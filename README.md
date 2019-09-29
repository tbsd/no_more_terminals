# no_more_terminals
Deals with opening of hundred of terminals during work process


### Problem
Every time while I need a terminal I press the shortcut on keyboard which opens a new terminal window, even if there is a free terminal because it's much faster than alt+tab through lots of windows. As a result, I end up with ten terminals that does nothing but clutter up my workspace.


### Solution 
I've made a script that looking through terminal on current workspace and if there is a free one switching to it and in another case opening a new terminal. Not the most elegant script in the world, but it works somehow.


### Usage
Bind this script to your "open terminal" shortcut. 
Also, it may be useful to create another binding for opening a terminal anyway. Note, that it must be open with a new PID (use --disable-factory option for gnome-terminal).  


### Requirements
* gnome-terminal
* xdotool


### TODO
Maybe add iterating through all terminals when free terminal selected.
