import java.awt.AWTException;
import java.awt.Robot;
import java.awt.event.KeyEvent;
import java.awt.event.InputEvent;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

enum State{
    UP, WAITING, DOWN;
}

enum Mode{
    CLICK, HOLD;
}

int delay = 3000;
Robot robot;
ScheduledExecutorService scheduler;
State state = State.UP;
Mode mode = Mode.HOLD;

void setup(){
    size(400,400);
    try{
        robot = new Robot();
    }
    catch(AWTException e){
        e.printStackTrace();
    }
    scheduler = Executors.newScheduledThreadPool(1);
}
void draw(){
    switch(state){
        case UP:
            background(255, 0, 0);
            break;
        case WAITING:
            background(255, 255, 0);
            break;
        case DOWN:
            background(0, 255, 0);
            break;
    }
    fill(40,40,40);
    rect(4, 4, 392, 392, 8);
    fill(255,255,255);
    textAlign(LEFT);
    textSize(20);
    text("'m' - toggle mode", 20, 30);
    text("'o' - left click", 20, 50);
    text("'p' - right click", 20,70);
    text("'up' - increment delay", 20, 90);
    text("'down' - decrement delay", 20, 110);
    textAlign(CENTER);
    textSize(36);
    text("delay: " + (double)delay/1000 +"s", 200, 200+100);
    switch(mode){
        case CLICK:
            text("mode: click", 200, 200+140);
            break;
        case HOLD:
            text("mode: hold", 200, 200+140);
            break;
    }
}
void keyPressed(){
    if(key=='p'){
        state = State.WAITING;
        scheduler.schedule(new Runnable() { public void run() {
            robot.mousePress(InputEvent.BUTTON3_DOWN_MASK);
            state=State.DOWN;
            if(mode != Mode.CLICK){
                return;
            }
            try{
                Thread.sleep(20);
            } catch(InterruptedException e){
                e.printStackTrace();
            }
            robot.mouseRelease(InputEvent.BUTTON3_DOWN_MASK);

        }}, (long)(delay), TimeUnit.MILLISECONDS);
        return;
    }
    if(key=='o'){
        state = State.WAITING;
        scheduler.schedule(new Runnable() { public void run() {
            robot.mousePress(InputEvent.BUTTON1_DOWN_MASK);
            state=State.DOWN;
            if(mode != Mode.CLICK){
                return;
            }
            try{
                Thread.sleep(20);
            } catch(InterruptedException e){
                e.printStackTrace();
            }
            robot.mouseRelease(InputEvent.BUTTON1_DOWN_MASK);
        }}, (long)(delay), TimeUnit.MILLISECONDS);
        return;
    }
    if(keyCode==UP){
        delay+=100;
        return;
    }
    if(keyCode==DOWN){
        if(delay>100){
            delay-=100;
        }
        return;
    }
    if(key=='m'){
        state = State.UP;
        switch (mode){
            case CLICK:
                mode = Mode.HOLD;
                break;
            case HOLD:
                mode = Mode.CLICK;
                break;
        }
    }
}
