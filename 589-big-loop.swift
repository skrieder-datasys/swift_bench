/*
  Reported to exm-user by Scott Krieder on 10/24/2012
  Cannot reproduce problem. -Justin
*/

import io;
import sys;

main
{
//     int bound = 32;
//     float sleepTime = 0.001;

     int bound = toint(argv("bound"));
     float sleepTime = tofloat(argv("sleeptime"));

     // print for debug
     printf("The number of arguments is: %i\n", argc());
     printf("The bound is: %i\n", bound);
     printf("The sleeptime is: %f\n", sleepTime);

     // run the sleep
     foreach i in [1:bound:1]{
               sleep(sleepTime);
     }
}
