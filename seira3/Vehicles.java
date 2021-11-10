import java.util.*;




public class Vehicles{
    private int[] list;
    private int v;
    private int n;
    
    public Vehicles(int[] in_list, int in_v, int in_n){
        list = in_list;
        v = in_v;
        n = in_n;
    }

    private int Distance(int C, int i){
        int dist = (C - i) % n;
        if(dist < 0) dist = n + dist;     
        return dist;
    }

    private int maxForCity(int C){
        int max = -1;
        for(int i = 0; i < v; i++){
          int temp = Distance(C, list[i]);
          if(temp > max) max = temp;
        }
        return max;
    }

    private int sumForCity(int C){
        int sum = 0;
        for(int i = 0; i < v; i++){
          sum += Distance(C, list[i]);
        }
        return sum;
    } 
    
    public ZMyResult getMandC(){
       int minMoves = 999999999;
       int bestC = -1;
       int tempSum, tempMax;
       for(int i = 0; i < n; i++) { // i is the  City - Target
          tempSum = sumForCity(i);
          tempMax = maxForCity(i);
          if ((tempSum < minMoves) && (tempMax <= tempSum - tempMax + 1)){ 
              minMoves = tempSum;
              bestC = i;
          }
       }
       return new ZMyResult(minMoves, bestC);
    }
    
 }         