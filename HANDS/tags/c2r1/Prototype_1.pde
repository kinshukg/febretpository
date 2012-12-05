//import controlP5.*;

///////////////////////////////////////////////////////////////////////////////////////////////////
// Global constants
static int SCREEN_WIDTH = 1400;
static int SCREEN_HEIGHT = 900;

static int POPUP_WIDTH = 400;

static String VERSION = "v3.0.0";	

static color STYLE_DELETED_ROW_BACK_COLOR = #888888;	

// Variables used to keep track of the prototype state
public boolean OPTION_NO_SUGGESTIONS = false;
public boolean OPTION_LONG_ALERT_BUTTON = true;
public boolean OPTION_EXPANDABLE_POPUP_TEXT = false;
public boolean OPTION_ALERT_INFO_BUTTON = false;
public boolean OPTION_ENABLE_POPUP_TEXT = true;
public boolean OPTION_ENABLE_ACTION_INFO_POPUP = false;
public boolean OPTION_TOOLTIP_AUTO_OPEN = false;
public boolean OPTION_GRAPH_IN_MAIN_POPUP = false;
public boolean OPTION_GRAPH_ALERT_BUTTON = false;
public int OPTION_NNN_ICON_STYLE = 1;
public int OPTION_NUMBER = 1;
public int CYCLE2_OPTION_NUMBER = 1;

// NNN definition images
public PImage IMG_IMP_GAS_EXC = null; 

///////////////////////////////////////////////////////////////////////////////////////////////////
// Message library
// Other text strings.
String DEF_ACUTE_PAIN = 
	"<b> Acute Pain: </b> \n " +
	"Unpleasant sensory and emotional experience arising from actual or potential tissue damage or described in terms of such damage (International Association for the Study of Pain); sudden or slow onset of any intensity from mild to severe with an anticipated or predictable end and a duration of less than 6 months";
String DEF_IMPAIRED_GAS_EXCHANGE =
	"<b> Impaired Gas Exchange: </b> \n " +
	"Excess or deficit in oxygenation and/or carbon dioxide elimination at the alveolar-capillary membrane";
String DEF_DEATH_ANXIETY =
	"<b> Death Anxiety: </b> \n " +
	"Vague uneasy feeling of discomfort or dread generated by perceptions of a real or imagined threat to one?s existence";
String DEF_ENERGY_CONSERVATION =
	"<b> Energy Conservation: </b> \n " +
	"Personal actions to manage energy for initiating and sustaining activity";
String DEF_COPING =
	"<b> Coping: </b> \n " +
	"Personal actions to manage stressors that tax an individuals resources";
String DEF_PATIENT_CONTROLLED_ANALGESIA =
	"<b> Patient Controlled Analgesia: </b> \n " +
	"Facilitating patient control of analgesic administration and regulation";
String DEF_POSITIONING =
	"<b> Positioning: </b> \n " +
	"Deliberative placement of the patient or a body part to promote physiological and-or psychological well-being";
String DEF_MASSAGE =
	"<b> Massage: </b> \n " +
	"Stimulation of the skin and underlying tissues with varying degrees of hand pressure to decrease pain, produce relaxation, and/or improve circulation";
String DEF_RELAXATION_THERAPY =
	"<b> Relaxation Therapy: </b> \n " +
	"Missing definition";
String DEF_GUIDED_IMAGERY =
	"<b> Guided Imagery: </b> \n " +
	"Purposeful use of imagination to achieve a particular state, outcome, or action or to direct attention away from undesirable sensations";

// Pain evidence message for popup screen.
String MSG_PAIN_EVIDENCE_POPUP = 			
	"Evidence Suggests That: <l> \n " +
	"- A combination of Medication Management, Positioning and Pain Management has the most positive impact on Pain Level. " + 
		"<*> <b> Add NIC Positioning. </b> <s1> \n " +
	"- It is more difficult to control pain when EOL patient has both Pain and Impaired Gas Exchange as problems. " + 
		"<*> <b> Prioritize pain and/or eliminate impaired gas exchange. </b> \n " +
	"- More than 50% of EOL patients do not achieve expected NOC Pain Level by discharge or death. " + 
		"<*> <b> Additional actions needed. </b> \n ";

