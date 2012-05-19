class TextBox extends View
{
  ////////////////////////////////////////////////////////////////////////////////////////////////////
  public String text;
  public boolean  activated = false;
  // public Timer ticktock; // Timer used for blinking cursor
  public boolean timer = true;
  public int lastsec = 0;
  public int cursorPos = 0;
  ///////////////////////////////////////////////////////////////////////////////////////////////////
  public TextBox(float x_, float y_)
  {
    super(x_, y_, 320, 20);
    text = "";
    // tickTock = new Timer();
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////
  void drawContent()
  {
    fill(255);
    if (activated)
      stroke(0);
    else

        stroke(#A3A3A3);
    strokeWeight(1.5);
    rect(0, 0, w, h);

    fill(0);
    textFont(font, 12);
    textAlign(LEFT, CENTER);

    if (text.equals("") && !activated)
    {
      fill(#A3A3A3);
      text("Optional comment", 15, 7);
    }
    else {
      /*  if (activated)
       fill(0);
       else
       fill(#A3A3A3);
       */
      if (timer){
      String pre = text.substring(0,cursorPos);
      pre+="|";
      pre += text.substring(cursorPos);
        text(pre, 15, 7);
      
    }
      else
        text(text, 15, 7);
    }
    textFont(fbold);
    //textAlign(CENTER,CENTER);
    System.out.println(second());

    if (second()%1 <= 0.5 && second()!=lastsec) {
      timer = !timer;
      System.out.println("Toggling "+ timer);
      lastsec = second();
    }
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////
  public boolean keypressed() 
  {
    //System.out.println("Key = "+(int)key);
    if (activated) {
      if (key == 8)
      {
        if (text.length() > 0) text = text.substring(0, text.length() - 1);
      }
      else
      {
        if (key == CODED) {
          if (keyCode == RIGHT) {
            if(cursorPos < text.length())
            cursorPos++;
            
          }
          if(keyCode == LEFT){
            if(cursorPos > 0)
            cursorPos--;
          
          }
        }
        else {
          if (key != 65535) {
            if (cursorPos == text.length()) {
              text += key;
              cursorPos++;
            }
            else
            {
              String s2 = "";
              s2 += text.substring(0, cursorPos);
              s2+=key;
              s2+= text.substring(cursorPos);
              text = s2;
            }
          }
        }
      }
    }

    //   System.out.println("Text in there: "+ text);
    return activated;
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////
  // Private stuff.
  PImage icon;
  String label;
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  boolean contentPressed(float lx, float ly)
  {

    activated = !activated;
    filterKeyInput = activated;
    // System.out.println("Activated = "+ activated);
    return true;
  }
  /* void mouseClicked()
   { 
   
   if (!ptInRect(px, py, x,y, w, h)) { 
   
   activated = false;
   System.out.println("Activated = "+ activated);
   
   return;
   }
   float lx = px - x;
   float ly = py - y;
   // check our subviews first
   for (int i = subviews.size()-1; i >= 0; i--) {
   View v = (View)subviews.get(i);
   if (v.mousePressed(lx, ly)) return true;
   }
   contentPressed(lx,ly);
   }
   */
   boolean mouseClicked(float px, float py)
  {
    System.out.println(" Px = "+px +" Py = "+py+" x = "+x+" y = "+y+" w = "+w+" h = "+h);
    if (!ptInRect(px, py, x, y, w, h)){ 
    System.out.println("FALSEYYYYYYYYYYYYYY");
    return false;
  }
    float lx = px - x;
    float ly = py - y;
    // check our subviews first
    for (int i = subviews.size()-1; i >= 0; i--) {
      View v = (View)subviews.get(i);
      if (v.mouseClicked(lx, ly)) return true;
    }
    return contentClicked(lx, ly);
  }
}

