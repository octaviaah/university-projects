package Model.adt;

import java.util.List;

public interface IList<T> {
    void add(T v);
    boolean remove(T v);
    T lookup(int index);
    String toString();
    List getContent();
}
