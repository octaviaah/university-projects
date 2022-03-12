package Model.adt;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import Exception.DictException;

public class MyDict<K, V> implements IDict<K, V> {
    Map<K, V> dictionary;

    public MyDict() {
        dictionary = new HashMap<>();
    }

    @Override
    public void add(K key, V value) {
        dictionary.put(key, value);
    }

    @Override
    public void remove(K key) {
        dictionary.remove(key);
    }

    @Override
    public V lookup(K key){
        if (dictionary.get(key) == null){
            throw new DictException("There is no such key");
        }
        return dictionary.get(key);
    }

    @Override
    public boolean isKey(K key){
        return dictionary.containsKey(key);
    }

    @Override
    public Collection<K> keys(){
        return this.dictionary.keySet();
    }

    @Override
    public Collection<V> values(){
        return this.dictionary.values();
    }

    @Override
    public void update(K key, V value){

        if (this.isKey(key)){
            dictionary.put(key, value);
        }
        else throw new DictException("Key doesn't exist");
    }

    @Override
    public Map<K, V> getDict(){
        return this.dictionary;
    }

    @Override
    public IDict<K, V> copy(){
        IDict<K, V> copyDict = new MyDict<>();
        for(K key: dictionary.keySet()){
            copyDict.add(key, dictionary.get(key));
        }
        return copyDict;
    }

    public String toString(){
        String s = "";
        for(K key : dictionary.keySet()){
            s += key.toString() + " -> " + dictionary.get(key).toString() + "\n";}
        return s;
    }


}
