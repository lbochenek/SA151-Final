/*
* http://funprogramming.org/121-Using-a-webcam-in-Processing.html
* http://forum.processing.org/one/topic/simple-still-image-capture-and-load.html
* https://processing.org/examples/button.html
* https://processing.org/tutorials/pixels/
*/

import processing.core.*;
import processing.video.*;

Capture cam;
PImage img; //image being displayed
PImage[] stickers = new PImage[3]; //possible stickers
int sInd = 0; //keeps track of which sticker to place

//size of camera
int sx = 1280;
int sy = 720;
int frames = 30;

int bw = 160; //width of bar on right
int takePicButD = 100; //diameter of take picture circle
int takePicButX = sx+(bw/2); //x of the take picture circle
int takePicButY = sy/2; //y of the take picture circle
boolean takePicture = false; //has the picture been taken yet?
boolean takePicOver = false; //is the cursor over the take picture button?

int filtX = 1295; //x coordinate of filter buttons
int filtW = 130; //width of filter buttons
float filtL = 73.125; //length of filter buttons
int filtC = 7; //curve of filter buttons
boolean overBokeh = false; //is cursor over the Bokeh filter?
float bokY = 15; //y coordinate of Bokeh filter
boolean overVintage = false;
float vintY = 103.125;
boolean overBlackAndWhite = false;
float bawY = 191.25;
boolean overMirror = false;
boolean mirrored = false; //turns true after the mirror effect is used
boolean mirrorFixed = false;
float mirrorY = 279.375;
float mirrorSize = 1; //size of mirror
boolean overStickers = false;
boolean stickersClicked = false; //has stickers been clicked w/o any other buttons being clicked?
float stckY = 367.5;
boolean overBlemish = false;
float blemY = 455.625;
boolean overTeethWhitener = false;
float teethY = 543.75;
boolean overEvenComplex = false;
float even = 631.875;

public void setup()
{ 
  // println(Capture.list());
  size(sx+bw, sy);
  background(0);
  stickers[0] = loadImage("heart.png");
  stickers[1] = loadImage("star.png");
  stickers[2] = loadImage("sparkles.png");
  cam = new Capture(this, sx, sy, frames);
  cam.start(); 
}

void captureEvent(Capture cam)
{
  cam.read();
}  

void draw() 
{ 
 
  update(); //checks where mouse is, updates booleans accordingly
    
  if(takePicture==false) //if the picture hasn't been taken yet, show only take pic button
  {
    image(cam, 0,0);
    
    //black box behind menu  
    fill(0);
    stroke(0);
    rect(sx, 0, bw, sy);  
    
    //take pic button
    fill(200);
    stroke(200);
    ellipse(takePicButX, takePicButY, takePicButD, takePicButD); 
  
    //if cursor is over button, change circle color
    if(takePicOver){
      stroke(0, 116, 255);
      ellipse(takePicButX, takePicButY, takePicButD-15, takePicButD-15);
    } else {
      stroke(0);
      ellipse(takePicButX, takePicButY, takePicButD-15, takePicButD-15);
    }
    
 } else { //picture has been taken
   cam.stop();
   
   image(img, 0,0); //display picture on screen
   
   if(stickersClicked) //if user has clicked stickers
   {
     if(mouseX<=1280) //and if the mouse is not in the menu
     {
       if(sInd>=stickers.length)
         sInd = 0;
       image(stickers[sInd], mouseX-250, mouseY-250); //have sticker follow mouse
     }
   }       
   
   //black box behind menu  
   fill(0);
   stroke(0);
   rect(sx, 0, bw, sy);  
   
   //filter buttons
   fill(200);
   stroke(200);
  
   rect(filtX, bokY, filtW, filtL, filtC);
   rect(filtX, vintY, filtW, filtL, filtC);
   rect(filtX, bawY, filtW, filtL, filtC);
   rect(filtX, mirrorY, filtW, filtL, filtC);
   rect(filtX, stckY, filtW, filtL, filtC);
   rect(filtX, blemY, filtW, filtL, filtC);
   rect(filtX, teethY, filtW, filtL, filtC);
   rect(filtX, even, filtW, filtL, filtC);
  
   fill(0);
   textSize(16);

   if(overBokeh)
   {
     fill(0, 116, 255);
     text("BOKEH", filtX+37, bokY+43);
   } else {
     fill(0);
     text("BOKEH", filtX+37, bokY+43);
   }
   
   if(overVintage)
   {
     fill(0, 116, 255);
     text("VINTAGE", filtX+30, vintY+43);
   } else {
     fill(0);
     text("VINTAGE", filtX+30, vintY+43);
   }
   
   if(overBlackAndWhite)
   {
     fill(0, 116, 255);
     text("BLACK", filtX+40, bawY+33);
     text("AND WHITE", filtX+20, bawY+53);

   } else {
     fill(0);
     text("BLACK", filtX+40, bawY+33);
     text("AND WHITE", filtX+20, bawY+53);
   }
   
   if(overMirror)
   {
     fill(0, 116, 255);
     text("MIRROR", filtX+34, mirrorY+43);
   } else {
     fill(0);
     text("MIRROR", filtX+34, mirrorY+43);
   }
   
   if(overStickers)
   {
     fill(0, 116, 255);
     text("STICKERS", filtX+30, stckY+43);
   } else {
     fill(0);
     text("STICKERS", filtX+30, stckY+43);
   }
   
   if(overBlemish)
   {
     fill(0, 116, 255);
     text("BLEMISH", filtX+34, blemY+33);
     text("REMOVER", filtX+30, blemY+53);
   } else {
     fill(0);
     text("BLEMISH", filtX+34, blemY+33);
     text("REMOVER", filtX+30, blemY+53);
   }
   
   if(overTeethWhitener)
   {
     fill(0, 116, 255);
     text("TEETH", filtX+37, teethY+33);
     text("WHITENER", filtX+26, teethY+53);
   } else {
     fill(0);
     text("TEETH", filtX+37, teethY+33);
     text("WHITENER", filtX+26, teethY+53);
   }
   
   if(overEvenComplex)
   {
     fill(0, 116, 255);
     text("EVEN", filtX+45, even+33);
     text("COMPLEXION", filtX+13, even+53);
   } else {
     fill(0);
     text("EVEN", filtX+45, even+33);
     text("COMPLEXION", filtX+13, even+53);
   }   
 }  
}  

