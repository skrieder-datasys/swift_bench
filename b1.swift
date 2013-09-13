import sys;
import io;
import python;

main {
  //N = 1000000;
  N = toint(argv("N"));
  printf("N: %i\n", N);
  foreach i in [0:N-1] {
    python("'{0}'.format(2+2)");
  }
}
