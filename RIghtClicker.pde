import java.awt.AWTException;
import java.awt.Robot;
import java.awt.event.KeyEvent;
import java.awt.event.InputEvent;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;

boolean toggle = false, clicked=false;
int frameCounte=0;
char tecla;
Robot ronot;
int action = 0;
Boolean released=false;
void setup(){
  
  size(400,400);
  try{
  ronot = new Robot();
  }
  catch(AWTException e){
  }
  
}
void draw(){
  
  if(toggle)
    background(0,255,0);
   else
    background(255,0,0);
    
    
    if(toggle&&action!=0)
    
      if(action==10&&!clicked){
          if(tecla=='p'){
          ronot.mousePress(InputEvent.BUTTON3_DOWN_MASK);}
          else if(tecla=='o'){
          ronot.mousePress(InputEvent.BUTTON1_DOWN_MASK);
          }
        clicked=true;  
        
    }else{
      
      if(!toggle){
        if(tecla=='p'&&!released){
          ronot.mouseRelease(InputEvent.BUTTON3_DOWN_MASK);
        }
          else if(tecla=='o'){
          ronot.mouseRelease(InputEvent.BUTTON1_DOWN_MASK);}
          
       released=true;
      }
    
    }
    
    
    action--;
    
    if(action<=0)
      action=0;
}
void keyPressed(){
  if(key=='p'||key=='o'){
      tecla = key;  
      toggle=!toggle;
    }
    
    if(toggle){
      action=150;
      clicked=false;}
      else{
        released=false;
      }
}
