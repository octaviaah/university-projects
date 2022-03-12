package Model.adt;

import java.util.List;

public interface IStack<T> {
    void push(T v);
    T pop();
    boolean isEmpty();
    String toString();
    List<T> getContent();
}
