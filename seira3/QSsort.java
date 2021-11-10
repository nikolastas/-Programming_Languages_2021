import java.util.*;

import java.util.concurrent.TimeUnit;

import java.io.File;
import java.io.FileNotFoundException;

public class QSsort{

    public static void main(String args[]) throws FileNotFoundException{
        //long startTime = System.nanoTime();

       
       Scanner s = new Scanner(new File(args[0]));
       
       int size=s.nextInt();
       Queue<Integer> in_queue = new ArrayDeque<>(size);
       while(s.hasNextInt()){
         in_queue.add(s.nextInt());
       } 
       s.close();
       Solver solver = new zBFSolver();
       Stack<Integer> in_stack = new Stack<>();
       State initial = new QSstate(in_queue, in_stack,"");//state
       
       
       
       State result = solver.solve(initial);
       if(result == null){
           System.out.println("No solution found.");
       }
       else if(result.getPrevious() == ""){
           System.out.println("empty");
       }
       else {
           
           System.out.println(result.getPrevious());
       }
       
       //long endTime = System.nanoTime();
       //long timeElapsed = endTime - startTime;
       //System.out.println("Execution time in seconds: " + timeElapsed);

    }


} 


