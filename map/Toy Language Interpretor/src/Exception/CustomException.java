package Exception;

public class CustomException extends RuntimeException {
    String exception;

    public CustomException(String exception){
        super();
        this.exception = exception;
    }

    @Override
    public String getMessage(){
        return this.exception;
    }
}