void mouseClicked()
{
  //if over the take picture button
  if(takePicOver)
  {
    takePicture = true;
    save("capturedimg"); //saves a tif of the screen
    img = loadImage("capturedimg.tif"); //changes the image being displayed
  }

  if(overBokeh)
  {
    filter(BLUR, 10);
    noTint(); //prevent the tint from multiplying
    if(mirrored && !mirrorFixed) //if the mirror effect has been used, reduce mirroring to fold change into mirror
    {  
      mirrorSize /= 2;
      mirrorFixed = true;
    }  
    save("blurred");
    img = loadImage("blurred.tif");
  } 
  
  if(overVintage)
  {
    tint(255, 230, 0);
    save("vintage");
    img = loadImage("vintage.tif");
  }
  
  if(overBlackAndWhite)
  {
    noTint();
    filter(THRESHOLD);
    save("bw");
    img = loadImage("bw.tif");
  }
  
  if(overMirror)
  {    
    mirror();
    mirrored = true;
    noTint();
    save("mirror");
    img = loadImage("mirror.tif");
  }
  
  if(overStickers)
  {
    stickersClicked = true;
    if(mirrored && !mirrorFixed) 
    {  
      mirrorSize /= 2;
      mirrorFixed = true;
    } 
    save("stickers");
    img = loadImage("stickers.tif");
  }
  else //if stickers is not the last thing clicked, set stickersClicked to false
  {
    if(overBokeh||overVintage||overBlackAndWhite||overMirror||overBlemish||overTeethWhitener||overEvenComplex)
      stickersClicked = false;
  }
  
  //if stickers are the most recent thing clicked, choose a sticker, then onclick, save the image
  if(stickersClicked)
  {
    whichSticker();
    noTint();
    save("stickers");
    img = loadImage("stickers.tif");
  }
  
  if(overBlemish)
  {
    copy(50,50,100,100,400,100,600,600);
    if(mirrored && !mirrorFixed) 
    {  
      mirrorSize /= 2;
      mirrorFixed = true;
    } 
    save("blemish");
    img = loadImage("blemish.tif");
  }
  
  if(overTeethWhitener)
  {
    fill(255, 150);
    rect(0,0, sx, sy);
    save("teeth");
    img = loadImage("teeth.tif");
  }
  
  if(overEvenComplex)
  {
    evenComplex();
    save("complex");
    img = loadImage("complex.tif");
  }

}
void whichSticker() //chooses which sticker to place on cursor
{
//  int rand = (int) random(3);
//  sInd = rand;
  int temp = sInd;
  if(sInd<stickers.length)
    sInd++;
  else //restart cycle
    sInd = 0;  
}

void evenComplex() //scatters pixels around
{
  loadPixels();
  for(int i=0; i<pixels.length; i+=random(0,5))
  {
    int rand = (int) random(0,1000);
    float r = red(pixels[rand]);
    float g = green(pixels[rand]);
    float b = blue(pixels[rand]);
    
    pixels[i] = color(r, g, b);
  }
  updatePixels();
}

