class PopUpSection extends View {

  String[] rationaleString;

  Button rationaleButton, actionsButton, commentsButton;
  PopUpSection(float x_, float y_, String rationaleString)
  {
    super(x_, y_, 400, wrapText(rationaleString,35).length*20+20); 
 
 //System.out.println();
 
    rationaleButton = new Button(0, 0, 127, 20, true, "Rationale");
    this.subviews.add(rationaleButton);

    actionsButton = new Button(125, 0, 127.3, 20, true, "Actions");
    this.subviews.add(actionsButton);

    commentsButton = new Button(250.3, 0, 127.3, 20, false, "Comments");
    this.subviews.add(commentsButton);

    //this.rationaleString = rationaleString;
    
    this.rationaleString = wrapText(rationaleString,35);

   // this.h = this.rationaleString.length;
    // int h_ = (stringTokens.length)*20;
    //  super(0,0,0,0);
  }
  void drawContent()
  {
         fill(0);
      rect(0,0,w,h);
 
    System.out.println("Printing these");
  //  noStroke();
    stroke(0);
    strokeWeight(1);
    fill(popUpSectionColor);
    rect(0,0,w,h);
    fill(0);
    textFont(font);
    textSize(10);
    String r = "";
    for(int i = 0; i< rationaleString.length;i++){
    r+=rationaleString[i]+"\n";
    }
textAlign(LEFT,TOP);
    text(r,5,25);
textAlign(LEFT,CENTER);
    textFont(fbold);
    textSize(12);
    
    //rect(0, 0, 0, 0);
  }
}

