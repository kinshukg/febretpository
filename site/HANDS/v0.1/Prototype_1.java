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
// Draft # 2
// Added Buttons, Checkboxes and PopUpSections Functionality - To be Continued
// ############################################################################################################################################################################################
static int SCREEN_WIDTH = 1024;
static int SCREEN_HEIGHT = 800;

static int POPUP_WIDTH = 400;

static int FORMAT_HEADING1 = 1;
static int FORMAT_NORMAL = 2;	

// Variables used to keep track of the prototype state
public boolean OPTION_LONG_ALERT_BUTTON = true;
public boolean OPTION_EXPANDABLE_POPUP_TEXT = true;
public boolean OPTION_ALERT_INFO_BUTTON = false;
public boolean OPTION_ENABLE_POPUP_TEXT = true;

public int prototypeState = 0;

public GradientUtils gu = new GradientUtils();

// Variables used got holding the different views
public View mainView;     // The Main View is the background of the window with all of the other widgets on top of it.

public TitleView titleView;
public PatientDataView nameView,dobView,genderView,allergiesView,codeStatusView,pocView,shftView,roomView,medicalDXView,mrView,physicianView,otherView;

public ClosePopUpView closePopUpView;
public PopUpView popUpView;
public Tooltip tooltipView = null;

POCManager pocManager;

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
public int alertHighColor = 0xffFF3333;
public int alertMidColor = 0xffFCF112;
public int alertLowColor = 0xffAAFF50;
public int tooltipColor = 0xffFFFFFF;

// Variables holding Image names
public String handIconString = "Red_Handprint__right_orange.png";
public String firstLevelIconString = "black-square.png";
public String secondLevelIconString = "black_circle.png";
public String thirdLevelIconString = "532px-TriangleArrow-Up.svg.png";
public String plusIconString = "Black_Plus.png";
public String minusIconString = "Black_Minus.png";

// Variables holding Images
public PImage handIcon,firstLevelIcon,secondLevelIcon,thirdLevelIcon;
public PImage firstLevelIconLegend, secondLevelIconLegend,thirdLevelIconLegend;
public PImage plusIcon, minusIcon;
public PImage infoIcon;

public PImage smallGraph1;
public PImage smallGraph2;
public PImage smallGraph3;

// Variables holding data of currently showing patient
public String name = "Ann Taylor";
public String dob = "03/12/1938",gender = "Female", allergies = "None" ,codeStatus = "DNR" ,poc = "09/17/2010", shft= "7:00a - 3:00p", room = "1240", medicalDX = "Malignant Neoplasm of the Pancreas" , mr = "xxx xxx xxx", physician = "Piper";
public String other = "Sister wants to be called ANYTIME at patient's request \n 776-894-1010-#################################";

// Other text strings.
public String rationale1 = "Data Mining Revealed that the combination of Medication Management, Positioning, and Pain Management has the most positive impact on pain level. ";
public String rationale2 = "Mrs Taylor's POC indicates that pain level is not controlled, a common finding for EOL patients who have Pain and Impaired Gas Exchange listed as problems on the POC.";
public String rationale3 = "Research has discovered that >50% of EOL patients do not achieve the expected NOC Pain Level goal by discharge or death.";

///////////////////////////////////////////////////////////////////////////////////////////////////
public void setup()
{
	size(SCREEN_WIDTH, SCREEN_HEIGHT);

	//Load fonts.
	font = loadFont("SegoeUI-14.vlw");
	fbold = loadFont("SegoeUI-Bold-14.vlw");
	textFont(font);

	// Load image assets.
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

	plusIcon = loadImage(plusIconString);
	plusIcon.resize(0,15);
 
	minusIcon = loadImage(minusIconString);
	minusIcon.resize(0,15);

	infoIcon = loadImage("information.png");
	smallGraph1 = loadImage("SmallGraph1.png");
	smallGraph2 = loadImage("SmallGraph2.png");
	smallGraph3 = loadImage("SmallGraph3.png");
	
	reset();
}

///////////////////////////////////////////////////////////////////////////////////////////////////
public void reset()
{
	// Views created
	mainView = new View(0, 0, width, height);

	titleView = new TitleView(0,0,width,handIcon,"HANDS","- Hands-On Automated Nursing Data System",titleBackgroundColor, titleColor,subtitleColor);
	mainView.subviews.add(titleView); 

	setupPatientInfoView();
	setupPOCView();
	setupPopup();
}

