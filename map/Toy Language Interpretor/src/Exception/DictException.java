package Exception;

public class DictException extends RuntimeException{

    String exception;

    public DictException(String exception){
        super();
        this.exception = exception;
    }

    public String toString(){
        return this.exception;
    }
}
