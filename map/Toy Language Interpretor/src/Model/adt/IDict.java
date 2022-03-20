package Model.adt;

import java.util.Collection;
import java.util.Map;

public interface IDict<K, V>{
    void add(K key, V value);
    void remove(K key);
    V lookup(K key);
    boolean isKey(K key);
    void update(K key, V value);
    Collection<K> keys();
    Collection<V> values();
    Map<K, V> getDict();
    String toString();
    public IDict<K, V> copy();
}