///////////////////////////////////////////////////////////////////////////////////////////////////
public void setupPatientInfoView()
{
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

	otherView = new PatientDataView(300,  titleView.h+5+nameView.h+dobView.h+20+genderView.h+allergiesView.h+codeStatusView.h, width/2,50, "Other:","\n"+other);
	mainView.subviews.add(otherView);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
public void setupPOCView()
{
	pocManager = new POCManager();
	pocManager.reset();
}

///////////////////////////////////////////////////////////////////////////////////////////////////
public void setupPopup()
{
	popUpView = new PopUpView(600, pocManager.scrollingView.y - 10, 400, pocManager.painLevelView);
	popUpView.reset();
	pocManager.painLevelView.setAlertButton(3,popUpView);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
public void draw()
{
	background(backgroundColor); 
	int hs = 0;
	for(int i = 0; i < popUpView.subviews.size();i++)
	{
		hs += ((View)popUpView.subviews.get(i)).h;
	}
	popUpView.h = hs;

	mainView.draw();
	
	// Draw static view elements
	drawStaticViewElements();

	if(tooltipView != null)
	{
		tooltipView.draw();
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
public void drawStaticViewElements()
{
	int footerY = pocManager.getBottom() + 10;
	textFont(fbold);
	
	textSize(12);
	image(firstLevelIconLegend, 20, footerY + 10);
	text("NANDA-I", 60, footerY + 20);
	image(secondLevelIconLegend, 20, footerY + 45);
	text("NOC", 60, footerY + 55);
	image(thirdLevelIconLegend, 20, footerY + 80);
	text("NIC", 60, footerY + 90);
	
	int graphLegendX = 600;
	// Legend Button width, height.
	int bw = 26;
	int bh = 12;
	
	int curY = footerY + 20;
	
	gu.drawButtonBase(graphLegendX - bw - 10, curY - bh / 2, bw, bh, alertLowColor);
	fill(0);
	text("NOC Rating is currently at expected rating", graphLegendX, curY);
	curY += 35;
	
	gu.drawButtonBase(graphLegendX - bw - 10, curY - bh / 2, bw, bh, alertMidColor);
	fill(0);
	text("NOC rating is within point 1 of expected rating", graphLegendX, curY);
	curY += 35;

	gu.drawButtonBase(graphLegendX - bw - 10, curY - bh / 2, bw, bh, alertHighColor);
	fill(0);
	text("NOC rating is 2 or more points away from expected rating", graphLegendX, curY);
	curY += 35;
	
	textSize(12);
	text("Nurse's Signature: _________________________", 20, footerY + 125);
	text("Printed on: 09/18/2010 02:28:08", 700, footerY + 125);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
public void mouseClicked()
{
	// Kinda hack: if a tooltip window is enabled, a click closes it regardless of where the user clicks.
	if(tooltipView != null)
	{
		tooltipView = null;
	}
	mainView.mousePressed(mouseX, mouseY);
	if(popUpView.c.pressed)
	{
		mainView.subviews.remove(popUpView);
		popUpView.c.pressed = false;  
	}
	if(popUpView.commit.selected)
	{
		for(int i = 0; i < popUpView.subviews.size(); i++)
		{
			View v = (View)popUpView.subviews.get(i);
			if(!v.equals(popUpView.commit) && !v.equals(popUpView.notApplicable) && !v.equals(popUpView.c))
			{
				PopUpSection pps = (PopUpSection)v;
				ArrayList toRemove = new ArrayList();
				if(pps.actionBoxes != null) 
				{
					for(int j = 0; j < pps.actionBoxes.size(); j++)
					{
						CheckBox c = pps.actionBoxes.get(j);
						if(c.selected)
						{
							toRemove.add(c);
							if(c.icon1.equals(plusIcon) && c.type.equals("NIC"))
							{
								pocManager.addNIC(c.t, c.tb.text,popUpView.parent);
							}
							if(c.icon1.equals(plusIcon) && c.type.equals("NOC"))
							{
								pocManager.addNOC(c.t, c.tb.text,popUpView.parent.parent);
							}
						}
					}
				}
				// Remove checked items after a commit.
				for(int j = 0; j < toRemove.size(); j++)
				{
					v.subviews.remove(toRemove.get(j));
					pps.actionBoxes.remove(toRemove.get(j));
				}
			}
		}
		mainView.subviews.remove(popUpView);
		popUpView.commit.selected = false;
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
public void keyPressed() 
{
	if(key == '1')
	{
		OPTION_LONG_ALERT_BUTTON = true;
		OPTION_ALERT_INFO_BUTTON = false;
		OPTION_EXPANDABLE_POPUP_TEXT = true;
		OPTION_ENABLE_POPUP_TEXT = true;
		reset();
	}
	else if(key == '2')
	{
		OPTION_LONG_ALERT_BUTTON = false;
		OPTION_EXPANDABLE_POPUP_TEXT = false;
		OPTION_ENABLE_POPUP_TEXT = false;
		OPTION_ALERT_INFO_BUTTON = true;
		reset();
	}

	mainView.keypressed();
}

///////////////////////////////////////////////////////////////////////////////////////////////////
public void roundrect(int x, int y, int w, int h, int r) 
{
    noStroke();
    rectMode(CORNER);

    int  ax, ay, hr;

    ax=x+w-1;
    ay=y+h-1;
    hr = r/2;

    rect(x, y, w, h);
    arc(x, y, r, r, radians(180.0f), radians(270.0f));
    arc(ax, y, r, r, radians(270.0f), radians(360.0f));
    arc(x, ay, r, r, radians(90.0f), radians(180.0f));
    arc(ax, ay, r, r, radians(0.0f), radians(90.0f));
    rect(x, y-hr, w, hr);
    rect(x-hr, y, hr, h);
    rect(x, y+h, w, hr);
    rect(x+w, y, hr, h);

    rectMode(CORNERS);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
class Button extends View 
{
	boolean selected = false, flashing = false;
	String t;
	int buttonColor, textColor;
	PImage icon;
	
	// Tooltip mode: 0 = disabled, 1 = open on click, 2 = open on hover.
	int tooltipMode = 0;
	String tooltipText;
	
	boolean transparent;
  
	///////////////////////////////////////////////////////////////////////////////////////////////
	Button(float x_, float y_,float w_,float h_, PImage icon_)
	{
		super(x_, y_,w_ ,h_); 
		icon = icon_;
		transparent = true;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	Button(float x_, float y_,float w_,float h_, String t, int buttonColor, int textColor)
	{
		super(x_, y_,w_ ,h_); 
		this.t = t;
		this.buttonColor = buttonColor;
		this.textColor = textColor;
		icon = null;
		transparent = false;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	public void layout()
	{
		if(w == 0)
		{
			w = textWidth(t) + 10;
		}
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	public void drawContent()
	{
		noStroke();
		//   if(flashing)

		if(!transparent)
		{
			fill(0);
			roundrect(-1, -1, (int)w + 2, (int)h + 2, 5);

			fill(buttonColor);
			roundrect(0,0,(int)w,(int)h,5);
		}
		
		if(icon != null)
		{
			image(icon, -1, 0);
		}
		
		if(t != null)
		{
			fill(textColor);
			textAlign(CENTER,CENTER);
			text(t, w / 2, h / 2 - 2);
		}
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	public boolean contentPressed(float lx, float ly)
	{
		if(tooltipMode == 1)
		{
			tooltipView = new Tooltip(mouseX + 10, mouseY + 10, 300, 60, tooltipText);
			tooltipView.arrowX = mouseX;
			tooltipView.arrowY = mouseY;
		}
		// override this
		// lx, ly are in the local coordinate system of the view,
		// i.e. 0,0 is the top left corner of this view
		// return false if the click is to "pass through" this view
		selected =!selected;
		System.out.println("Clicked");

		return false;
	}
}
class CheckBox extends View {


  boolean iconUsed, selected, icon2Used;
  String t;
  PImage icon1, icon2;
  String type = "";
  TextBox tb;
  
  CheckBox(float x_, float y_,boolean iconUsed,boolean icon2Used,boolean selected, String t, PImage icon1, PImage icon2)
  {
    super(x_, y_,250,20); 
    this.selected = selected;
    this.t = t;
    this.iconUsed = iconUsed;
    this.icon2Used = icon2Used;
    if(iconUsed)
      this.icon1 = icon1;
      
    if(icon2Used)
     this.icon2 = icon2;
    tb = new TextBox(20,30);
  }
  CheckBox(float x_, float y_,boolean iconUsed,boolean icon2Used,boolean selected, String t, PImage icon1, PImage icon2, String type)
  {
    super(x_, y_,250,20); 
    this.selected = selected;
    this.t = t;
    this.iconUsed = iconUsed;
    this.icon2Used = icon2Used;
    if(iconUsed)
      this.icon1 = icon1;
      
    if(icon2Used)
     this.icon2 = icon2;
    this.type = type;
    
    
    tb = new TextBox(20,30);
  }
  public void drawContent()
  {
    
    textAlign(LEFT,CENTER);
    strokeWeight(3);
    stroke(0);
    if(selected)
    fill(0);
   // rect(0,0,w,h);
   else
   fill(popUpSectionColor);
   
   rect(5,1.65f,23,16);
   if(iconUsed)
    image(icon1,30,2);
    
   if(icon2Used)
    image(icon2,48,2);
 
 fill(0);
 
 textSize(16);
 if(!type.equals(""))
    text(type+" "+t, 70, 8);
   else
   text(t, 70, 8);
   
    textSize(12);
  }
    public boolean contentPressed(float lx, float ly)
  {
    // override this
    // lx, ly are in the local coordinate system of the view,
    // i.e. 0,0 is the top left corner of this view
    // return false if the click is to "pass through" this view
   selected =!selected;
   tb.activated = false;
   System.out.println("Selected = "+ selected);
   if(selected){
   this.subviews.add(tb);
   this.h = 60; 
   }  else{
   this.subviews.remove(tb);
   this.h = 20; 
   
   }
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
class CommentView extends View
{
  
   public CommentView(float x_, float y_)
  {
    super(x_, y_, 320, 30);
//    text = "";
  }
  
}
class GradientUtils
{
  ////////////////////////////////////////////////////////////////////////////////////////////////////
  public void drawBox(int x, int y, int width, int height, int dx, int c, int sa)
  {
    strokeWeight(1);
    stroke(c, sa);
    line(x, y - dx, x + width, y - dx);
    line(x, y + height + dx, x + width, y + height + dx);
    line(x - dx, y, x - dx, y + height);
    line(x + width + dx, y, x + width + dx, y + height);
  }
  
  ////////////////////////////////////////////////////////////////////////////////////////////////////
  public void drawButtonBase(int x, int y, int w, int h, int c)
  {
	fill(0);
	drawRoundrect(x - 1, y - 1, (int)w + 2, (int)h + 2, 5);

	fill(c);
	drawRoundrect(x, y, (int)w,(int)h,5);
  }
  
	///////////////////////////////////////////////////////////////////////////////////////////////////
	public void drawRoundrect(int x, int y, int w, int h, int r) 
	{
		noStroke();
		rectMode(CORNER);

		int  ax, ay, hr;

		ax=x+w-1;
		ay=y+h-1;
		hr = r/2;

		rect(x, y, w, h);
		arc(x, y, r, r, radians(180.0f), radians(270.0f));
		arc(ax, y, r, r, radians(270.0f), radians(360.0f));
		arc(x, ay, r, r, radians(90.0f), radians(180.0f));
		arc(ax, ay, r, r, radians(0.0f), radians(90.0f));
		rect(x, y-hr, w, hr);
		rect(x-hr, y, hr, h);
		rect(x, y+h, w, hr);
		rect(x+w, y, hr, h);

		rectMode(CORNERS);
	}

  ////////////////////////////////////////////////////////////////////////////////////////////////////
  public void drawGradient(int x, int y, int width, int height, int start, int sa, int end, int ea)
  {
    noStroke();
    beginShape(QUADS);
    
    fill(start, sa);
    vertex(x, y);
    vertex(x + width, y);
    
    fill(end, ea);
    vertex(x + width, y + height);
    vertex(x, y + height);
    
    endShape(); 
  }
  
  ////////////////////////////////////////////////////////////////////////////////////////////////////
  public void drawVGradient(float x, float y, float width, float height, int start, int sa, int end, int ea, float pc)
  {
    noStroke();
    fill(start, sa);
    
    float h1 = PApplet.parseInt(height * pc);
    
    rect(x, y, width, h1);
    y += h1;
    height -= h1;
    
    beginShape(QUADS);
    
    vertex(x, y);
    vertex(x + width, y);
    
    fill(end, ea);
    vertex(x + width, y + height);
    vertex(x, y + height);
    
    endShape(); 
  }
  
  ////////////////////////////////////////////////////////////////////////////////////////////////////
  public void drawHGradient(float x, float y, float width, float height, int start, int sa, int end, int ea, float pc)
  {
    noStroke();
    fill(start, sa);
    
    float w1 = PApplet.parseInt(width * pc);
    
    rect(x, y, w1, height);
    x += w1;
    width -= w1;
    
    beginShape(QUADS);
    
    vertex(x, y + height);
    vertex(x, y);

    fill(end, ea);
    vertex(x + width, y);
    vertex(x + width, y + height);
    
    endShape(); 
  }
  
  ////////////////////////////////////////////////////////////////////////////////////////////////////
  public void drawGradient2(int x1, int y1, int x2, int y2, int x3, int y3, int x4, int y4, int start, int sa, int end, int ea)
  {
    noStroke();
    beginShape(QUADS);
    
    fill(start, sa);
    vertex(x1, y1);
    vertex(x2, y2);
    
    fill(end, ea);
    vertex(x3, y3);
    vertex(x4, y4);
    
    endShape(); 
  }
}
///////////////////////////////////////////////////////////////////////////////////////////////////
class POCManager
{
	// NANDA lines
	ColouredRowView impairedGasExchange;
	ColouredRowView deathAnxietyView;
	ColouredRowView acutePainView;
	
	// NOC Lines
	SecondLevelRowView anxietyLevelView;
	SecondLevelRowView anxietySelfControlView;
	SecondLevelRowView painLevelView; 
	
	ThirdLevelRowView musicTherapyView;
	ThirdLevelRowView calmingTechniqueView;
	ThirdLevelRowView calmingTechniqueView_2; 
	ThirdLevelRowView spiritualSupportView;
	ThirdLevelRowView medicationManagementView;
	ThirdLevelRowView painManagementView;
	ScrollingView scrollingView;
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	public void reset()
	{
		scrollingView = new ScrollingView(0, 40+titleView.h+5+nameView.h+dobView.h+20+genderView.h+allergiesView.h+codeStatusView.h+otherView.h, width, SCREEN_HEIGHT - 400);
		mainView.subviews.add(scrollingView);

		impairedGasExchange = new ColouredRowView(0, titleView.h+15+nameView.h+dobView.h+20+genderView.h+allergiesView.h+codeStatusView.h+otherView.h+40,"Impaired Gas Exchange",firstLevelIcon);
		scrollingView.subs.add(impairedGasExchange);  

		anxietyLevelView = new SecondLevelRowView(0,  titleView.h+15+nameView.h+dobView.h+20+genderView.h+allergiesView.h+codeStatusView.h+otherView.h+40+ impairedGasExchange.h,"Anxiety Level",secondLevelIcon,2,3,impairedGasExchange);
		anxietyLevelView.setGraphButton(2, smallGraph1); 
		impairedGasExchange.subs.add(anxietyLevelView);

		musicTherapyView = new ThirdLevelRowView(0,titleView.h+15+nameView.h+dobView.h+20+genderView.h+allergiesView.h+codeStatusView.h+otherView.h+40+ impairedGasExchange.h+anxietyLevelView.h,"Music Therapy", thirdLevelIcon);
		anxietyLevelView.subs.add(musicTherapyView);

		calmingTechniqueView = new ThirdLevelRowView(0,titleView.h+15+nameView.h+dobView.h+20+genderView.h+allergiesView.h+codeStatusView.h+otherView.h+40+ impairedGasExchange.h+anxietyLevelView.h+musicTherapyView.h,"Calming Technique",thirdLevelIcon);
		anxietyLevelView.subs.add(calmingTechniqueView);

		deathAnxietyView = new ColouredRowView(0, titleView.h+15+nameView.h+dobView.h+20+genderView.h+allergiesView.h+codeStatusView.h+otherView.h+40+impairedGasExchange.h+anxietyLevelView.h+calmingTechniqueView.h+musicTherapyView.h,"Death Anxiety",firstLevelIcon);
		scrollingView.subs.add(deathAnxietyView);

		anxietySelfControlView = new SecondLevelRowView(0,  titleView.h+15+nameView.h+dobView.h+20+genderView.h+allergiesView.h+codeStatusView.h+otherView.h+40+ impairedGasExchange.h+anxietyLevelView.h+deathAnxietyView.h+calmingTechniqueView.h+musicTherapyView.h,"Anxiety Self-Control",secondLevelIcon,5,5,deathAnxietyView);
		anxietySelfControlView.setGraphButton(1, smallGraph2); 
		deathAnxietyView.subs.add(anxietySelfControlView);

		calmingTechniqueView_2 = new ThirdLevelRowView(0,titleView.h+15+nameView.h+dobView.h+20+genderView.h+allergiesView.h+codeStatusView.h+otherView.h+40+ impairedGasExchange.h+anxietyLevelView.h+deathAnxietyView.h+calmingTechniqueView.h+musicTherapyView.h+anxietySelfControlView.h,"Calming Technique",thirdLevelIcon);
		anxietySelfControlView.subs.add(calmingTechniqueView_2);

		spiritualSupportView = new ThirdLevelRowView(0,calmingTechniqueView_2.h+titleView.h+15+nameView.h+dobView.h+20+genderView.h+allergiesView.h+codeStatusView.h+otherView.h+40+ impairedGasExchange.h+anxietyLevelView.h+deathAnxietyView.h+calmingTechniqueView.h+musicTherapyView.h+anxietySelfControlView.h,"Spiritual Support",thirdLevelIcon);
		anxietySelfControlView.subs.add(spiritualSupportView);

		spiritualSupportView.comments.add("Family Priest to Visit 2am");

		acutePainView = new ColouredRowView(0,  50+calmingTechniqueView_2.h+spiritualSupportView.h+titleView.h+15+nameView.h+dobView.h+20+genderView.h+allergiesView.h+calmingTechniqueView.h+musicTherapyView.h+codeStatusView.h+otherView.h+40+ impairedGasExchange.h+anxietyLevelView.h+deathAnxietyView.h + anxietySelfControlView.h,"Acute Pain",firstLevelIcon);
		scrollingView.subs.add(acutePainView);

		painLevelView = new SecondLevelRowView(0, 50+calmingTechniqueView_2.h+spiritualSupportView.h+acutePainView.h+titleView.h+15+nameView.h+dobView.h+20+genderView.h+allergiesView.h+codeStatusView.h+calmingTechniqueView.h+musicTherapyView.h+otherView.h+40+ impairedGasExchange.h+anxietyLevelView.h+deathAnxietyView.h + anxietySelfControlView.h, "Pain Level",secondLevelIcon,1,5,acutePainView);
		painLevelView.setGraphButton(3, smallGraph3); 
		acutePainView.subs.add(painLevelView);
		
		medicationManagementView = new ThirdLevelRowView(0, 50+calmingTechniqueView_2.h+spiritualSupportView.h+acutePainView.h+titleView.h+15+nameView.h+dobView.h+20+genderView.h+allergiesView.h+codeStatusView.h+calmingTechniqueView.h+musicTherapyView.h+otherView.h+40+ impairedGasExchange.h+anxietyLevelView.h+deathAnxietyView.h + anxietySelfControlView.h+painLevelView.h,"Medical Management",thirdLevelIcon);
		painLevelView.subs.add(medicationManagementView);

		painManagementView = new ThirdLevelRowView(0, 50+medicationManagementView.h+calmingTechniqueView_2.h+spiritualSupportView.h+acutePainView.h+titleView.h+15+nameView.h+dobView.h+20+genderView.h+allergiesView.h+codeStatusView.h+calmingTechniqueView.h+musicTherapyView.h+otherView.h+40+ impairedGasExchange.h+anxietyLevelView.h+deathAnxietyView.h + anxietySelfControlView.h+painLevelView.h,"Pain Management",thirdLevelIcon);
		painLevelView.subs.add(painManagementView);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	public void addNIC(String text, String comment,SecondLevelRowView parentNOC)
	{
		ThirdLevelRowView temp = new ThirdLevelRowView(0, parentNOC.y+parentNOC.h,text,thirdLevelIcon);
     temp.comments.add(comment);
				
for(int k =0 ; k < parentNOC.subs.size();k++)
		{
			ThirdLevelRowView tempo = (ThirdLevelRowView)parentNOC.subs.get(k);
                   	tempo.y = temp.y+((k+1)*temp.h);
		}
		//mainView.subviews.add(medicationManagementView);
		parentNOC.subs.add(0,temp);
		scrollingView.rearrange();
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	public void addNOC(String text,String comment, ColouredRowView parentNANDA)
	{
		SecondLevelRowView temp = new SecondLevelRowView(0, parentNANDA.y+parentNANDA.h, text, secondLevelIcon, 0, 0, parentNANDA);
 temp.comment = comment;
					
for(int k =0 ; k < parentNANDA.subs.size();k++)
		{
			SecondLevelRowView tempo = (SecondLevelRowView)parentNANDA.subs.get(k);
                       tempo.y = temp.y+((k+1)*temp.h);
		}
		//mainView.subviews.add(medicationManagementView);
		parentNANDA.subs.add(0,temp);
		pocManager.scrollingView.rearrange();
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	public int getBottom()
	{
		return (int)scrollingView.y + (int)scrollingView.h;
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
class PopUpSection extends View 
{
	String title;
	
	StaticText titleBox;
	StaticText descriptionBox;
	
	Button titleButton;
	int titleButtonMode;
	
	int separatorStyle;
	ArrayList<CheckBox> actionBoxes;

	///////////////////////////////////////////////////////////////////////////////////////////////
	PopUpSection(float x_, float y_, ArrayList<CheckBox> actions, String title)
	{
		super(x_, y_, 400, 0);
		if(actions != null) 
		{
			h = 60 + (actions.size() * 20);
		}
		else
		{
			h = 60;
		}
		
		this.title = title;
		this.titleBox = new StaticText(title, FORMAT_HEADING1);
		subviews.add(titleBox);
		
		actionBoxes = actions;
		
		if(actions != null)
		{
			int ys = 35;
			for(int i = 0; i < actions.size(); i++)
			{
				CheckBox c = actions.get(i);
				c.y = ys;
				this.subviews.add(c);
				ys += 25;
			}
		}		
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	public void setDescription(String text)
	{
		descriptionBox = new StaticText(text, FORMAT_NORMAL);
		subviews.add(descriptionBox);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	public void setInfoButton(String text)
	{
		titleButton = new Button(0, 0, 16, 16, infoIcon);
		titleButton.tooltipMode = 1;
		titleButton.tooltipText = text;
		subviews.add(titleButton);
		titleButtonMode = 1;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	public void enableExpandableDescription()
	{
		titleButton = new Button(0, 0, 16, 16, infoIcon);
		subviews.add(titleButton);
		titleButtonMode = 2;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	public void layout()
	{
		if(titleButton != null)
		{
			titleButton.y = 2;
			titleButton.x = 0;
			titleButton.w = 16;
			titleButton.h = 16;
			titleBox.x = 20;
		}
		else
		{
			titleBox.x = 0;
		}
		titleBox.w = w;
		h = titleBox.h + 5;
		if(descriptionBox != null)
		{
			if(titleButtonMode == 2)
			{
				descriptionBox.visible = titleButton.selected;
				if(titleButton.selected)
				{
					descriptionBox.y = titleBox.h + 5;
					descriptionBox.x = 10;
					descriptionBox.w = w;
					h = descriptionBox.y + descriptionBox.h;
				}
			}
			if(titleButtonMode == 0)
			{
				descriptionBox.y = titleBox.h + 5;
				descriptionBox.x = 10;
				descriptionBox.w = w;
				h = descriptionBox.y + descriptionBox.h;
			}
		}
		if(actionBoxes != null)
		{
			for(int i = 0; i < actionBoxes.size(); i++)
			{
				CheckBox cb = actionBoxes.get(i);
				cb.x = 15;
				cb.y = h;
				h += cb.h + 10;
			}
		}
		if(separatorStyle != 0)
		{
			h += 16;
		}
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	public void drawContent()
	{
		noStroke();
		fill(popUpSectionColor);
		rect(0,0,w,h);

		if(separatorStyle != 0)
		{
			strokeWeight(4);
			stroke(0);
			line(0, h - 2, w, h - 2);
			strokeWeight(1);
		}
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
class PopUpView extends View 
{
	ClosePopUpView c;
	float arrowX, arrowY;
	Button commit, notApplicable;
	SecondLevelRowView parent;

	///////////////////////////////////////////////////////////////////////////////////////////////
	PopUpView(float x_, float y_, float w_, SecondLevelRowView parent)
	{
		super(x_, y_,w_ ,0);
		c = new ClosePopUpView(0,0,w,20); 
		this.subviews.add(c);
		commit = new Button(20,0,150,20,"Save Changes",0,255);
		notApplicable = new Button(200,0,180,20,"Not Applicable, because...",0,255);
		this.subviews.add(commit);
		this.subviews.add(notApplicable);	
		this.parent = parent;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	public void reset()
	{
		CheckBox c = new CheckBox(0,0,true,false,false,"Positioning",plusIcon,null,"NIC");
		ArrayList a = new ArrayList ();
		a.add(c);

		PopUpSection title = new PopUpSection(0, 0, null, "Mrs. Taylor's Pain Level is not controlled");
		if(OPTION_ENABLE_POPUP_TEXT)
		{
			title.setDescription(
				"Evidence Sugests That: BULLET \n " +
					"- A combination of Medication Management, Poitioning and Pain Management has most positive impact on Pain Level\n " +
					"- It is more difficult to control pain when EOL patient has both Pain and Impaired Gas Exchange as problems\n " +
					"- More than 50% of EOL patients do not achieve expected NOC Pain Level by discharge or death.\n ");
			title.separatorStyle = 1;
			if(OPTION_EXPANDABLE_POPUP_TEXT) title.enableExpandableDescription();
		}
		//title.setInfoButton("Here is some information insida a tooltip yall");
		
		PopUpSection recommended = new PopUpSection(0,0,a,"Recommended Actions: ");

		CheckBox c1 = new CheckBox(10,0,true,false,false,"Energy Conservation",plusIcon,null,"NOC");
		CheckBox c2 = new CheckBox(10,0,true,false,false,"Coping",plusIcon,null,"NOC");
		CheckBox c3 = new CheckBox(10,0,true,false,false,"Pain Controlled Analgesia",plusIcon,null,"NIC");
		CheckBox c4 = new CheckBox(10,0,true,false,false,"Relaxation Therapy",minusIcon,null,"NIC");

		ArrayList a1 = new ArrayList ();
		a1.add(c1);
		a1.add(c2); 
		a1.add(c3);
		a1.add(c4);
		
		PopUpSection alsoConsider = new PopUpSection(0,0,a1,"Also Consider: ");
		subviews.add(title);
		subviews.add(recommended);
		subviews.add(alsoConsider);
	}

	///////////////////////////////////////////////////////////////////////////////////////////////
	public void drawContent()
	{
		int ys = 0;
		for(int i = 0 ;i<subviews.size();i++)
		{
			View v = (View)subviews.get(i);

			if(!v.equals(commit) && !v.equals(notApplicable))
			{
				v.y = ys;
				ys +=v.h;
			}
		}
		
		int contours = 12;
		for(int i = 0; i < contours; i++)
		{
			int alpha = 50 - (50 / contours) * (i * i);
			fill(0, 0, 0, alpha);
			stroke(0, 0, 0, alpha);
			strokeWeight(1);
			roundrect(-i, -i, (int)w + i * 2, (int)(h - 10) + i * 2, 5);
			//triangle(0, (contours - i) * 2, arrowX - x, arrowY - y, 0, h - (contours - i) * 2);
		}
		
		noStroke();
		fill(popUpSectionColor);
		rect(0,ys,w,ys+30);
		commit.y = ys;
		notApplicable.y = ys;                
		fill(popUpSectionColor);
		stroke(0);
		triangle(0, 0, arrowX - x, arrowY - y, 0, ys);
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
///////////////////////////////////////////////////////////////////////////////////////////////////
class ScrollingView extends View 
{
	ArrayList subs;
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	ScrollingView(float x_, float y_, float w_, float h_)
	{
		super(x_, y_, w_, h_);
		subs = new ArrayList();
	}

	///////////////////////////////////////////////////////////////////////////////////////////////
	public void drawContent()
	{
		fill(0);
		text("Current \nRating", 640, - 30);
		text("Expected \nRating", 740, - 30);
	
		strokeWeight(4);
		stroke(0);
		fill(255);
		rect(-5,0,w+10,h);
		strokeWeight(1);
		this.subviews =  new ArrayList();
		int usedSpace = 0;
		for (int i = 0; i < this.subs.size() && usedSpace < h;i++ ) 
		{
			ColouredRowView tempRow = (ColouredRowView) subs.get(i);
			tempRow.y = usedSpace;
			usedSpace += tempRow.h;
			this.subviews.add(tempRow);
			for (int j = 0; j < tempRow.subs.size() && usedSpace < h; j++ ) 
			{
				SecondLevelRowView tempRow2 = (SecondLevelRowView) tempRow.subs.get(j);
				tempRow2.y = usedSpace;
				usedSpace += tempRow2.h;
				this.subviews.add(tempRow2);
				for (int k = 0; k < tempRow2.subs.size() && usedSpace < h; k++ ) 
				{
					ThirdLevelRowView tempRow3 = (ThirdLevelRowView) tempRow2.subs.get(k);
					tempRow3.y = usedSpace;
					usedSpace += tempRow3.h;
					if(usedSpace <= h) this.subviews.add(tempRow3);
				}
			}
		}
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	public void rearrange()
	{
		this.subviews =  new ArrayList();
		int usedSpace = 0;
		for (int i = 0; i < this.subs.size() && usedSpace < h;i++ ) 
		{
			ColouredRowView tempRow = (ColouredRowView) subs.get(i);
			tempRow.y = usedSpace;
			usedSpace += tempRow.h;
			this.subviews.add(tempRow);

			for (int j = 0; j < tempRow.subs.size() && usedSpace < h; j++ ) 
			{
				SecondLevelRowView tempRow2 = (SecondLevelRowView) tempRow.subs.get(j);
				tempRow2.y = usedSpace;
				usedSpace += tempRow2.h;
				this.subviews.add(tempRow2);
				for (int k = 0; k < tempRow2.subs.size() && usedSpace < h; k++ ) 
				{
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

///////////////////////////////////////////////////////////////////////////////////////////////////
class SecondLevelRowView extends View 
{
	String title;
	String message;
	PImage logo;
String comment = "";
	int firstColumn,secondColumn;
	public ArrayList subs ;
	
	Button graphButton, actionButton;
	Button infoButton;
	
	public PopUpView actionPopUp, graphPopUp;
        ColouredRowView parent;
          
	///////////////////////////////////////////////////////////////////////////////////////////////
	SecondLevelRowView(float x_, float y_,String title,PImage logo, int firstColumn, int secondColumn, ColouredRowView parent)
	{
		super(x_, y_,width,25);
		this.title = title;
		this.logo = logo;
		this.firstColumn = firstColumn;
		this.secondColumn = secondColumn;
		this.subs = new ArrayList();
		this.parent=  parent;
	}

	///////////////////////////////////////////////////////////////////////////////////////////////
	public void drawContent()
	{
  
//System.out.println("Title = "+ title+ " Comment = " +comment+".");
                if(!comment.equals(""))
                h = 50;
                else
                h = 25;
		stroke(0);
		// textLeading(fbold);
		fill(secondLevelRowColor);
		rect(-1,0,w+10,h);
		fill(0);
		textSize(12);
		image(logo,40,4);
		//ellipse(37,12,12,12);
		text(title,75,12);
		if(firstColumn != 0) text(firstColumn, 650, 12);
		if(secondColumn != 0) text(secondColumn, 750, 12);
		
		if(message != null)
		{
			fill(alertHighColor);
			text(message, 200, 12);
		}
if(!comment.equals("")){
  textFont(font);
  textSize(12);
            text(comment,100, 32);
            textFont(fbold);
  }
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	public void setAlertButton(int level, PopUpView p)
	{
		int buttonColor = 0;
		if(level == 1) buttonColor = alertLowColor;
		if(level == 2) buttonColor = alertMidColor;
		if(level == 3) buttonColor = alertHighColor;

		if(OPTION_LONG_ALERT_BUTTON)
		{
			this.actionButton = new Button(200, 6, 0, 14, "Mrs. Taylor's Pain Level is not controlled.", buttonColor, 0);
		}
		else 
		{
			this.actionButton = new Button(450, 6, 0, 14, "ACTIONS", buttonColor, 0);
			this.message = "Mrs. Taylor's Pain Level is not controlled.";
		}
		subviews.add(this.actionButton);
		
		if(OPTION_ALERT_INFO_BUTTON)
		{
			infoButton = new Button(520, 6, 16, 16, infoIcon);
			infoButton.tooltipMode = 1;
			infoButton.tooltipText = 
				"This requires action because analysis of similar patient's data shows: BULLET \n " +
				"* It is difficult to control Pain in EOL ptients who also have impaired Gas Exchange\n " + 
				"* >50% of EOL patients do not achieve expected NOC Pain Rating by discharge or death\n";
			subviews.add(infoButton);
		}
		
		//this.actionButton.tooltipText = "Tooltip text, bla bla bla ba bla blag askdj sfjwev fweic";
		//this.actionButton.tooltipMode = 1;

		this.actionPopUp = p;   
	}

	///////////////////////////////////////////////////////////////////////////////////////////////
	public void setGraphButton(int level, PImage graphIcon)
	{
		int buttonColor = 0;
		if(level == 1) buttonColor = alertLowColor;
		if(level == 2) buttonColor = alertMidColor;
		if(level == 3) buttonColor = alertHighColor;
		graphButton = new Button(550, 5, 50, 16, graphIcon);
		graphButton.transparent = false;
		graphButton.buttonColor = buttonColor;
		subviews.add(this.graphButton);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	public boolean contentPressed(float lx, float ly)
	{
		// override this
		// lx, ly are in the local coordinate system of the view,
		// i.e. 0,0 is the top left corner of this view
		// return false if the click is to "pass through" this view
		if(actionButton != null)
		{
			if(actionButton.selected)
			{
				if(!mainView.subviews.contains(actionPopUp)) mainView.subviews.add(actionPopUp);
				actionPopUp.arrowX = mouseX;
				actionPopUp.arrowY = mouseY;
				actionButton.selected = false;
			}
			else
			{
				mainView.subviews.remove(actionPopUp);
			}
		}
		return true;
	}
}
///////////////////////////////////////////////////////////////////////////////////////////////////
class StaticText extends View 
{
	String text;
	String textLines;
	float arrowX, arrowY;
	int numLines;
	int textFormat;
	int textColor;
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	StaticText(String text, int format)
	{
		super(0, 0, 0 ,0);
		this.text = text;
		this.textFormat = format;
		numLines = 0;
		
		textColor = color(0, 0, 0);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	public void layout()
	{
		// Set text style.
		if(textFormat == FORMAT_HEADING1)
		{
			textFont(fbold);
			textSize(14);
		}
		else if(textFormat == FORMAT_NORMAL)
		{
			textFont(font);
			textSize(12);
		}
		
		// Compute bounds
		if(textLines == null)
		{
			textLines = _wrapText(text, (int)w);
		}
		h = numLines * (textAscent() + textDescent());
	}

	///////////////////////////////////////////////////////////////////////////////////////////////
	public void drawContent()
	{
		// stroke(0);
		// fill(0);
		// //System.out.println(textLines);
		// textSize(12);
		// textLeading(1);
		// textFont(font);
		stroke(textColor);
		fill(textColor);
		textAlign(LEFT, TOP);
		text(textLines, 0, 0);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	public String _wrapText(String string, int lineWidth)
	{
		String[] words = string.split(" ");
		String output = "";
		String line = "";
		boolean bullets = false;
		for(int i = 0; i < words.length; i++)
		{
			if(words[i].equals("BULLET"))
			{
				bullets = true;
				continue;
			}
			String testLine = line + words[i] + " ";
			if(textWidth(testLine) >= lineWidth || words[i].endsWith("\n"))
			{
				if(words[i].endsWith("\n"))
				{
					output += line + words[i];
					if(bullets) line = "        ";
					else line = "";
				}
				else
				{
					output += line + "\n";
					if(bullets) line = "            " + words[i] + " ";
					else line = words[i] + " ";
				}
				numLines++;
			}
			else
			{
				line = testLine;
			}
		}
		output += line;
		numLines++;
		return output;
	}
}
class TextBox extends View
{
  ////////////////////////////////////////////////////////////////////////////////////////////////////
  public String text;
  public boolean  activated = false;
  ////////////////////////////////////////////////////////////////////////////////////////////////////
  public TextBox(float x_, float y_)
  {
    super(x_, y_, 320, 20);
    text = "";
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////
 public void drawContent()
	{
    fill(255);
  if(activated)
    stroke(0);
    else
    
    stroke(0xffA3A3A3);
    strokeWeight(1.5f);
    rect(0, 0, w, h);

    fill(0);
    textFont(font, 12);
  //  textAlign(LEFT,CENTER);
    
    if (text.equals("") && !activated)
    {
      fill(0xffA3A3A3);
      text("Enter a comment", 15, 5);
    }
    else {
    /*  if (activated)
        fill(0);
      else
        fill(#A3A3A3);
      */
      text(text, 15, 5);
    }
    textFont(fbold);
    //textAlign(CENTER,CENTER);
    
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////
  public boolean keypressed() 
    {
      if (activated) {
        if (key == 8)
        {
          if (text.length() > 0) text = text.substring(0, text.length() - 1);
        }
        else
        {
          text += key;
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
    public boolean contentPressed(float lx, float ly)
    {

      activated = !activated;
      System.out.println("Activated = "+ activated);
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
  }


class ThirdLevelRowView extends View 
{
	String title;
	PImage logo;
	ArrayList<String> comments;
  
	///////////////////////////////////////////////////////////////////////////////////////////////
	ThirdLevelRowView(float x_, float y_,String title,PImage logo)
	{
		super(x_, y_,width,25);
		this.title = title;
		this.logo = logo;
		comments = new ArrayList<String>();

	}

	///////////////////////////////////////////////////////////////////////////////////////////////
	public void drawContent()
	{
		h = 25+(25*comments.size());
if(comments.size()>1)
System.out.println("Title = "+ title+ " Comment = " +comments.get(0)+".");

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
		textAlign(LEFT,CENTER);
		text(title,95,12);
		for(int i = 0; i< comments.size();i++)
		{
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
///////////////////////////////////////////////////////////////////////////////////////////////////
class Tooltip extends View 
{
	String text;
	float arrowX, arrowY;
	String[] rationaleString;
	
	StaticText label;
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	Tooltip(float x_, float y_, float w_, float h_, String text)
	{
		super(x_, y_,w_ ,h_);
		
		label = new StaticText(text, FORMAT_NORMAL);
		subviews.add(label);
		
		this.text = text;
	}

	///////////////////////////////////////////////////////////////////////////////////////////////
	public void layout()
	{
		label.w =  w - 10;
		label.x = 5;
		label.y = 5;
		this.h = label.h + 15;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	public void drawContent()
	{
		noStroke();

		int contours = 12;
		for(int i = 0; i < contours; i++)
		{
			int alpha = 50 - (16 / contours) * (i * i);
			fill(0, 0, 0, alpha);
			stroke(0, 0, 0, alpha);
			strokeWeight(1);
			roundrect(-i, -i, (int)w + i * 2, (int)h + i * 2, 5);
			//triangle(0, (contours - i) * 2, arrowX - x, arrowY - y, 0, h - (contours - i) * 2);
		}
		
		fill(tooltipColor);
		stroke(0);
		triangle(0, contours, arrowX - x, arrowY - y, 0, h - contours);
		
		fill(255, 255, 255);
		roundrect(0, 0, (int)w, (int)h, 5);
	}
}
///////////////////////////////////////////////////////////////////////////////////////////////////
class View 
{
  float x, y, w, h;
  ArrayList subviews;
  boolean visible;
  
  View(float x_, float y_, float w_, float h_)
  {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    subviews = new ArrayList();
	visible = true;
  }
  
  public void draw()
  {
	if(visible)
	{
		layout();
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
  }
  
  public void layout()
  {
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
  
  public boolean keypressed()
  {
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
    PApplet.main(new String[] { "--bgcolor=#F5F5F5", "Prototype_1" });
  }
}
