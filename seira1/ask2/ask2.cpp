#include <stdio.h> 
#include <fstream>
#include <iostream>

using namespace std;


struct list_node {
    int hor;
    int ver;
    list_node *next;
};

int moveRL(char a, int j){
    int temp=0;
    switch (a) {
        case 'U':
            temp= j;
            break;
        case 'D':
            temp= j;
            break;
        case 'R' :
            temp= (j+1);
            break;
        case 'L':
            temp= (j-1);
            break;
    }    
    return temp;
}
int moveUD(char a, int i){
    int temp=0;
      switch (a) {
        case 'U':
            temp= (i-1);
            break;
        case 'D':
            temp= (i+1);
            break;
        case 'R':
            temp= i;
            break;
        case 'L':
            temp= i;
            break;
      }
      return temp;
}

int loses(char a, int i, int j, int n, int m, char A[][1000], list_node* l){
    
    list_node* p;
    p = new list_node;
    p = l;
    while (p != nullptr){
        
        if ((i == (p->ver)) && (j == (p->hor))){
            
            return 1;
        } 
        else (p = p->next);
    }  

    if((moveRL(a, j) < 0) || (moveRL(a,j) >= m )|| (moveUD(a, i) < 0) || (moveUD(a, i) >= n)) {
        
        return 0;
    }
    
    /*
    else if (A[moveUD(a,i)][moveRL(a,j)]==0){
    A[i][j]=0;
    }
    else if(A[moveUD(a,i)][moveRL(a,j)]==A[i][j]){
        A[i][j]=1;
    }
    else if(A[moveUD(a,i)][moveRL(a,j)]==1){
    A[i][j]=1;
    }
    */
    
    else{
        list_node* q;
        q = new list_node;
        q->hor = j;
        q->ver = i;
        q->next = l;
        
        return loses(A[moveUD(a,i)][moveRL(a,j)], moveUD(a,i), moveRL(a,j), n, m, A, q);
  }
}


int main(int argc, char *argv[]){
    int n,m;
    int visitedRL,visitedUD;
    std::fstream myfile(argv[1], std::ios_base::in);
    myfile>>n>>m;
    char A[1000][1000];
    for(int i=0;i<n;i++){
        
        for(int j=0;j<m;j++){
            myfile>>A[i][j];
            
        }
    }
    int count = 0;
    list_node* l=nullptr;
    int c;
    
    
    for(int i=0;i<n;i++){
        for(int j=0;j<m;j++){
            count += loses(A[i][j], i, j, n, m, A, l);
            //cout<< i << ", " << j << ": " << loses(A[i][j], i, j, n, m, A, l)<< endl;
        }
    }
    cout << count << endl;
}