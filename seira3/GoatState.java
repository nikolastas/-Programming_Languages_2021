import java.util.*;

/* A class implementing the state of the well-known problem with the
 * wolf, the goat and the cabbage.
 */
public class GoatState implements State {
  // The positions of the four players; false = west and true = east.
  private boolean man, wolf, goat, cabbage;
  // The previous state.
  private State previous;

  public GoatState(boolean m, boolean w, boolean g, boolean c, State p) {
    man = m; wolf = w; goat = g; cabbage = c;
    previous = p;
  }

  @Override
  public boolean isFinal() {
    return man && wolf && goat && cabbage;
  }

  @Override
  public boolean isBad() {
    return wolf == goat && man != goat
        || goat == cabbage && man != cabbage;
  }

  @Override
  public Collection<State> next() {
    Collection<State> states = new ArrayList<>();
    states.add(new GoatState(!man, wolf, goat, cabbage, this));
    if (man == wolf)
      states.add(new GoatState(!man, !wolf, goat, cabbage, this));
    if (man == goat)
      states.add(new GoatState(!man, wolf, !goat, cabbage, this));
    if (man == cabbage)
      states.add(new GoatState(!man, wolf, goat, !cabbage, this));
    return states;
  }

  @Override
  public State getPrevious() {
    return previous;
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder("State: ");
    sb.append("man=").append(man ? "e" : "w");
    sb.append(", wolf=").append(wolf ? "e" : "w");
    sb.append(", goat=").append(goat ? "e" : "w");
    sb.append(", cabbage=").append(cabbage ? "e" : "w");
    return sb.toString();
  }

  // Two states are equal if all four are on the same shore.
  @Override
  public boolean equals(Object o) {
    if (this == o) return true;
    if (o == null || getClass() != o.getClass()) return false;
    GoatState other = (GoatState) o;
    return man == other.man && wolf == other.wolf && goat == other.goat
      && cabbage == other.cabbage;
  }

  // Hashing: consider only the positions of the four players.
  @Override
  public int hashCode() {
    return Objects.hash(man, wolf, goat, cabbage);
  }
}