void mirror()
{
  mirrorFixed = false; //reset boolean
  int mSize = (int) Math.ceil(mirrorSize);
  println("mirrorSize!" + mirrorSize);
  println("mSize!" + mSize);
  int div = (int) sx/mSize; //how big each section is
  int split = (int) div/2; //how big each original part is
  loadPixels();
  for(int i=0; i<split; i++) //loop through column
  {
    for(int j=0; j<height; j++) //loop through row
    {
      for(int k=0; k<sx; k+=div) //loop through divisions
      {
        int loc = k+j*width+i; //array location of left part of mirror
        int end = loc+div-1-i; //array location of end of mirror section
        float r = red(pixels[loc]);
        float g = green(pixels[loc]);
        float b = blue(pixels[loc]);
        pixels[end - i] = color(r,g,b); //set reflection to left part of mirror
      }
    }
  }
  updatePixels();
  
  if(mirrorSize >= 512) //down to the pixel level; reset mirror size
    mirrorSize = 1;
  else
    mirrorSize*=2; //reduce size of mirror, creating more sections
}

//detects if mouse is over the take picture button
boolean overTakePic(int x, int y, int diameter)
{
  float disX = x - mouseX;
  float disY = y - mouseY;
  if(sqrt(sq(disX)+sq(disY)) < diameter/2){
    return true;
  } else {
    return false;
  }
}  

boolean bokehOver()
{
  if(mouseX >= filtX && mouseX <= filtX+filtW && mouseY >= bokY && mouseY <= bokY+filtL)
    return true;
  else
    return false;
}

boolean vintageOver()
{
  if(mouseX >= filtX && mouseX <= filtX+filtW && mouseY >= vintY && mouseY <= vintY+filtL)
    return true;
  else
    return false;
}

boolean blackWhiteOver()
{
  if(mouseX >= filtX && mouseX <= filtX+filtW && mouseY >= bawY && mouseY <= bawY+filtL)
    return true;
  else
    return false;
}

boolean mirrorOver()
{
  if(mouseX >= filtX && mouseX <= filtX+filtW && mouseY >= mirrorY && mouseY <= mirrorY+filtL)
    return true;
  else
    return false;
}

boolean stickersOver()
{
  if(mouseX >= filtX && mouseX <= filtX+filtW && mouseY >= stckY && mouseY <= stckY+filtL)
    return true;
  else
    return false;
}

boolean blemishOver()
{
  if(mouseX >= filtX && mouseX <= filtX+filtW && mouseY >= blemY && mouseY <= blemY+filtL)
    return true;
  else
    return false;
}

boolean teethOver()
{
  if(mouseX >= filtX && mouseX <= filtX+filtW && mouseY >= teethY && mouseY <= teethY+filtL)
    return true;
  else
    return false;
}

boolean evenCompOver()
{
  if(mouseX >= filtX && mouseX <= filtX+filtW && mouseY >= even && mouseY <= even+filtL)
    return true;
  else
    return false;
}

void keyPressed()
{
  if(key == DELETE || key == BACKSPACE)
  { 
    println("reset!");
    startOver();
  }  
}  

//resets all initial conditions to take another photo - need to press backspace
void startOver()
{
  sInd = 0;
  takePicture = false;
  takePicOver = false;
  overBokeh = false;
  overVintage = false;
  overBlackAndWhite = false;
  overMirror = false;
  mirrored = false;
  mirrorFixed = false;
  mirrorSize = 1;
  overStickers = false;
  stickersClicked = false;
  overBlemish = false;
  overTeethWhitener = false;
  overEvenComplex = false;
  
  noTint();
  
  cam.start();
}  

//detects which booleans are true, and which are not, based off of mouse position
void update()
{
  if(overTakePic(takePicButX, takePicButY, takePicButD) && !takePicture)
    takePicOver = true;
  else
    takePicOver = false;
    
  if(bokehOver() && takePicture)
    overBokeh = true;
  else
    overBokeh = false;
    
  if(vintageOver() && takePicture)
    overVintage = true;
  else
    overVintage = false;
    
  if(blackWhiteOver() && takePicture)
    overBlackAndWhite = true;
  else
    overBlackAndWhite = false;
    
  if(mirrorOver() && takePicture)
    overMirror = true;
  else
    overMirror = false;
  
  if(stickersOver() && takePicture)
    overStickers = true;
  else
    overStickers = false;
    
  if(blemishOver() && takePicture)
    overBlemish = true;
  else
    overBlemish = false;
    
  if(teethOver() && takePicture)
    overTeethWhitener = true;
  else
    overTeethWhitener = false;
    
  if(evenCompOver() && takePicture)
    overEvenComplex = true;
  else
    overEvenComplex = false;
}


