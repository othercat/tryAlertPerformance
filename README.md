tryAlertPerformance
==============

Histroy
-------------
version 0.1.0: 

* add 3rd button to send Nofitication message
* send notification message by the end of thread
	 
version 0.0.1:

* initial commit


Purpose
-------------
Figure out the differenct phenomenons between `NSRunAlertPanel` and `NSAlert` while we are implementing a alert window using Cocoa.

Usage
-------------
Just click the button to go

Known issues
-------------
* you have to force to quit the application.
* one button a turn. 

Result
-------------
Using `NSRunAlertPanle` is clearly slower than using `NSAlert` while the internal argument `count` hit the number 50 or above.

About
-------------

twitter: [@othercatlee](twitter.com/#!/othercatlee)


Licence
-------------

tryAlertPerformance uses GPLv2 License. 

Copyright (c) 2012-2013, Richard Li

All rights reserved.
   
