///////////////////////////////////////////////////////////////////////////////////////////////////
static int SCREEN_WIDTH = 1400;
static int SCREEN_HEIGHT = 900;

static int POPUP_WIDTH = 400;

static int FORMAT_HEADING1 = 1;
static int FORMAT_NORMAL = 2;	
static int FORMAT_SUBTEXT = 3;	

static String VERSION = "v1.0";	

static color STYLE_DELETED_ROW_BACK_COLOR = #bbbbbb;	

// Variables used to keep track of the prototype state
public boolean OPTION_NO_SUGGESTIONS = false;
public boolean OPTION_LONG_ALERT_BUTTON = true;
public boolean OPTION_EXPANDABLE_POPUP_TEXT = false;
public boolean OPTION_ALERT_INFO_BUTTON = false;
public boolean OPTION_ENABLE_POPUP_TEXT = true;
public boolean OPTION_ENABLE_ACTION_INFO_POPUP = false;
public boolean OPTION_TOOLTIP_AUTO_OPEN = false;
public boolean OPTION_GRAPH_IN_MAIN_POPUP = false;
public int OPTION_NNN_ICON_STYLE = 0;

public int prototypeState = 0;

public GradientUtils gu = new GradientUtils();

// Variables used got holding the different views
public View mainView;     // The Main View is the background of the window with all of the other widgets on top of it.

public TitleView titleView;
public PatientDataView nameView,dobView,genderView,allergiesView,codeStatusView,pocView,shftView,roomView,medicalDXView,mrView,physicianView,otherView;

//public ClosePopUpView closePopUpView;
public View popUpView;
public Tooltip tooltipView = null;


POCManager pocManager;

// Variables used for Font Control
public PFont font,fbold; 

// Variables used for colours
public color backgroundColor = 255;
public color titleBackgroundColor = #6495ED;
public color titleColor = #FF8C00 ;
public color subtitleColor = 255;
public color colouredRowColor = #C6E2FF;
public color secondLevelRowColor = 255;
public color thirdLevelRowColor = 255;
public color closePopUpColor = #5E5E5E;
public color rationaleBarColor = #D4D4D4;
public color rationaleColor = 0;
public color buttonSelectedColor = 200;
public color buttonNotColor = #4682B4;
public color popUpSectionColor = #FFF68F;
public color alertHighColor = #FF3333;
public color alertMidColor = #FCF112;
public color alertLowColor = #AAFF50;
public color tooltipColor = #FFFFFF;

// Variables holding Image names
public String handIconString = "Red_Handprint__right_orange.png";
public String plusIconString = "add.png";
public String minusIconString = "delete.png";

// Variables holding Images
public PImage handIcon,firstLevelIcon,secondLevelIcon,thirdLevelIcon;
public PImage firstLevelIconLegend, secondLevelIconLegend,thirdLevelIconLegend;
public PImage plusIcon, minusIcon, prioritizeIcon;
public PImage infoIcon;

public PImage smallGraph1;
public PImage smallGraph2;
public PImage smallGraph3;

public PImage anxietyLevelTrend;
public PImage anxietySelfControlTrend;
public PImage painLevelTrend;

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
	frameRate(20);
	smooth();

	//Load fonts.
	//font = loadFont("SegoeUI-14.vlw");
	font = createFont("Verdana", 12);
	//fbold = loadFont("SegoeUI-Bold-14.vlw");
	fbold = createFont("Verdana Bold", 12);
	textFont(font);

	// Load image assets.
	handIcon = loadImage(handIconString);
	handIcon.resize(0,25);

	plusIcon = loadImage(plusIconString);
	plusIcon.resize(0,15);
 
	minusIcon = loadImage(minusIconString);
	minusIcon.resize(0,15);

	prioritizeIcon = loadImage("arrow_up.png");
	prioritizeIcon.resize(0,15);
	
	infoIcon = loadImage("information.png");
	infoIcon.resize(0, 22);
	smallGraph1 = loadImage("SmallGraph1.png");
	smallGraph2 = loadImage("SmallGraph2.png");
	smallGraph3 = loadImage("SmallGraph3.png");
	smallGraph1.resize(0, 15);
	smallGraph2.resize(0, 15);
	smallGraph3.resize(0, 15);
	
	anxietyLevelTrend = loadImage("anxietyLevelTrend.png");
	anxietyLevelTrend.resize(450, 0);
	anxietySelfControlTrend = loadImage("anxietySelfControlTrend.png");
	anxietySelfControlTrend.resize(450, 0);
	painLevelTrend = loadImage("painLevelTrend.png");
	painLevelTrend.resize(450, 0);
	
	reset();
}

