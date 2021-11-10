#include <stdio.h> 
#include <fstream>
#include <iostream>
#include <vector>

using namespace std;




int main(int argc, char *argv[]){
    int n,m;
    std::fstream myfile(argv[1], std::ios_base::in);
    myfile>>n>>m;
    char a[n][m];
    for(int i=0;i<n;i++){
        for(int j=0;j<m;j++){
            myfile>>a[i][j];
        }
    }
    
}