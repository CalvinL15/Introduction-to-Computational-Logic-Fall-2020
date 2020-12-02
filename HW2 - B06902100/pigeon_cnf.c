//HW2 - Introduction to Computational Science
//Name: Calvin Liu (劉益瑋)
//Student ID: B06902100

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h> 

int main(int argc, char** argv) {

  int n = 0, m = 0;
  int i, j;  // pigeons i, j
  int k;     // hole k

  printf("Enter the number of pigeons and holes:\n");
  while(n < 1 || m < 1){
      scanf("%d %d", &n, &m);
      if(n<1 || m<1){
        printf("Invalid input(s); n and m have to be > 0!\n");
      }
  }
  
  FILE *fp;
  char filename[100] = "output files/Output (n,m) = (";
  char buf[100];
  sprintf(buf, "%d", n);
  strcat(filename, buf);
  memset(buf, 0, sizeof(buf));
  strcat(filename, ",");
  sprintf(buf, "%d", m);
  strcat(filename, buf);
  strcat(filename, ").txt");
  fp = fopen(filename, "w");
  
  fprintf(fp, "c Pigeonhole problem: placing %d pigeons into %d holes\n", n, m);
  printf("c Pigeonhole problem: placing %d pigeons into %d holes\n", n, m); 
 
  fprintf(fp, "p cnf %d %d\n", n * m, n + (n * (n-1) * m) / 2);
  printf("p cnf %d %d\n", n * m, n + (n * (n-1) * m) / 2);  
  //a pigeon has to be placed in some hole (pigeon i lives in a hole).
  for (i=1; i <= n; i++) {
    for (k=1; k <= m; k++){
      printf("%d ", m*(i-1)+k);
      fprintf(fp, "%d ", m*(i-1)+k);
    }
    printf("0\n");
    fprintf(fp, "0\n");
  }
  // for each hole we have a set of clauses ensuring that at most one pigeon lives in that hole.
  for (k=1; k <= m; k++)
    for (i=1; i <= n; i++)
      for (j=i+1; j <= n; j++){
        fprintf(fp, "-%d -%d 0\n", m*(i-1)+k, m*(j-1)+k);
        printf("-%d -%d 0\n", m*(i-1)+k, m*(j-1)+k);
      }
  return 0;
}