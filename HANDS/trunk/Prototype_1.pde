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
public boolean OPTION_LONG_ALERT_BUTTON = false;
public boolean OPTION_EXPANDABLE_POPUP_TEXT = false;
public boolean OPTION_ALERT_INFO_BUTTON = false;

public int prototypeState = 0;

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
public color alertMidColor = #DAA520;
public color alertLowColor = #CAFF70;
public color tooltipColor = #FFFFFF;

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
	
	reset();
}

///////////////////////////////////////////////////////////////////////////////////////////////////
void reset()
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
void drawStaticViewElements()
{
	int footerY = pocManager.getBottom() + 10;
	
	textSize(14);
	image(firstLevelIconLegend, 20, footerY + 10);
	text("NANDA-I", 60, footerY + 20);
	image(secondLevelIconLegend, 20, footerY + 45);
	text("NOC", 60, footerY + 55);
	image(thirdLevelIconLegend, 20, footerY + 80);
	text("NIC", 60, footerY + 90);
	
	textSize(12);
	text("Nurse's Signature: _________________________", 20, footerY + 125);
	text("Printed on: 09/18/2010 02:28:08", 700, footerY + 125);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
void mouseClicked()
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
								pocManager.addNIC(c.t, popUpView.parent);
							}
							if(c.icon1.equals(plusIcon) && c.type.equals("NOC"))
							{
								pocManager.addNOC(c.t, popUpView.parent.parent);
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
void keyPressed() 
{
	if(key == '1')
	{
		OPTION_LONG_ALERT_BUTTON = true;
		OPTION_ALERT_INFO_BUTTON = false;
		OPTION_EXPANDABLE_POPUP_TEXT = true;
		reset();
	}
	else if(key == '2')
	{
		OPTION_LONG_ALERT_BUTTON = false;
		OPTION_EXPANDABLE_POPUP_TEXT = false;
		OPTION_ALERT_INFO_BUTTON = true;
		reset();
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

