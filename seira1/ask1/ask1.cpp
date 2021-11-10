#include <stdio.h> 
#include <fstream>
#include <iostream>
#include <bits/stdc++.h>

using namespace std; 

/*https://www.geeksforgeeks.org/longest-subarray-having-average-greater-than-or-equal-to-x-set-2/*/

int maxIndexDiff(int arr[], int n)
{
    int maxDiff;
    int i, j;
    
    std::vector<int> LMin(n); 
    
    std::vector<int> RMax(n); 
   
    LMin[0] = arr[0];
    //cout << LMin[0] << " ";
    for (i = 1; i < n; ++i){
        LMin[i] = min(arr[i], LMin[i - 1]);
       // cout << LMin[i] << " ";
        }
   //cout << endl;
    RMax[n - 1] = arr[n - 1];
    
    for (j = n - 2; j >= 0; --j){
        RMax[j] = max(arr[j], RMax[j + 1]);
       
        
    }
    for(int i=0;i<=n-2;i++){
      //  cout << RMax[i] << " ";
    }
    //cout << RMax[n-1] << " ";
   // cout << endl;
    i = 0, j = 0, maxDiff = -1;
    while (j < n && i < n) {
        
        if (LMin[i] < RMax[j]) {
            maxDiff = max(maxDiff, j-i);
           // cout << "i = " << i << " j = " << j << " maxDiff = " << maxDiff << endl;

            j = j + 1;
           // cout<<j-i<<endl; 
        }
        else
            i = i + 1;
           // cout<<-(arr[i]+3*i)<<endl;
    }
    if(i==0)
    maxDiff=maxDiff+1;
    //cout<<"for i="<<i<<"and j="<<j<<endl;
    return maxDiff ;
}

void modifyarr(int arr[], int n, int x)
{
    for (int i = 0; i < n; i++){
        
        arr[i] = arr[i] - x;
    
    }
   
}

void calcprefix(int arr[], int n){
    int s = 0;
    for (int i = 0; i < n; i++) {
        s += arr[i];
        arr[i] = s;
        //cout<<arr[i]<<" ";
    }
   // cout<<endl;
}
int longestsubarray(int arr[], int n, int x)
{
    modifyarr(arr, n, x);
    calcprefix(arr, n);
    return maxIndexDiff(arr, n);
}

int main(int argc, char *argv[]){
  
   
  int n, m;
  std::fstream myfile(argv[1], std::ios_base::in);
  myfile>>m>>n;
  
  int k[m];
  int a=0;
  for(int i=0;i<m;i++){
        myfile>>(a);
        k[i]=-a;
        
  }
  
  cout<< longestsubarray(k,m,n)<< endl;
}

