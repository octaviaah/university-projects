package Model.adt;
import java.util.List;
import java.util.Stack;
import Exception.StackException;

public class MyStack<T> implements IStack<T> {
    Stack<T> stack;

    public MyStack(){
        stack = new Stack<>();
    }

    @Override
    public void push(T v){
        stack.push(v);
    }

    @Override
    public T pop(){
        if (this.stack.isEmpty()){
            throw new StackException("Stack is empty");
        }
        return stack.pop();
    }

    @Override
    public boolean isEmpty() {
        return stack.isEmpty();
    }

    public String toString(){
        StringBuilder result = new StringBuilder();
        for(T v : this.stack){
            result.append(v.toString()).append(" ");
        }
        return result.toString();
    }

    @Override
    public List getContent(){
        return this.stack.subList(0, stack.size());
    }
}
