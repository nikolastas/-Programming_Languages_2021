import java.util.*;

public class QSstate implements State{
    private Queue<Integer> queue;
    private Stack<Integer> stack;
    private String previous;
    
    public QSstate(Queue<Integer> in_queue, Stack<Integer> in_stack, String pr_move){
        queue = in_queue;
        stack = in_stack;
        previous=pr_move;
    }
    @Override
    public boolean isFinal(){
      
      Iterator<Integer> it = queue.iterator();
      if(queue.isEmpty() || !(stack.isEmpty()))
        return false;
      int comp = queue.peek();
      int temp ;
      while(it.hasNext()){
        temp = it.next();
        /*System.out.print("Comp: " + comp);
        System.out.println(it.next());*/
          if (comp > temp){
              
              return false;
          }
          else{
              comp = temp;
          }
      }
      
      return true;
    }
    @Override
    public boolean isBad(){
      return false;
    }
    @Override
    public Collection<State> next(){
      Collection<State> states = new ArrayList<>();
      Queue<Integer> nqueue = new ArrayDeque<>(queue);
      Stack<Integer> nstack = new Stack<Integer>();
      nstack.addAll(stack);
      if(!queue.isEmpty()){
        stack.push(queue.remove());
        states.add(new QSstate(queue, stack, previous.concat("Q")));
      }
      if (!nstack.isEmpty()){
        nqueue.add(nstack.pop());
        states.add(new QSstate(nqueue, nstack, previous.concat("S")));
      }
        return states;
    }
    @Override
    public String getPrevious(){
      return previous;
    }
    @Override
    public boolean equals(Object o) {
      if (this == o) return true;
      if (o == null || getClass() != o.getClass()) return false;
      QSstate other = (QSstate) o;
      return queue == other.queue && stack == other.stack;
    }

    @Override
    public int hashCode() {
    return Objects.hash(queue, stack);
    }
    
    @Override
    public Integer getLength() {
      return previous.length();
    }

    @Override
  public String toString() {
    StringBuilder sb = new StringBuilder(queue.toString());
    sb.append(stack.toString());
    
    return sb.toString();
  }
 } 




