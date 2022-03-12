package Model.adt;

import java.util.HashMap;
import java.util.Map;

public class MyHeap<T> implements IHeap<T>{
    private int memory;
    private Map<Integer, T> values;

    //public MyHeap() {
        //values = new HashMap<>();
    //}

    public MyHeap(Map<Integer, T> values){
        this.values = values;
    }

    @Override
    public int allocate(T value){
        this.memory++;
        this.values.put(this.memory, value);
        return this.memory;
    }

    @Override
    public T getAddress(int address){
        return this.values.get(address);
    }

    @Override
    public void addAddress(int address, T value){
        this.values.put(address, value);
    }

    @Override
    public T deallocate(int address){
        return this.values.remove(address);
    }

    @Override
    public Map<Integer, T> getContent(){
        return this.values;
    }

    @Override
    public void setContent(Map<Integer, T> map){
        this.values = map;
    }

    @Override
    public String toString(){
        String str = "";
        boolean ok = true;

        for (HashMap.Entry<Integer, T> entry: this.values.entrySet()){
            if (ok == false)
                str += "\n";
            str += entry.getKey().toString() + " -> " + entry.getValue().toString();
            ok = false;
        }

        return str;
    }
}
