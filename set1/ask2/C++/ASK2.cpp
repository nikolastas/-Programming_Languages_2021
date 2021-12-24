#include <stdio.h> 
#include <fstream>
#include <iostream>

using namespace std;




class rows_and_colums {
    public:
        int row;
        int colum;
};

rows_and_colums move(char a, size_t c , size_t r){ 
    rows_and_colums rowAndColum;
    rowAndColum.row=r;
    rowAndColum.colum=c;
    switch (a) {
        case 'U':
            rowAndColum.row = r-1;
            break;
        case 'D':
            rowAndColum.row = r+1;
            break;
        case 'R' :
            rowAndColum.colum = (c+1);
            break;
        case 'L':
            rowAndColum.colum = (c-1);
            break;
        case 'W':
            break;
    }    
    return rowAndColum;
}

bool winner(char a, int c, int r, int max_c,int max_r){
    rows_and_colums result=move(a,c,r);
    return((result.colum<0 ) || (result.row<0) || (result.row>=max_r) || (result.colum>=max_c)|| (result.row==r && result.colum==c));
}
bool is_valid(int c , int r, int max_c,int max_r){
    return(c>=0 && c<max_c && r>=0 && r<max_r);
}
rows_and_colums from_block(char a[1000][1000], int c, int r, int max_c,int max_r){
    rows_and_colums result;
    if(is_valid(c,r-1,max_c,max_r)){
      result = move(a[r-1][c],c,r-1);
      if(result.row==r){
        result.row=r-1;
        result.colum=c;
        return result;
     }
     }
    
    if(is_valid(c,r+1,max_c,max_r)){
     result = move(a[r+1][c],c,r+1);
      if(result.row==r){
        result.row=r+1;
        result.colum=c;
        return result;

      }
     }
    if(is_valid(c-1,r,max_c,max_r)){
     result = move(a[r][c-1],c-1,r);
     if(result.colum==c){
        result.row=r;
        result.colum=c-1;
        return result;

    }
    }

    
    if(is_valid(c+1,r,max_c,max_r))  {
    rows_and_colums result = move(a[r][c+1],c+1,r);
    if(result.colum==c ){
      result.row=r;
      result.colum=c+1;
      return result;
    }
    
    }
    a[r][c] = 'W';
    result.row=-1;
    result.colum=-1;
    return result;
}
int win_path (char a[1000][1000], int c, int r, int max_c, int max_r){
  
   int counter = 0;
   
   while (1){
    rows_and_colums result=from_block(a,c,r,max_c,max_r);

    if((result.row == -1) && (result.colum == -1)) {
      
        break;
    }
    else{
      counter += win_path(a,result.colum,result.row,max_c,max_r);
        if(counter>>1){
            a[r][c]='W';
        }
   }
   }
   return (counter + 1);
}



int main(int argc, char *argv[]){
    int n,m, counter = 0;
    std::fstream myfile(argv[1], std::ios_base::in);
    myfile>>n>>m;
    char A[1000][1000];
    for(int i=0;i<n;i++){
        for(int j=0;j<m;j++){
            myfile>>A[i][j];
        }
    }
   
    for(int i =0;i<n;i++){
      if (winner(A[i][0], 0, i, m, n) && A[i][0]!='W'){
          counter += win_path (A, 0, i, m, n);
      }
      if(winner(A[i][(m - 1)], (m - 1), i, m, n) && A[i][(m-1)]!='W'){
          counter += win_path (A, (m - 1) , i, m, n);
      }
    }
    for(int j =1; j<(m - 1); j++){
      if (winner(A[0][j], j, 0, m, n) && A[0][j]!='W'){
          counter += win_path(A, j, 0, m, n);

      }

      if(winner(A[(n - 1)][j], j, n-1, m, n) && A[(n-1)][j]!='W'){
          counter += win_path (A, j,(n-1), m, n);
    }

    }

    int loop_room = (n * m) - counter;
    cout << loop_room << endl;

   /* for (int i=0;i<n;i++){
        cout<<endl;
        for(int j=0;j<m;j++){
            cout<<A[i][j];
        }
    }*/
}



