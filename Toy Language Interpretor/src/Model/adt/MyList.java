package Model.adt;

import java.util.ArrayList;
import java.util.List;

public class MyList<T> implements IList<T> {
    ArrayList<T> list;

    public MyList(){
        this.list = new ArrayList<T>();
    }

    @Override
    public void add(T v){
        this.list.add(v);
    }

    @Override
    public boolean remove(T v){
        return this.list.remove(v);
    }

    @Override
    public T lookup(int index){
        return this.list.get(index);
    }

    public String toString(){
        StringBuilder result = new StringBuilder();
        for(T v : this.list)
            result.append(v.toString()).append(" ");
        result.append("\n");
        return result.toString();
    }

    @Override
    public List getContent(){
        return this.list;
    }
}
