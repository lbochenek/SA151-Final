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
PImage temp;
PImage[] stickers = new PImage[3]; //possible stickers
int sInd = 0;

//size of camera
int sx = 1280;
int sy = 720;

int bw = 160; //width of bar on right
int takePicButD = 100; //diameter of take picture circle
int takePicButX = sx+(bw/2);
int takePicButY = sy/2;
int clickCt = 0;
boolean takePicture = false;
boolean takePicOver = false;

int filtX = 1295;
int filtW = 130;
float filtL = 73.125;
int filtC = 7;
boolean overBokeh = false;
float bokY = 15;
boolean overVintage = false;
float vintY = 103.125;
boolean overBlackAndWhite = false;
float bawY = 191.25;
boolean overMirror = false;
float mirrorY = 279.375;
boolean overStickers = false;
boolean stickersClicked = false;
boolean stickersGone = true;
float stckY = 367.5;
boolean overBlemish = false;
float blemY = 455.625;
boolean overTeethWhitener = false;
float teethY = 543.75;
boolean overEvenComplex = false;
float even = 631.875;

public void setup()
{ 
//  println(Capture.list());
  size(sx+bw, sy);
  background(0);
  stickers[0] = loadImage("heart.png");
  stickers[1] = loadImage("star.png");
  stickers[2] = loadImage("sparkles.png");
  cam = new Capture(this, sx, sy, 30);
  cam.start(); 
}

void captureEvent(Capture cam)
{
  cam.read();
}  

void draw() 
{ 
 
  update(); //checks where mouse is, updates booleans accordingly
    
  if(takePicture==false)
  {
    image(cam, 0,0);
    fill(200);
    stroke(200);
    ellipse(takePicButX, takePicButY, takePicButD, takePicButD);
  
    if(takePicOver){
      stroke(0, 116, 255);
      ellipse(takePicButX, takePicButY, takePicButD-15, takePicButD-15);
    } else {
      stroke(0);
      ellipse(takePicButX, takePicButY, takePicButD-15, takePicButD-15);
    }
    
 } else {
   cam.stop();
   
   image(img, 0,0);
   if(stickersClicked)
   {
     if(mouseX<=1280)
     {
       if(sInd>=stickers.length)
         sInd = 0;
       stickersGone = false;
       image(stickers[sInd], mouseX-250, mouseY-250);
     }
   }       
   
   fill(0);
   stroke(0);
   rect(sx, 0, bw, sy);
  
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
   if(overBokeh)
   {
     fill(0, 116, 255);
     text("BOKEH", filtX+5, bokY+25);
   } else {
     fill(0);
     text("BOKEH", filtX+5, bokY+25);
   }
   
   if(overVintage)
   {
     fill(0, 116, 255);
     text("VINTAGE", filtX+5, vintY+25);
   } else {
     fill(0);
     text("VINTAGE", filtX+5, vintY+25);
   }
   
   if(overBlackAndWhite)
   {
     fill(0, 116, 255);
     text("BLACK AND WHITE", filtX+5, bawY+25);
   } else {
     fill(0);
     text("BLACK AND WHITE", filtX+5, bawY+25);
   }
   
   if(overMirror)
   {
     fill(0, 116, 255);
     text("MIRROR", filtX+5, mirrorY+25);
   } else {
     fill(0);
     text("MIRROR", filtX+5, mirrorY+25);
   }
   
   if(overStickers)
   {
     fill(0, 116, 255);
     text("STICKERS", filtX+5, stckY+25);
   } else {
     fill(0);
     text("STICKERS", filtX+5, stckY+25);
   }
   
   if(overBlemish)
   {
     fill(0, 116, 255);
     text("BLEMISH REMOVER", filtX+5, blemY+25);
   } else {
     fill(0);
     text("BLEMISH REMOVER", filtX+5, blemY+25);
   }
   
   if(overTeethWhitener)
   {
     fill(0, 116, 255);
     text("TEETH WHITENER", filtX+5, teethY+25);
   } else {
     fill(0);
     text("TEETH WHITENER", filtX+5, teethY+25);
   }
   
   if(overEvenComplex)
   {
     fill(0, 116, 255);
     text("EVEN COMPLEXION", filtX+5, even+25);
   } else {
     fill(0);
     text("EVEN COMPLEXION", filtX+5, even+25);
   }
   
 }
  
}  