///////////////////////////////////////////////////////////////////////////////////////////////////
void loadNNNIcons()
{
	if(OPTION_NNN_ICON_STYLE == 0)
	{
		firstLevelIcon = loadImage("black_square.png");
		secondLevelIcon  = loadImage("black_circle.png");
		thirdLevelIcon = loadImage("black_triangle.png");

		firstLevelIconLegend = loadImage("black_square.png");
		secondLevelIconLegend  = loadImage("black_circle.png");
		thirdLevelIconLegend = loadImage("black_triangle.png");
		firstLevelIconLegend.resize(0,25);
		secondLevelIconLegend.resize(0,25);
		thirdLevelIconLegend.resize(0,25);
	}
	else if(OPTION_NNN_ICON_STYLE == 1)
	{
		firstLevelIcon = loadImage("NANDA.png");
		secondLevelIcon  = loadImage("NOC.png");
		thirdLevelIcon = loadImage("NIC.png");

		firstLevelIconLegend = loadImage("NANDA.png");
		secondLevelIconLegend  = loadImage("NOC.png");
		thirdLevelIconLegend = loadImage("NIC.png");
		firstLevelIconLegend.resize(0,25);
		secondLevelIconLegend.resize(0,25);
		thirdLevelIconLegend.resize(0,25);
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
void reset()
{
	popUpView = null;
	
	loadNNNIcons();
	
	// Views created
	mainView = new View(0, 0, width, height);

	titleView = new TitleView(0,0,width,handIcon,"HANDS","- Hands-On Automated Nursing Data System",titleBackgroundColor, titleColor,subtitleColor);
	mainView.subviews.add(titleView); 

	setupPatientInfoView();
	setupPOCView();
	
	if(!OPTION_NO_SUGGESTIONS) setupPopup();
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
	int ppwidth = 570;
	if(OPTION_GRAPH_IN_MAIN_POPUP) ppwidth = 705;
	if(OPTION_ALERT_INFO_BUTTON) ppwidth = 400;
	
	PopUpView ppw = new PopUpView(ppwidth, pocManager.painLevelView);
	ppw.reset();
	
	GraphPopUpView gp1 = new GraphPopUpView(500, pocManager.anxietyLevelView);
	gp1.reset(anxietyLevelTrend);

	GraphPopUpView gp2 = new GraphPopUpView(500, pocManager.anxietySelfControlView);
	gp2.reset(anxietySelfControlTrend);
	
	GraphPopUpView gp3 = new GraphPopUpView(500, pocManager.painLevelView);
	gp3.reset(painLevelTrend);

	if(OPTION_GRAPH_IN_MAIN_POPUP)
	{
		int graphButtonX = 250;
		pocManager.anxietyLevelView.setGraphButton(2, smallGraph1, gp1, graphButtonX); 
		pocManager.anxietySelfControlView.setGraphButton(1, smallGraph2, gp2, graphButtonX); 
		pocManager.painLevelView.setAlertButton(3, ppw, smallGraph3); 
	}
	else
	{
		int graphButtonX = 550;
		pocManager.painLevelView.setAlertButton(3, ppw, null);
		pocManager.anxietyLevelView.setGraphButton(2, smallGraph1, gp1, graphButtonX); 
		pocManager.anxietySelfControlView.setGraphButton(1, smallGraph2, gp2, graphButtonX); 
		pocManager.painLevelView.setGraphButton(3, smallGraph3, gp3, graphButtonX); 
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
public void draw()
{
	background(backgroundColor); 
	// Draw static view elements
	drawStaticViewElements();

	mainView.draw();
	
	if(tooltipView != null)
	{
		tooltipView.draw();
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
void drawStaticViewElements()
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
void mouseReleased()
{
	if(popUpView != null)
	{
		if(popUpView.moving) popUpView.moving = false;
	}
	mainView.mouseReleased(mouseX, mouseY);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
void mouseDragged()
{
	if(popUpView != null)
	{
		if(popUpView.moving)
		{
			popUpView.x = mouseX + popUpView.dragX;
			popUpView.y = mouseY + popUpView.dragY;
		}
	}
	mainView.mouseMoved(mouseX, mouseY);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
void mousePressed()
{
	mainView.mousePressed(mouseX, mouseY);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
void mouseClicked()
{
	// Kinda hack: if a tooltip window is enabled, a click closes it regardless of where the user clicks.
	if(tooltipView != null)
	{
		tooltipView = null;
		return;
	}
	
	mainView.mouseClicked(mouseX, mouseY);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
void keyPressed() 
{
	if(key == '1')
	{
		OPTION_NO_SUGGESTIONS = false;
		OPTION_LONG_ALERT_BUTTON = true;
		OPTION_ALERT_INFO_BUTTON = false;
		OPTION_EXPANDABLE_POPUP_TEXT = false;
		OPTION_ENABLE_POPUP_TEXT = true;
		OPTION_GRAPH_IN_MAIN_POPUP = false;
		OPTION_ENABLE_ACTION_INFO_POPUP = false;
		reset();
	}
	else if(key == '2')
	{
		OPTION_NO_SUGGESTIONS = false;
		OPTION_LONG_ALERT_BUTTON = false;
		OPTION_EXPANDABLE_POPUP_TEXT = false;
		OPTION_ENABLE_POPUP_TEXT = false;
		OPTION_ALERT_INFO_BUTTON = true;
		OPTION_ENABLE_ACTION_INFO_POPUP = true;
		OPTION_GRAPH_IN_MAIN_POPUP = false;
		reset();
	}
	else if(key == '3')
	{
		OPTION_NO_SUGGESTIONS = false;
		OPTION_LONG_ALERT_BUTTON = true;
		OPTION_ALERT_INFO_BUTTON = false;
		OPTION_EXPANDABLE_POPUP_TEXT = true;
		OPTION_ENABLE_POPUP_TEXT = true;
		OPTION_GRAPH_IN_MAIN_POPUP = true;
		reset();
	}
	else if(key == '4')
	{
		OPTION_NO_SUGGESTIONS = true;
		reset();
	}
	else if(key == '6')
	{
		OPTION_NNN_ICON_STYLE = 0;
		reset();
	}
	else if(key == '5')
	{
		OPTION_NNN_ICON_STYLE = 1;
		reset();
	}
	else if(key == '0')
	{
		saveFrame("HANDS-"+VERSION+"-####.png");
	}

	mainView.keypressed();
}

///////////////////////////////////////////////////////////////////////////////////////////////////
void roundrect(int x, int y, int w, int h, int r) 
{
    noStroke();
    rectMode(CORNER);

    int  ax, ay, hr;

    ax=x+w-1;
    ay=y+h-1;
    hr = r/2;

    rect(x, y, w, h);
    arc(x, y, r, r, radians(180.0), radians(270.0));
    arc(ax, y, r, r, radians(270.0), radians(360.0));
    arc(x, ay, r, r, radians(90.0), radians(180.0));
    arc(ax, ay, r, r, radians(0.0), radians(90.0));
    rect(x, y-hr, w, hr);
    rect(x-hr, y, hr, h);
    rect(x, y+h, w, hr);
    rect(x+w, y, hr, h);

    rectMode(CORNERS);
}

