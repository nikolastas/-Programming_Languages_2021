public class Goat {
  // The main function.
  public static void main(String args[]) {
    Solver solver = new BFSolver();
    State initial = new GoatState(false, false, false, false, null);
    State result = solver.solve(initial);
    if (result == null) {
      System.out.println("No solution found.");
    } else {
      printSolution(result);
    }
  }

  // A recursive function to print the states from the initial to the final.
  private static void printSolution(State s) {
    if (s.getPrevious() != null) {
      printSolution(s.getPrevious());
    }
    System.out.println(s);
  }
}