void mouseClicked()
{
  clickCt++;
  if(takePicOver)
  {
    takePicture = true;
    save("captured");
    save("capturedimg");
    img = loadImage("capturedimg.tif");
  }
 
  if(overBokeh)
  {
    filter(BLUR, 10);
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
    noTint();
    save("mirror");
    img = loadImage("mirror.tif");
  }
  
  if(overStickers)
  {
    stickersClicked = true;
    save("stickers");
    img = loadImage("stickers.tif");
  }
  else
  {
    if(overBokeh||overVintage||overBlackAndWhite||overMirror||overBlemish||overTeethWhitener||overEvenComplex)
      stickersClicked = false;
  }
  
  if(stickersClicked)
  {
    whichSticker();
    save("stickers");
    img = loadImage("stickers.tif");
  }
  
  if(overBlemish)
  {
    copy(50,50,100,100,400,100,600,600);
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

//  if(clickCt == 5)
//  {
//    temp = loadImage("captured.tif");
//    image(temp, 0, 0);
//    blend(img, 0, 0, sx, sy, 0, 0, sx, sy, DIFFERENCE);
//  }   
  
  println(clickCt);
}
void whichSticker()
{
//  int rand = (int) random(3);
//  sInd = rand;
  int temp = sInd;
  if(sInd<stickers.length)
    sInd++;
  else
    sInd = 0;  
}

void switchPixels()
{
  loadPixels();
  println(pixels.length);
  for(int i=0; i<pixels.length-1000; i+=2)
  {
//    int rand1 = (int) random(0,i+random(0,998));
    int rand1 = (int) random(0, i%random(0,998));
    float r1 = red(pixels[i]);
    float g1 = green(pixels[i]);
    float b1 = blue(pixels[i]);
    float r2 = red(pixels[rand1]);
    float g2 = green(pixels[rand1]);
    float b2 = blue(pixels[rand1]);
    pixels[i] = color(r2, g2, b2);
    pixels[rand1] = color(r1, g1, b1);
  } 
  updatePixels(); 
  noLoop();
}

void evenComplex()
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

void gradual()
{
  loadPixels();
  for(int i=0; i<pixels.length; i++)
  {
    float b = brightness(pixels[i]);
    float s = saturation(pixels[i]);
    float h = hue(pixels[i]);
      
    pixels[i] = color(h, s, b);
  }
  updatePixels(); 
}

void mirror()
{
  int div = (int) sx/8;
  int split = (int) div/2;
  loadPixels();
  for(int i=0; i<split; i++) //loop through column
  {
    for(int j=0; j<height; j++) //loop through row
    {
      for(int k=0; k<sx; k+=div)
      {
        int loc = k+j*width+i;
        int end = loc+div-1-i;
        float r = red(pixels[loc]);
        float g = green(pixels[loc]);
        float b = blue(pixels[loc]);
        pixels[end - i] = color(r,g,b);
      }
    }
  }
  
//  for(int i=0; i<sx/2; i++) //loop through column
//  {
//    for(int j=0; j<height; j++) //loop through row
//    {
//      int loc = i+j*width;
//      int end = sx-1;
//      float r = red(pixels[loc]);
//      float g = green(pixels[loc]);
//      float b = blue(pixels[loc]);
//      int locEnd = end+j*width;
//      pixels[locEnd-i] = color(r, g, b);
//    }
//
//  }
  updatePixels();
}

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


