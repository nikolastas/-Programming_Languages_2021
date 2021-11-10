#include <iostream>
using namespace std;

int main(int argc, char *argv[]){
  FILE *file;
  int n,m,k; //number_of_hospital,     total_days,  number_of_patients
  int cons_days,counter;// longest_period,    
  file=fopen(argv[1],"r");
  cout << "ready" <<endl;
  fclose(file);
}
