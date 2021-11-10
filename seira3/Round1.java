import java.util.*;

import java.util.concurrent.TimeUnit;

import java.io.File;
import java.io.FileNotFoundException;

public class Round1{

    public static void main(String args[]) throws FileNotFoundException{
        //long startTime = System.nanoTime();
        long start = System.currentTimeMillis();
       Scanner s = new Scanner(new File(args[0]));
       
       int n = s.nextInt();
       int v = s.nextInt();
       int list[];
       list = new int[v];
       for(int i = 0; i < v; i++){
         list[i] = s.nextInt();
       } 
       s.close();
       long end_making_the_list = System.currentTimeMillis()-start;
       System.out.println("list: "+end_making_the_list);
       Vehicles veh = new Vehicles(list, v, n);
       ZMyResult mr;
       mr = veh.getMandC();
       int M = mr.getFirst();
       int C = mr.getSecond();
        
       System.out.println(M+" "+C);
       long finish = System.currentTimeMillis();
       long timeElapsed = finish - start;
       System.out.println(timeElapsed);
       //long endTime = System.nanoTime();
       //long timeElapsed = endTime - startTime;
       //System.out.println("Execution time in seconds: " + timeElapsed);

    }


}         