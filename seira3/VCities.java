import java.util.*;




public class VCities{
    private int[] list;
    private int v;
    private int n;
    
    public VCities(int[] in_list, int in_v, int in_n){
        list = in_list;
        v = in_v;
        n = in_n;
    }

    private int Distance(int C, int i){
        int dist = (C - i) % n;
        if(dist < 0) dist = n + dist;     
        return dist;
    }
    
    private int SumFrom0(){
        int sum = 0;
        
        for(int i = 0; i < n; i++){
            
            
            sum += list[i] * Distance(0, i);
        }
        
       
        return sum;
    }    //sum from the first city to city target
    private int SumFromCityTarget(int C, int PrevSum){
        int sum = PrevSum + v -  n * list[C];
        
        return sum;
    }
    
    private int maxForCity(int C){
        int max = -1;
        int temp = 0;
        for(int i = 0; i < n; i++){
          if(list[i] > 0) temp = Distance(C, i);
          if(temp > max) max = temp;
        }
        return max;
    }
    class ZMyResult {
        private final int first;
        private final int second;
    
        public ZMyResult(int first, int second) {
            this.first = first;
            this.second = second;
        }
    
        public int getFirst() {
            return first;
        }
    
        public int getSecond() {
            return second;
        }
    }
    public ZMyResult getMandC(){
       int minMoves = 999999999; //M
       int bestC = -1; //C
       int tempMax = maxForCity(0);
       int tempSum = SumFrom0();
       if (tempMax <= tempSum - tempMax + 1){ 
              minMoves = tempSum;
              bestC = 0;
          }
       for(int i = 1; i < n; i++) { // i is the  City - Target
            tempSum = SumFromCityTarget(i, tempSum);
          if(tempSum<minMoves ) {
            tempMax = maxForCity(i);
            if ( (tempMax <= tempSum - tempMax + 1)){ 
                minMoves = tempSum;
                bestC = i;
            } 
          }
          
          
       }
       return new ZMyResult(minMoves, bestC);
    }
    
 } 