// Message for info button next to pain graph
String MSG_PAIN_GRAPH_DESCRIPTION = "Graph shows actual Pain NOC levels during first 24hr and projected levels to 72 hours if current actions are continued.";

// Cycle 2: add family coping message on aciton bar
String MSG_ACTION_COPING = "Add family coping mini POC";	

// Cycle 2: add consultation message on aciton bar
String MSG_ACTION_CONSULTATION = "Add consultation";

// Cycle 2: NIC Consultation POC text
String NIC_CONSULTATION_TEXT = "Consultation: palliative care";

///////////////////////////////////////////////////////////////////////////////////////////////////
// Globl variables
public int prototypeState = 0;

public GradientUtils gu = new GradientUtils();

// Variables used got holding the different views
public View mainView;     // The Main View is the background of the window with all of the other widgets on top of it.

public TitleView titleView;
public PatientDataView nameView,dobView,genderView,allergiesView,codeStatusView,pocView,shftView,roomView,medicalDXView,mrView,physicianView,otherView;

public View popUpView;
public Tooltip tooltipView = null;

boolean filterKeyInput = false;

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
public PImage plusIcon, minusIcon, prioritizeIcon, starIcon, checkIcon, crossIcon;
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
public String other = "Sister to be called ANYTIME \n at patient's request \n 776-894-1010";

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
	
	starIcon = loadImage("star.png");
	checkIcon = loadImage("accept.png");
	checkIcon.resize(0, 22);
	crossIcon = loadImage("cross.png");
	crossIcon.resize(0, 22);
	
	IMG_IMP_GAS_EXC = loadImage("impairedgasExchange.png");
	
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
	
	anxietyLevelTrend = loadImage("anxietyLevelTrend.png");
	anxietyLevelTrend.resize(500, 0);
	anxietySelfControlTrend = loadImage("anxietySelfControlTrend2.png");
	anxietySelfControlTrend.resize(500, 0);
	painLevelTrend = loadImage("painLevelTrend.png");
	painLevelTrend.resize(500, 0);
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
	float cx = width - 390;
	float cy = titleView.h + 25;
	float cw = 200;
	float ch = 20;
	
	nameView = new PatientDataView(cx, cy, cw, ch, "Patient Name:", name);
	mainView.subviews.add(nameView);
	cy += 25;

	dobView = new PatientDataView(cx, cy, cw, ch, "DOB:",dob);
	mainView.subviews.add(dobView);
	cy += 25;

	genderView = new PatientDataView(cx, cy, cw, ch, "Gender:",gender);
	mainView.subviews.add(genderView);
	cy += 25;

	allergiesView = new PatientDataView(cx, cy, cw, ch, "Allergies:",allergies);
	mainView.subviews.add(allergiesView);
	cy += 25;

	codeStatusView = new PatientDataView(cx, cy, cw, ch, "Code Status:",codeStatus);
	mainView.subviews.add(codeStatusView);
	cy += 25;

	pocView = new PatientDataView(cx, cy, cw, ch, "POC Date:",poc);
	mainView.subviews.add(pocView);
	cy += 25;

	shftView = new PatientDataView(cx, cy, cw, ch, "Shift:",shft);
	mainView.subviews.add(shftView);
	cy += 25;

	roomView = new PatientDataView(cx, cy, cw, ch, "Room#:",room);
	mainView.subviews.add(roomView);
	cy += 25;

	medicalDXView = new PatientDataView(cx, cy, cw, ch, "Medical DX:",medicalDX);
	mainView.subviews.add(medicalDXView);
	cy += 25;

	mrView = new PatientDataView(cx, cy, cw, ch, "MR#:",mr);
	mainView.subviews.add(mrView);
	cy += 25;

	physicianView = new PatientDataView(cx, cy, cw, ch, "Physician:",physician);
	mainView.subviews.add(physicianView);
	cy += 45;

	otherView = new PatientDataView(cx, cy, cw, ch, "Other:","\n"+other);
	mainView.subviews.add(otherView);
	cy += 25;
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
	
	PainPopUpView ppw = new PainPopUpView(ppwidth, pocManager.painLevelView);
	ppw.reset();
	
	GraphPopUpView gp1 = new GraphPopUpView(500, pocManager.anxietyLevelView);
	gp1.reset(anxietyLevelTrend);

	GraphPopUpView gp2 = new GraphPopUpView(500, pocManager.anxietySelfControlView);
	gp2.reset(anxietySelfControlTrend);
	
	GraphPopUpView gp3 = new GraphPopUpView(500, pocManager.painLevelView);
	gp3.reset(painLevelTrend);

	PImage painLevelActionButtonImage = null;
	
	if(OPTION_GRAPH_IN_MAIN_POPUP)
	{
		if( OPTION_NUMBER != 3 &&  OPTION_NUMBER !=4)
		{
			int graphButtonX = 750;
			pocManager.anxietyLevelView.setGraphButton(2, smallGraph1, gp1, graphButtonX); 
			pocManager.anxietySelfControlView.setGraphButton(3, smallGraph2, gp2, graphButtonX); 
			painLevelActionButtonImage = smallGraph3;
			pocManager.painLevelView.actionPopUp = ppw;
		}
		else
		{
			int graphButtonX = 750;
			pocManager.anxietyLevelView.setGraphButton(2, smallGraph1, gp1, graphButtonX); 
			pocManager.anxietySelfControlView.setGraphButton(3, smallGraph2, gp2, graphButtonX); 
			graphButtonX = 750;
			painLevelActionButtonImage = smallGraph3;
			pocManager.painLevelView.actionPopUp = ppw;
		}
	}
	else
	{
		// Default
		int graphButtonX = 750;
		pocManager.painLevelView.actionPopUp = ppw;
		pocManager.anxietyLevelView.setGraphButton(2, smallGraph1, gp1, graphButtonX); 
		pocManager.anxietySelfControlView.setGraphButton(3, smallGraph2, gp2, graphButtonX); 
		pocManager.painLevelView.setGraphButton(3, smallGraph3, gp3, graphButtonX); 
	}

	// alert button position, used for inter-row button alignment
	int alertButtonX;
	if(OPTION_LONG_ALERT_BUTTON)
	{
		alertButtonX = 300;
		pocManager.painLevelView.setAlertButton(3, "Mrs. Taylor's Pain Level is not controlled.", alertButtonX, painLevelActionButtonImage);
	}
	else 
	{
		alertButtonX = 450;
		pocManager.painLevelView.setAlertButton(3, "Actions", alertButtonX, painLevelActionButtonImage);
		pocManager.painLevelView.message = "Mrs. Taylor's Pain Level is not controlled.";
	}
	
	if(OPTION_ALERT_INFO_BUTTON)
	{
		pocManager.painLevelView.setInfoButton(520, 
			"This requires action because analysis of similar patient's data shows: <l> \n " +
			"* It is difficult to control Pain in EOL patients who also have impaired Gas Exchange \n " + 
			"* >50% of EOL patients do not achieve expected NOC Pain Rating by discharge or death\n");
	}
	
	// Cycle 2 addition
	if(CYCLE2_OPTION_NUMBER == 1)
	{
		DeathPopUpView dppw = new DeathPopUpView(400, pocManager.anxietySelfControlView);
		dppw.setupConsultRefuse();
		pocManager.anxietySelfControlView.enableQuickActionButton1(300, 120, MSG_ACTION_CONSULTATION);
		pocManager.anxietySelfControlView.enableQuickActionButton2(470, 200, MSG_ACTION_COPING);
		pocManager.anxietySelfControlView.actionPopUp = dppw;
	}
	else if(CYCLE2_OPTION_NUMBER == 2)
	{
		DeathPopUpView dppw = new DeathPopUpView(400, pocManager.anxietySelfControlView);
		dppw.setupFull();
		pocManager.anxietySelfControlView.setAlertButton(3, "Action required", alertButtonX, null);
		pocManager.anxietySelfControlView.actionPopUp = dppw;
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
void mouseMoved()
{
	mainView.mouseMoved(mouseX, mouseY);
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
	if(!filterKeyInput || popUpView == null)
	{
		// if(key == '1')
		// {
			// OPTION_NO_SUGGESTIONS = false;
			// OPTION_LONG_ALERT_BUTTON = true;
			// OPTION_ALERT_INFO_BUTTON = false;
			// OPTION_EXPANDABLE_POPUP_TEXT = false;
			// OPTION_ENABLE_POPUP_TEXT = true;
			// OPTION_GRAPH_IN_MAIN_POPUP = false;
			// OPTION_ENABLE_ACTION_INFO_POPUP = false;
			// OPTION_GRAPH_ALERT_BUTTON = false;
			// OPTION_NUMBER = 1;
			// reset();
		// }
		// else if(key == '3')
		// {
			// OPTION_NO_SUGGESTIONS = false;
			// OPTION_LONG_ALERT_BUTTON = true;
			// OPTION_ALERT_INFO_BUTTON = false;
			// OPTION_EXPANDABLE_POPUP_TEXT = false;
			// OPTION_ENABLE_POPUP_TEXT = true;
			// OPTION_GRAPH_IN_MAIN_POPUP = true;
			// OPTION_ENABLE_ACTION_INFO_POPUP = false;
			// OPTION_GRAPH_ALERT_BUTTON = false;
			// OPTION_NUMBER = 3;
			// reset();
		// }
		if(key == '1')
		{
			OPTION_NO_SUGGESTIONS = false;
			OPTION_LONG_ALERT_BUTTON = false;
			OPTION_EXPANDABLE_POPUP_TEXT = false;
			OPTION_ENABLE_POPUP_TEXT = false;
			OPTION_ALERT_INFO_BUTTON = true;
			OPTION_ENABLE_ACTION_INFO_POPUP = true;
			OPTION_GRAPH_IN_MAIN_POPUP = false;
			OPTION_GRAPH_ALERT_BUTTON = false;
			OPTION_NUMBER = 2;
			CYCLE2_OPTION_NUMBER = 1;
			reset();
		}
		else if(key == '2')
		{
			OPTION_NO_SUGGESTIONS = false;
			OPTION_LONG_ALERT_BUTTON = true;
			OPTION_ALERT_INFO_BUTTON = false;
			OPTION_EXPANDABLE_POPUP_TEXT = false;
			OPTION_ENABLE_POPUP_TEXT = true;
			OPTION_ENABLE_ACTION_INFO_POPUP = false;
			OPTION_GRAPH_IN_MAIN_POPUP = true;
			OPTION_GRAPH_ALERT_BUTTON = true;
			OPTION_NUMBER = 4;
			CYCLE2_OPTION_NUMBER = 1;
			reset();
		}
		if(key == '3')
		{
			OPTION_NO_SUGGESTIONS = false;
			OPTION_LONG_ALERT_BUTTON = false;
			OPTION_EXPANDABLE_POPUP_TEXT = false;
			OPTION_ENABLE_POPUP_TEXT = false;
			OPTION_ALERT_INFO_BUTTON = true;
			OPTION_ENABLE_ACTION_INFO_POPUP = true;
			OPTION_GRAPH_IN_MAIN_POPUP = false;
			OPTION_GRAPH_ALERT_BUTTON = false;
			OPTION_NUMBER = 2;
			CYCLE2_OPTION_NUMBER = 2;
			reset();
		}
		else if(key == '4')
		{
			OPTION_NO_SUGGESTIONS = false;
			OPTION_LONG_ALERT_BUTTON = true;
			OPTION_ALERT_INFO_BUTTON = false;
			OPTION_EXPANDABLE_POPUP_TEXT = false;
			OPTION_ENABLE_POPUP_TEXT = true;
			OPTION_ENABLE_ACTION_INFO_POPUP = false;
			OPTION_GRAPH_IN_MAIN_POPUP = true;
			OPTION_GRAPH_ALERT_BUTTON = true;
			OPTION_NUMBER = 4;
			CYCLE2_OPTION_NUMBER = 2;
			reset();
		}
		else if(key == '0')
		{
			saveFrame("HANDS-"+VERSION+"-####.png");
		}
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

