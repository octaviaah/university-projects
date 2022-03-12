package Model.adt;

import java.util.Map;

public interface IHeap<T> {
    int allocate(T value);
    T getAddress(int address);
    void addAddress(int address, T value);
    T deallocate(int address);
    void setContent(Map<Integer, T> map);
    Map<Integer, T> getContent();
}
