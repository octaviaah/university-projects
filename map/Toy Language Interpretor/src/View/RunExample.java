package View;

import Controller.Controller;

public class RunExample extends Command{
    public Controller ctrl;
    public RunExample(String key, String description, Controller ctrl){
        super(key, description);
        this.ctrl = ctrl;
    }

    @Override
    public void execute(){
        try{
            ctrl.allStep();
        }catch(Exception e){
            System.out.println(e.toString());
        }
    }
}
