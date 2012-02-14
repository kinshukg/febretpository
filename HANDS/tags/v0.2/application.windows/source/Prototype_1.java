import processing.core.*; 
import processing.xml.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class Prototype_1 extends PApplet {

// ############################################################################################################################################################################################
// EVL - Hands On Project Prototype # 1
// Draft # 1 
// ############################################################################################################################################################################################

// Variables used got holding the different views
public View mainView;     // The Main View is the background of the window with all of the other widgets on top of it.
public TitleView titleView;
public PatientDataView nameView,dobView,genderView,allergiesView,codeStatusView,pocView,shftView,roomView,medicalDXView,mrView,physicianView,otherView;
public ColouredRowView impairedGasExchange, deathAnxietyView,acutePainView;
public SecondLevelRowView anxietyLevelView,anxietySelfControlView, painLevelView; 
public ThirdLevelRowView  musicTherapyView, calmingTechniqueView, calmingTechniqueView_2,spiritualSupportView,medicationManagementView,painManagementView;
public ScrollingView scrollingView;
public ClosePopUpView closePopUpView;
public PopUpView popUpView;


// Variables used for Font Control
public PFont font,fbold; 


// Variables used for colours
public int backgroundColor = 255;
public int titleBackgroundColor = 0xff6495ED;
public int titleColor = 0xffFF8C00 ;
public int subtitleColor = 255;
public int colouredRowColor = 0xffC6E2FF;
public int secondLevelRowColor = 255;
public int thirdLevelRowColor = 255;
public int closePopUpColor = 0xff5E5E5E;
public int rationaleBarColor = 0xffD4D4D4;
public int rationaleColor = 0;
public int buttonSelectedColor = 200;
public int buttonNotColor = 0xff4682B4;
public int popUpSectionColor = 0xffFFF68F;

// Variables holding Image names
public String handIconString = "Red_Handprint__right_orange.png";
public String firstLevelIconString = "black-square.png";
public String secondLevelIconString = "black_circle.png";
public String thirdLevelIconString = "532px-TriangleArrow-Up.svg.png";

// Variables holding Images
public PImage handIcon,firstLevelIcon,secondLevelIcon,thirdLevelIcon;
public PImage firstLevelIconLegend, secondLevelIconLegend,thirdLevelIconLegend;

// Variables holding data of currently showing patient
public String name = "Ann Taylor";
public String dob = "03/12/1938",gender = "Female", allergies = "None" ,codeStatus = "DNR" ,poc = "09/17/2010", shft= "7:00a - 3:00p", room = "1240", medicalDX = "Malignant Neoplasm of the Pancreas" , mr = "xxx xxx xxx", physician = "Piper";
public String other = "Sister wants to be called ANYTIME at patient's request -- 776-894-1010-#################################";
public String rationale1 = "Data Mining Revealed that the combination of Medication Management, Positioning, and Pain Management has the most positive impact on pain level. ";
public String rationale2 = "Mrs Taylor's POC indicates that pain level is not controlled, a common finding for EOL patients who have Pain and Impaired Gas Exchange listed as problems on the POC.";
public String rationale3 = "Research has discovered that >50% of EOL patients do not achieve the expected NOC Pain Level goal by discharge or death.";
public void setup()
{
  size(1200, 700);
 
 //Adjust fonts here, if needed 
  font = loadFont("ArialMT-20.vlw");
  fbold = loadFont("Arial-BoldMT-20.vlw");
  textFont(font);
  
  //Images instantiated
  handIcon = loadImage(handIconString);
  handIcon.resize(0,25);
 
 firstLevelIcon = loadImage(firstLevelIconString);
 firstLevelIcon.resize(0,15);
 
 secondLevelIcon  = loadImage(secondLevelIconString);
 secondLevelIcon.resize(0,15);
 
 thirdLevelIcon = loadImage(thirdLevelIconString);
 thirdLevelIcon.resize(0,15);
 
 
 firstLevelIconLegend = loadImage(firstLevelIconString);
 firstLevelIconLegend.resize(0,25);
 
 secondLevelIconLegend  = loadImage(secondLevelIconString);
 secondLevelIconLegend.resize(0,25);
 
 thirdLevelIconLegend = loadImage(thirdLevelIconString);
 thirdLevelIconLegend.resize(0,25);
 // Views created
  mainView = new View(0, 0, width, height);
 
  titleView = new TitleView(0,0,width,handIcon,"HANDS","- Hands-On Automated Nursing Data System",titleBackgroundColor, titleColor,subtitleColor);
  mainView.subviews.add(titleView); 
  
  nameView = new PatientDataView(0, titleView.h+5, width/2,20, "Patient Name:",name);
  mainView.subviews.add(nameView);
  
  dobView = new PatientDataView(0, titleView.h+5+nameView.h, width/2,20, "DOB:",dob);
  mainView.subviews.add(dobView);
  
  genderView = new PatientDataView(0, titleView.h+5+nameView.h+dobView.h, width/2,20, "Gender:",gender);
  mainView.subviews.add(genderView);
  
  allergiesView = new PatientDataView(0, titleView.h+5+nameView.h+dobView.h+20+genderView.h, width/2,20, "Allergies:",allergies);
  mainView.subviews.add(allergiesView);
  
  codeStatusView = new PatientDataView(0, titleView.h+5+nameView.h+dobView.h+20+genderView.h+allergiesView.h, width/2,20, "Code Status:",codeStatus);
  mainView.subviews.add(codeStatusView);
  
  pocView = new PatientDataView(0,  titleView.h+5+nameView.h+dobView.h+20+genderView.h+allergiesView.h+codeStatusView.h, width/2,20, "POC Date:",poc);
  mainView.subviews.add(pocView);

 
  
  shftView = new PatientDataView(300, titleView.h+5, width/2,20, "Shift:",shft);
  mainView.subviews.add(shftView);
  
  roomView = new PatientDataView(300, titleView.h+5+nameView.h, width/2,20, "Room#:",room);
  mainView.subviews.add(roomView);
  
  medicalDXView = new PatientDataView(300, titleView.h+5+nameView.h+dobView.h, width/2,20, "Medical DX:",medicalDX);
  mainView.subviews.add(medicalDXView);
  
  mrView = new PatientDataView(300, titleView.h+5+nameView.h+dobView.h+20+genderView.h, width/2,20, "MR#:",mr);
  mainView.subviews.add(mrView);
  
  physicianView = new PatientDataView(300, titleView.h+5+nameView.h+dobView.h+20+genderView.h+allergiesView.h, width/2,20, "Physician:",physician);
  mainView.subviews.add(physicianView);
  
  
  String[] otherPieces = wrapText(other,60);
  String otherImproved = "";
  
//  System.out.println("Printing");
  for(int i = 0 ; i<otherPieces.length;i++){
  // System.out.println(otherPieces[i]);
   otherImproved += otherPieces[i]+"\n";
    
  }
  otherView = new PatientDataView(300,  titleView.h+5+nameView.h+dobView.h+20+genderView.h+allergiesView.h+codeStatusView.h, width/2,50, "Other:","\n\n"+otherImproved);
  mainView.subviews.add(otherView);
  
  scrollingView = new ScrollingView(0, 40+titleView.h+5+nameView.h+dobView.h+20+genderView.h+allergiesView.h+codeStatusView.h+otherView.h, width);
  mainView.subviews.add(scrollingView);
  
  impairedGasExchange = new ColouredRowView(0, titleView.h+15+nameView.h+dobView.h+20+genderView.h+allergiesView.h+codeStatusView.h+otherView.h+40,"Impaired Gas Exchange",firstLevelIcon);
  //mainView.subviews.add(impairedGasExchange);
  scrollingView.subs.add(impairedGasExchange);  
  
  anxietyLevelView = new SecondLevelRowView(0,  titleView.h+15+nameView.h+dobView.h+20+genderView.h+allergiesView.h+codeStatusView.h+otherView.h+40+ impairedGasExchange.h,"Anxiety Level",secondLevelIcon,2,3);
  //mainView.subviews.add(anxietyLevelView);
  impairedGasExchange.subs.add(anxietyLevelView);
  
  
  musicTherapyView = new ThirdLevelRowView(0,titleView.h+15+nameView.h+dobView.h+20+genderView.h+allergiesView.h+codeStatusView.h+otherView.h+40+ impairedGasExchange.h+anxietyLevelView.h,"Music Therapy", thirdLevelIcon);
  //mainView.subviews.add(musicTherapyView);
  anxietyLevelView.subs.add(musicTherapyView);
 // musicTherapyView.comments.add("Family Priest to Visit 2am");
 // musicTherapyView.comments.add("Family Priest to Visit 2am");
  
  calmingTechniqueView = new ThirdLevelRowView(0,titleView.h+15+nameView.h+dobView.h+20+genderView.h+allergiesView.h+codeStatusView.h+otherView.h+40+ impairedGasExchange.h+anxietyLevelView.h+musicTherapyView.h,"Calming Technique",thirdLevelIcon);
  //mainView.subviews.add(calmingTechniqueView);
  anxietyLevelView.subs.add(calmingTechniqueView);
  
  
  deathAnxietyView = new ColouredRowView(0, titleView.h+15+nameView.h+dobView.h+20+genderView.h+allergiesView.h+codeStatusView.h+otherView.h+40+impairedGasExchange.h+anxietyLevelView.h+calmingTechniqueView.h+musicTherapyView.h,"Death Anxiety",firstLevelIcon);
  //mainView.subviews.add(deathAnxietyView);
  scrollingView.subs.add(deathAnxietyView);
  
  anxietySelfControlView = new SecondLevelRowView(0,  titleView.h+15+nameView.h+dobView.h+20+genderView.h+allergiesView.h+codeStatusView.h+otherView.h+40+ impairedGasExchange.h+anxietyLevelView.h+deathAnxietyView.h+calmingTechniqueView.h+musicTherapyView.h,"Anxiety Self-Control",secondLevelIcon,5,5);
  //mainView.subviews.add(anxietySelfControlView);
  deathAnxietyView.subs.add(anxietySelfControlView);
  
  calmingTechniqueView_2 = new ThirdLevelRowView(0,titleView.h+15+nameView.h+dobView.h+20+genderView.h+allergiesView.h+codeStatusView.h+otherView.h+40+ impairedGasExchange.h+anxietyLevelView.h+deathAnxietyView.h+calmingTechniqueView.h+musicTherapyView.h+anxietySelfControlView.h,"Calming Technique",thirdLevelIcon);
  //mainView.subviews.add(calmingTechniqueView_2);
  anxietySelfControlView.subs.add(calmingTechniqueView_2);

  spiritualSupportView = new ThirdLevelRowView(0,calmingTechniqueView_2.h+titleView.h+15+nameView.h+dobView.h+20+genderView.h+allergiesView.h+codeStatusView.h+otherView.h+40+ impairedGasExchange.h+anxietyLevelView.h+deathAnxietyView.h+calmingTechniqueView.h+musicTherapyView.h+anxietySelfControlView.h,"Spiritual Support",thirdLevelIcon);
  //mainView.subviews.add(spiritualSupportView);
  anxietySelfControlView.subs.add(spiritualSupportView);

  
  
 //mainView.subviews.add(new CommentRowView(0,calmingTechniqueView_2.h+titleView.h+15+nameView.h+dobView.h+20+genderView.h+allergiesView.h+codeStatusView.h+otherView.h+40+ impairedGasExchange.h+anxietyLevelView.h+deathAnxietyView.h+calmingTechniqueView.h+musicTherapyView.h+anxietySelfControlView.h+spiritualSupportView.h,"Family Priest to visit 2am"));
  spiritualSupportView.comments.add("Family Priest to Visit 2am");
//  /spiritualSupportView.comments.add("Family Priest to Visit 2am");
  
  acutePainView = new ColouredRowView(0,  50+calmingTechniqueView_2.h+spiritualSupportView.h+titleView.h+15+nameView.h+dobView.h+20+genderView.h+allergiesView.h+calmingTechniqueView.h+musicTherapyView.h+codeStatusView.h+otherView.h+40+ impairedGasExchange.h+anxietyLevelView.h+deathAnxietyView.h + anxietySelfControlView.h,"Acute Pain",firstLevelIcon);
  //mainView.subviews.add(acutePainView);
  scrollingView.subs.add(acutePainView);
  
  painLevelView = new SecondLevelRowView(0, 50+calmingTechniqueView_2.h+spiritualSupportView.h+acutePainView.h+titleView.h+15+nameView.h+dobView.h+20+genderView.h+allergiesView.h+codeStatusView.h+calmingTechniqueView.h+musicTherapyView.h+otherView.h+40+ impairedGasExchange.h+anxietyLevelView.h+deathAnxietyView.h + anxietySelfControlView.h, "Pain Level",secondLevelIcon,1,5);
  //mainView.subviews.add(painLevelView);
  acutePainView.subs.add(painLevelView);
  
  medicationManagementView = new ThirdLevelRowView(0, 50+calmingTechniqueView_2.h+spiritualSupportView.h+acutePainView.h+titleView.h+15+nameView.h+dobView.h+20+genderView.h+allergiesView.h+codeStatusView.h+calmingTechniqueView.h+musicTherapyView.h+otherView.h+40+ impairedGasExchange.h+anxietyLevelView.h+deathAnxietyView.h + anxietySelfControlView.h+painLevelView.h,"Medical Management",thirdLevelIcon);
  //mainView.subviews.add(medicationManagementView);
  painLevelView.subs.add(medicationManagementView);
  
  painManagementView = new ThirdLevelRowView(0, 50+medicationManagementView.h+calmingTechniqueView_2.h+spiritualSupportView.h+acutePainView.h+titleView.h+15+nameView.h+dobView.h+20+genderView.h+allergiesView.h+codeStatusView.h+calmingTechniqueView.h+musicTherapyView.h+otherView.h+40+ impairedGasExchange.h+anxietyLevelView.h+deathAnxietyView.h + anxietySelfControlView.h+painLevelView.h,"Pain Management",thirdLevelIcon);
  //mainView.subviews.add(painManagementView);
  painLevelView.subs.add(painManagementView);
  
  popUpView = new PopUpView(750,scrollingView.y-10,400);
  
  
  PopUpSection p1 = new PopUpSection(0,0,rationale1);
  popUpView.subviews.add(p1);
  PopUpSection p2 = new PopUpSection(0,0,rationale2);
  popUpView.subviews.add(p2);
  PopUpSection p3 = new PopUpSection(0,0,rationale3);
  popUpView.subviews.add(p3);
  
  mainView.subviews.add(popUpView);

}

public void draw()
{
  
  background(backgroundColor); 
  System.out.println(popUpView.subviews.size());;
  int hs = 0;
  for(int i = 0; i < popUpView.subviews.size();i++){
  hs += ((View)popUpView.subviews.get(i)).h;
  }
  System.out.println("Hs = "+hs);
  popUpView.h = hs;

  mainView.draw();
 //System.out.println("Spiritual Support View y = " +spiritualSupportView.y + " and h = "+ spiritualSupportView.h + " and Acute Pain  y = "+acutePainView.y );
 fill(0);
 text("Current \nRating",640,scrollingView.y-30);
 text("Expected \nRating",740,scrollingView.y-30);
 image(firstLevelIconLegend, 20,scrollingView.y+scrollingView.h+10);
 textSize(14);
 text("NANDA-I",60,scrollingView.y+scrollingView.h+20);
 image(secondLevelIconLegend, 20,scrollingView.y+scrollingView.h+45);
 text("NOC",60,scrollingView.y+scrollingView.h+55);
 image(thirdLevelIconLegend, 20,scrollingView.y+scrollingView.h+80);
text("NIC",60,scrollingView.y+scrollingView.h+90);
 textSize(12);
 text("Nurse's Signature: _________________________", 20, scrollingView.y+scrollingView.h+125);
 text("Printed on: 09/18/2010 02:28:08", 700, scrollingView.y+scrollingView.h+125);
 
}
public static String [] wrapText (String text, int len)
{
  // return empty array for null text
  if (text == null)
  return new String [] {};

  // return text if len is zero or less
  if (len <= 0)
  return new String [] {text};

  // return text if less than length
  if (text.length() <= len)
  return new String [] {text};

  char [] chars = text.toCharArray();
  Vector lines = new Vector();
  StringBuffer line = new StringBuffer();
  StringBuffer word = new StringBuffer();

  for (int i = 0; i < chars.length; i++) {
    word.append(chars[i]);

    if (chars[i] == ' ') {
      if ((line.length() + word.length()) > len) {
        lines.add(line.toString());
        line.delete(0, line.length());
      }

      line.append(word);
      word.delete(0, word.length());
    }
  }

  // handle any extra chars in current word
  if (word.length() > 0) {
    if ((line.length() + word.length()) > len) {
      lines.add(line.toString());
      line.delete(0, line.length());
    }
    line.append(word);
  }

  // handle extra line
  if (line.length() > 0) {
    lines.add(line.toString());
  }

  String [] ret = new String[lines.size()];
  int c = 0; // counter
  for (Enumeration e = lines.elements(); e.hasMoreElements(); c++) {
    ret[c] = (String) e.nextElement();
  }

  return ret;
}
public void mousePressed()
{
  //System.out.println(mouseX + " , "+ mouseY);
  mainView.mousePressed(mouseX, mouseY);
  if(popUpView.c.pressed)
  mainView.subviews.remove(popUpView);
  //  tabView.mousepressed(mouseX,mouseY);
}
public void roundrect(int x, int y, int w, int h, int r, int c) {
  rectMode(CORNER);
  noFill();
  stroke(c);

  int  ax, ay, hr;

  ax=x+w-1;
  ay=y+h-1;
  hr = r/2;

  arc(x+r/2, y+r/2, r, r, radians(180.0f), radians(270.0f));
  arc(ax+r/2, y+r/2, r, r, radians(270.0f), radians(360.0f));
  arc(x+r/2, ay+r/2, r, r, radians(90.0f), radians(180.0f));
  arc(ax+r/2, ay+r/2, r, r, radians(0.0f), radians(90.0f));

  line(x+1+r/2, y-hr+r/2, w-2+r/2, y-hr+r/2);
  line(x, y+r/2, x, h+r/2);
  line(x+1+r/2, h+hr-1+r/2, w-2+r/2, h+hr-1+r/2);
  line(w+hr-1+r/2, y+r/2, w+hr-1+r/2, h+r/2);
}

class Button extends View {


  boolean selected = false;
  String t;
  Button(float x_, float y_,float w_,float h_,boolean selected, String t)
  {
    super(x_, y_,w_ ,h_); 
    this.selected = selected;
    this.t = t;
  }
  public void drawContent()
  {
    noStroke();
    if(selected)
  fill(buttonSelectedColor);
  else
  fill(buttonNotColor);
  
  rect(0,0,w,h);
  if(selected)
  fill(0);
  else
  fill(255);
  text(t,w/2-35,h/2-2);
  }
    public boolean contentPressed(float lx, float ly)
  {
    // override this
    // lx, ly are in the local coordinate system of the view,
    // i.e. 0,0 is the top left corner of this view
    // return false if the click is to "pass through" this view
   selected =!selected;
    return true;
  }

}
class ClosePopUpView extends View {

 boolean pressed = false;
  ClosePopUpView(float x_, float y_,float w_,float h_)
  {
    super(x_, y_,w_ ,h_); 
  }
  public void drawContent()
  {
    noStroke();
  fill(closePopUpColor);
  rect(0,0,w,h);
  fill(255);
  text("Close Popup    X",w - 100,h/2-2);
  }
     public boolean contentPressed(float lx, float ly)
  {
    // override this
    // lx, ly are in the local coordinate system of the view,
    // i.e. 0,0 is the top left corner of this view
    // return false if the click is to "pass through" this view
   pressed = true;
    return true;
  }

}
class ColouredRowView extends View {

  String title;
  PImage logo;
  public ArrayList subs;  
  ColouredRowView(float x_, float y_,String title,PImage logo)
  {
    super(x_, y_,width,25);
    this.title = title;
    this.logo = logo;
    this.subs = new ArrayList();
  }

  public void drawContent()
  {
   stroke(0);
   // textLeading(fbold);
   fill(colouredRowColor);
   rect(-1,0,w+10,h);
   fill(0);
   textSize(12);
   image(logo,5,6);
   text(title,45,12);
  }
}
class CommentRowView extends View {

  String comment;
  CommentRowView(float x_, float y_,String title)
  {
    super(x_, y_,width,25);
    this.comment = title;
  }

  public void drawContent()
  {
   stroke(0);
   // textLeading(fbold);
   fill(thirdLevelRowColor);
   rect(-1,0,w+10,h);
   fill(0);
   textSize(10);
   text(comment,115,12);
  }
}
class PatientDataView extends View {


  String title, entry;
  PatientDataView(float x_, float y_,float w_,float h_,String title, String entry)
  {
    super(x_, y_,w_ ,h_);
    this.title = title;
    this.entry = entry;
  }
  
  public void drawContent()
  {
    noStroke();
   // textLeading(fbold);
   fill(0);
    textSize(12);
    text(title,10,15);
    textFont(font);
    textSize(12);
    text(entry, 125,15);
    textFont(fbold);
}
}
class PopUpSection extends View {

  String[] rationaleString;

  Button rationaleButton, actionsButton, commentsButton;
  PopUpSection(float x_, float y_, String rationaleString)
  {
    super(x_, y_, 400, wrapText(rationaleString,35).length*20+20); 
 
 //System.out.println();
 
    rationaleButton = new Button(0, 0, 127, 20, true, "Rationale");
    this.subviews.add(rationaleButton);

    actionsButton = new Button(125, 0, 127.3f, 20, true, "Actions");
    this.subviews.add(actionsButton);

    commentsButton = new Button(250.3f, 0, 127.3f, 20, false, "Comments");
    this.subviews.add(commentsButton);

    //this.rationaleString = rationaleString;
    
    this.rationaleString = wrapText(rationaleString,35);

   // this.h = this.rationaleString.length;
    // int h_ = (stringTokens.length)*20;
    //  super(0,0,0,0);
  }
  public void drawContent()
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

class PopUpView extends View {

  ClosePopUpView c;
  
  PopUpView(float x_, float y_,float w_)
  {
    super(x_, y_,w_ ,0);
   c= new ClosePopUpView(0,0,w,20); 
    this.subviews.add(c);
  }
  public void drawContent(){
  int ys = 0;
  for(int i = 0 ;i<subviews.size();i++){
  View v = (View)subviews.get(i);
  v.y = ys;
  ys +=v.h;
 // System.out.println(ys);
  }
  

  }
}
class RationaleActionBar extends View {


  RationaleActionBar(float x_, float y_,float w_,float h_)
  {
    super(x_, y_,w_ ,h_); 
  }
  public void drawContent()
  {
    noStroke();
  fill(closePopUpColor);
  rect(0,0,w,h);
  fill(255);
  text("Close Popup    X",w - 100,h/2-2);
  }
}
class ScrollingView extends View {

  ArrayList subs;
  ScrollingView(float x_, float y_, float w_)
  {
    super(x_, y_, w_, 325);
    subs = new ArrayList();
  }

  public void drawContent()
  {
    strokeWeight(4);
    stroke(0);
    fill(255);
    rect(-5,0,w+10,h);
    strokeWeight(1);
    this.subviews =  new ArrayList();
    int usedSpace = 0;
    for (int i = 0; i < this.subs.size() && usedSpace < h;i++ ) {

      ColouredRowView tempRow = (ColouredRowView) subs.get(i);
      tempRow.y = usedSpace;
      usedSpace += tempRow.h;
      this.subviews.add(tempRow);

      for (int j = 0; j < tempRow.subs.size() && usedSpace < h; j++ ) {
        SecondLevelRowView tempRow2 = (SecondLevelRowView) tempRow.subs.get(j);
        tempRow2.y = usedSpace;
        usedSpace += tempRow2.h;
        this.subviews.add(tempRow2);
        for (int k = 0; k < tempRow2.subs.size() && usedSpace < h; k++ ) {
          ThirdLevelRowView tempRow3 = (ThirdLevelRowView) tempRow2.subs.get(k);
          tempRow3.y = usedSpace;
          usedSpace += tempRow3.h;
          if(usedSpace <= h)
          this.subviews.add(tempRow3);
        }
      }
    }
  }
}

class SecondLevelRowView extends View {

  String title;
  PImage logo;
  int firstColumn,secondColumn;
 public  ArrayList subs ;
  SecondLevelRowView(float x_, float y_,String title,PImage logo, int firstColumn, int secondColumn)
  {
    super(x_, y_,width,25);
    this.title = title;
    this.logo = logo;
    this.firstColumn = firstColumn;
    this.secondColumn = secondColumn;
    this.subs = new ArrayList();
  }

  public void drawContent()
  {
   stroke(0);
   // textLeading(fbold);
   fill(secondLevelRowColor);
   rect(-1,0,w+10,h);
   fill(0);
   textSize(12);
   image(logo,40,4);
   //ellipse(37,12,12,12);
   text(title,75,12);
   text(firstColumn, 650, 12);
   text(secondColumn, 750, 12);
  }
}
class ThirdLevelRowView extends View {

  String title;
  PImage logo;
  ArrayList<String> comments;
  ThirdLevelRowView(float x_, float y_,String title,PImage logo)
  {
    super(x_, y_,width,25);
    this.title = title;
    this.logo = logo;
    comments = new ArrayList<String>();
  }

  public void drawContent()
  {
   h = 25+(25*comments.size());
 
    //if(comments.size()>1)
   //System.out.println(comments.size() + "so h = "+h);
   stroke(0);
   // textLeading(fbold);
   fill(thirdLevelRowColor);
   rect(-1,0,w+10,h);
   fill(0);
   textSize(12);
   image(logo,60,4);
   //ellipse(37,12,12,12);
   text(title,95,12);
   for(int i = 0; i< comments.size();i++){
     textFont(font);
     textSize(11);
     text(comments.get(i),115,12+(25*(i+1)));
     textFont(fbold);
   }
  }
}
class TitleView extends View {

  PImage logo;
  String title,subtitle;
  int main, titleColor, subtitleColor;
   TitleView(float x_, float y_,float w_, PImage img, String title,String subtitle, int main, int titleColor, int subtitleColor)
  {
    super(x_, y_,w_ , 20);
    this.logo = img;
    this.title = title;
    this.main = main;
    this.titleColor = titleColor;
    this.subtitleColor = subtitleColor;
    this.subtitle = subtitle;
  }

 public void drawContent()
  {
    noStroke();
    fill(main);
    rect(0,0,this.w,27);
    image(logo,0,0);
    textFont(fbold);
    textSize(18);
    fill(titleColor);
    textAlign(LEFT,CENTER);
    text(title, logo.width+5,10);
    textSize(12);
    fill(subtitleColor);
    text(subtitle,logo.width+title.length()*15,11);
  }
}
/* This is the View Class. The class that we're going to use a superclass to all widgets.*/

class View {
  float x, y, w, h;
  ArrayList subviews;
  
  View(float x_, float y_, float w_, float h_)
  {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    subviews = new ArrayList();
  }
  
  public void draw()
  {
    pushMatrix();
    translate(x, y);
    // draw out content, then our subviews on top
    drawContent();
    for (int i = 0; i < subviews.size(); i++) {
      View v = (View)subviews.get(i);
      v.draw();
    }
    popMatrix();
  }
  
  public void drawContent()
  {
    // override this
    // when this is called, the coordinate system is local to the view,
    // i.e. 0,0 is the top left corner of this view
  }
  
  public boolean contentPressed(float lx, float ly)
  {
    // override this
    // lx, ly are in the local coordinate system of the view,
    // i.e. 0,0 is the top left corner of this view
    // return false if the click is to "pass through" this view
    return true;
  }
  
  public boolean contentDragged(float lx, float ly)
  {
    return true;
  }
  
  public boolean contentClicked(float lx, float ly)
  {
    return true;
  }
  
  public boolean contentMouseWheel(float lx, float ly, int delta)
  {
    return false;
  }

  public boolean ptInRect(float px, float py, float rx, float ry, float rw, float rh)
  {
    return px >= rx && px <= rx+rw && py >= ry && py <= ry+rh;
  }

  public boolean mousePressed(float px, float py)
  {
    if (!ptInRect(px, py, x, y, w, h)) return false;
    float lx = px - x;
    float ly = py - y;
    // check our subviews first
    for (int i = subviews.size()-1; i >= 0; i--) {
      View v = (View)subviews.get(i);
      if (v.mousePressed(lx, ly)) return true;
    }
    return contentPressed(lx, ly);
  }

  public boolean mouseDragged(float px, float py)
  {
    if (!ptInRect(px, py, x, y, w, h)) return false;
    float lx = px - x;
    float ly = py - y;
    // check our subviews first
    for (int i = subviews.size()-1; i >= 0; i--) {
      View v = (View)subviews.get(i);
      if (v.mouseDragged(lx, ly)) return true;
    }
    return contentDragged(lx, ly);
  }

  public boolean mouseClicked(float px, float py)
  {
    if (!ptInRect(px, py, x, y, w, h)) return false;
    float lx = px - x;
    float ly = py - y;
    // check our subviews first
    for (int i = subviews.size()-1; i >= 0; i--) {
      View v = (View)subviews.get(i);
      if (v.mouseClicked(lx, ly)) return true;
    }
    return contentClicked(lx, ly);
  }
  
  public boolean mouseWheel(float px, float py, int delta)
  {
    if (!ptInRect(px, py, x, y, w, h)) return false;
    float lx = px - x;
    float ly = py - y;
    // check our subviews first
    for (int i = subviews.size()-1; i >= 0; i--) {
      View v = (View)subviews.get(i);
      if (v.mouseWheel(lx, ly, delta)) return true;
    }
    return contentMouseWheel(lx, ly, delta);
  }
  
  public boolean keypressed(){
    char c = (char) key;  
    for (int i = subviews.size()-1; i >= 0; i--) {
     // System.out.println(i);

      View v = (View)subviews.get(i);
      if (v.keypressed()) return true;
    }
   return false;

  }
  
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#F0F0F0", "Prototype_1" });
  }
}
