///////////////////////////////////////////////////////////////////////////////////////////////////
// Global constants
static int SCREEN_WIDTH = 1400;
static int SCREEN_HEIGHT = 1000;

static int POPUP_WIDTH = 400;

static String VERSION = "cxr1";	

static color STYLE_DELETED_ROW_BACK_COLOR = #888888;	

// Variables used to keep track of the prototype state
public boolean OPTION_NATIVE = true;

public PImage IMG_LEGEND = null; 

// NNN definition images
public PImage IMG_PLACEHOLDER = null; 

///////////////////////////////////////////////////////////////////////////////////////////////////
// Message library
String MSG_PAIN_OUTCOME = "</b> All pain can be relieved, however achieving pain control within the first 24 hours is critical to achieving pain goals throughout the hospitalization. <l> \n " +
	"<bl> Simple interventions control pain for <b> 90% </b> of EOL patients. \n " +
	"<bl> Palliative care and aggressive interventions are needed for the remaining <b> 10%. </b>";
	
// For the i icon related to Mini POC for Family Coping
String MSG_FAMILY_COPING =
	"The physical and emotional demands of care giving can overwhelm the family.";
	
// For the i icon related Immobility Consequences
String MSG_IMMOBILITY_CONSEQUENCES_GENERIC = "Consequences of immobility include pneumonia, pressure ulcers, contractures, constipation, and venous thrombosis.";

// Message for info button next to pain graph
String MSG_PAIN_GRAPH_DESCRIPTION = 
	"Graph shows <b> actual Pain NOC levels </b> during first 24hr and projected levels to 72 hours if current actions are continued.";

// Message for info button next to death anxiety graph
String MSG_DEATH_GRAPH_DESCRIPTION = 
	"Graph shows <b> actual Comfortable Death NOC levels </b> during first 24hr and projected levels to 72 hours if current actions are continued.";
	
// Cycle 2: add family coping message on aciton bar
String MSG_ACTION_COPING = "Add <nanda> Interrupted Family Process mini POC";	

// Cycle 2: add consultation message on aciton bar
String MSG_ACTION_CONSULTATION = "Add <nic> Consultation: palliative care";

// Cycle 2: NIC Consultation POC text
String NIC_CONSULTATION_TEXT = "Consultation: Palliative Care";

// Cycle 3: add immobility consequences msg on action bar.
String MSG_ACTION_IMMOBILITY_CONSEQUENCES = "Add <noc> Immobility Consequences";

int ADD_NIC = 0;
int ADD_NOC = 1;
int REMOVE_NANDA = 2;
int PRIORITIZE_NANDA = 3;
int ADD_NANDA = 4;

////////////////////////////////////////////////////////////////////////////////
// SETTINGS
// CDS Type: 
//   0 = None (Native) 
//   1 = Text only
//   2 = Graph
//   3 = Table
int OPTION_CDS_TYPE = 0;
int USER_ID = 0;

////////////////////////////////////////////////////////////////////////////////
// Globl variables
public int prototypeState = 0;

public GradientUtils gu = new GradientUtils();

// Variables used got holding the different views
public View mainView;     // The Main View is the background of the window with all of the other widgets on top of it.
Button addNANDAButton; 
Button endShiftButton;
Button nextPatientButton;
Button prevPatientButton;

public TitleView titleView;
public PatientDataView nameView,dobView,genderView,allergiesView,codeStatusView,pocView,shftView,roomView,medicalDXView,mrView,physicianView,otherView,patientIndexView;

public View popUpView;
public Tooltip tooltipView = null;
public TextBox activeTextBox = null;

boolean filterKeyInput = false;

float helpTextFade;
String currentHelpText;

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
public PImage plusIcon, minusIcon, prioritizeIcon, starIcon, checkIcon, crossIcon, bulletIcon;
public PImage infoIcon;
public PImage IMG_EBI;
public PImage IMG_SUGGESTION;
public PImage IMG_TUTORIAL;
// Images related to trend plot
public PImage IMG_PLOT_BASE;
public PImage IMG_RED_DOT;
public PImage IMG_GREEN_DOT;
public PImage IMG_BLACK_DOT;
public PImage IMG_NOW_MARKER;

public PImage emptySmallGraph;
public PImage smallGraph1;
public PImage smallGraph2;
public PImage smallGraph3;

public PImage anxietyLevelTrend;
public PImage anxietySelfControlTrend;
public PImage emptyTrend;

////////////////////////////////////////////////////////////////////////////////
// Cycle 4: List of patients (substitutes POCManager instance, now there is one POCManager
// instance per patient)
Patient patient1;
Patient patient2;
int curPatientStartMillis;
Patient curPatient;
int currentShift = 0;
// When set to true, display a black screen between shifts.
boolean shiftIntermission = false;
int endShiftScreenshot = -1;

// This table will store the plan of care for all patients and all shifts of this
// user.
Table poclog;
Table actlog;

////////////////////////////////////////////////////////////////////////////////
public void setup()
{
    poclog = new Table();
    poclog.addColumn("UserID");
    poclog.addColumn("CDS");
    poclog.addColumn("Shift");
    poclog.addColumn("PatientID");
    poclog.addColumn("Name");
    poclog.addColumn("Parent");
    poclog.addColumn("ExpectedRating");
    poclog.addColumn("Value");
    poclog.addColumn("Version");
    
    actlog = new Table();
    actlog.addColumn("UserID");
    actlog.addColumn("CDS");
    actlog.addColumn("Shift");
    actlog.addColumn("PatientID");
    actlog.addColumn("Time");
    actlog.addColumn("Log");
    poclog.addColumn("Version");
    
    // Load config
    JSONObject json;
    json = loadJSONObject("config.cfg");
    OPTION_CDS_TYPE = json.getInt("cds");
    USER_ID = json.getInt("user-id");
    
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
	plusIcon.resize(0,16);
 
	minusIcon = loadImage(minusIconString);
	minusIcon.resize(0,15);

	prioritizeIcon = loadImage("arrow_up.png");
	prioritizeIcon.resize(0,16);
	
	IMG_LEGEND = loadImage("legend.png");
	//IMG_LEGEND.resize(0,350);
	
	infoIcon = loadImage("information.png");
	//infoIcon.resize(0, 22);
	IMG_EBI = loadImage("information.png");
	//IMG_EBI.resize(0, 22);
	IMG_SUGGESTION = loadImage("suggestion.png");
	//IMG_SUGGESTION.resize(0, 22);
	IMG_TUTORIAL = loadImage("tutorial.png");
	//IMG_TUTORIAL.resize(0, 22);
    
    IMG_PLOT_BASE = loadImage("plotBase.PNG");
    IMG_RED_DOT = loadImage("redDot.png");
    IMG_GREEN_DOT = loadImage("greenDot.png");
    IMG_BLACK_DOT = loadImage("blackDot.png");
    IMG_NOW_MARKER = loadImage("nowMarker.png");
	
	emptySmallGraph = loadImage("emptySmallGraph.png");
	smallGraph1 = loadImage("SmallGraph1.png");
	smallGraph2 = loadImage("SmallGraph2.png");
	smallGraph3 = loadImage("SmallGraph3.png");
	smallGraph1.resize(0, 15);
	smallGraph2.resize(0, 15);
	smallGraph3.resize(0, 15);
	emptySmallGraph.resize(0, 15);
	
	bulletIcon = loadImage("bullet.png");
	starIcon = loadImage("star.png");
	checkIcon = loadImage("accept.png");
	checkIcon.resize(0, 22);
	crossIcon = loadImage("cross.png");
	crossIcon.resize(0, 16);
	
	IMG_PLACEHOLDER = loadImage("tooltipPlaceholder.PNG");
    
	frame.setTitle("Prototype No Suggestions");
	reset();
}

////////////////////////////////////////////////////////////////////////////////
void loadNNNIcons()
{
    firstLevelIcon = loadImage("NANDA.png");
    secondLevelIcon  = loadImage("NOC.png");
    thirdLevelIcon = loadImage("NIC.png");
    firstLevelIcon.resize(0,15);
    secondLevelIcon.resize(0,15);
    thirdLevelIcon.resize(0,15);

    firstLevelIconLegend = loadImage("NANDA.png");
    secondLevelIconLegend  = loadImage("NOC.png");
    thirdLevelIconLegend = loadImage("NIC.png");
    firstLevelIconLegend.resize(0,32);
    secondLevelIconLegend.resize(0,32);
    thirdLevelIconLegend.resize(0,32);
	
	anxietyLevelTrend = loadImage("anxietyLevelTrend.png");
	anxietyLevelTrend.resize(500, 0);
	anxietySelfControlTrend = loadImage("anxietySelfControlTrend2.png");
	anxietySelfControlTrend.resize(500, 0);
	emptyTrend = loadImage("emptyTrend.png");
	emptyTrend.resize(500, 0);
}

////////////////////////////////////////////////////////////////////////////////
void reset()
{
	popUpView = null;
	tooltipView = null;
	
	loadNNNIcons();
	
	// Views created
	mainView = new View(0, 0, width, height);
    addNANDAButton = new Button(10, 40, 126, 20, "Add NANDA", color(100,149,237), color(0));
    mainView.subviews.add(addNANDAButton);

	titleView = new TitleView(0,0,width,handIcon,"HANDS","- Hands-On Automated Nursing Data System",titleBackgroundColor, titleColor,subtitleColor);
	mainView.subviews.add(titleView); 

    endShiftButton = new Button(1025, 860, 340, 120, "LOG OFF", color(200,200,200), color(0));
	mainView.subviews.add(endShiftButton); 
    
    prevPatientButton = new Button(1040, 780, 54, 54, "Prev.", color(200,200,200), color(0));
	mainView.subviews.add(prevPatientButton); 
    nextPatientButton = new Button(1280, 780, 54, 54, "Next", color(200,200,200), color(0));
	mainView.subviews.add(nextPatientButton); 
    
	setupPatientInfoView();
	setupPatients();
}

////////////////////////////////////////////////////////////////////////////////
public void setupPatientInfoView()
{
	float cx = width - 380;
	float cy = titleView.h + 25;
	float cw = 200;
	float ch = 20;
	
	nameView = new PatientDataView(cx, cy, cw, ch, "Patient Name:");
	mainView.subviews.add(nameView);
	cy += 25;

	dobView = new PatientDataView(cx, cy, cw, ch, "DOB:");
	mainView.subviews.add(dobView);
	cy += 25;

	genderView = new PatientDataView(cx, cy, cw, ch, "Gender:");
	mainView.subviews.add(genderView);
	cy += 25;

	allergiesView = new PatientDataView(cx, cy, cw, ch, "Allergies:");
	mainView.subviews.add(allergiesView);
	cy += 25;

	codeStatusView = new PatientDataView(cx, cy, cw, ch, "Code Status:");
	mainView.subviews.add(codeStatusView);
	cy += 25;

	pocView = new PatientDataView(cx, cy, cw, ch, "POC Date:");
	mainView.subviews.add(pocView);
	cy += 25;

	shftView = new PatientDataView(cx, cy, cw, ch, "Shift:");
	mainView.subviews.add(shftView);
	cy += 25;

	roomView = new PatientDataView(cx, cy, cw, ch, "Room#:");
	mainView.subviews.add(roomView);
	cy += 25;

	medicalDXView = new PatientDataView(cx, cy, cw, ch, "Medical DX:");
	mainView.subviews.add(medicalDXView);
	cy += 25;
    
	mrView = new PatientDataView(cx, cy, cw, ch, "MR#:");
	mainView.subviews.add(mrView);
	cy += 25;

	physicianView = new PatientDataView(cx, cy, cw, ch, "Physician:");
	mainView.subviews.add(physicianView);
	cy += 45;

	otherView = new PatientDataView(cx, cy, cw, ch, "Other:");
	mainView.subviews.add(otherView);
	cy += 25;

	patientIndexView = new PatientDataView(1100, 790, 100, 54, "Current Patient:");
	mainView.subviews.add(patientIndexView);
    patientIndexView.entry = "1 of 2";
}

////////////////////////////////////////////////////////////////////////////////
public void nextShift()
{
    currentShift++;
    if(currentShift == 1)
    {
        // update POC dates.
        patient1.poc = "03/24/2013";
    }
    if(currentShift == 2)
    {
        // update POC dates.
        patient1.poc = "03/25/2013";
    }
    else if(currentShift == 3)
    {
        // update POC dates.
        patient1.poc = "03/26/2013";
    }
    
    updatePatientStatus(patient1);
    updatePatientStatus(patient2);
    
    // When switching to another shift, always go back to patient 1.
    setActivePatient(patient1);
    patientIndexView.entry = "1 of 2";
    
    patient1.time = 0;
    patient2.time = 0;
    curPatientStartMillis = millis();
}

////////////////////////////////////////////////////////////////////////////////
public void setActivePatient(Patient p)
{
    // Log time spent on previous patient.
    if(curPatient != null)
    {
        curPatient.time += (millis() - curPatientStartMillis) / 1000;
    }
    // Hide all patients
    patient1.hide();
    patient2.hide();
    
    curPatientStartMillis = millis();
    curPatient = p;
    curPatient.show();
    
    // Update demographic information
	nameView.entry = curPatient.name;
	dobView.entry = curPatient.dob;
	genderView.entry = curPatient.gender;
	allergiesView.entry = curPatient.allergies;
	codeStatusView.entry = curPatient.codeStatus;
	pocView.entry = curPatient.poc;
	shftView.entry = curPatient.shft;
	roomView.entry = curPatient.room;
	medicalDXView.entry = curPatient.medicalDX;
	mrView.entry = curPatient.mr;
	physicianView.entry = curPatient.physician;
	otherView.entry = "\n" + curPatient.other;
}

////////////////////////////////////////////////////////////////////////////////
public void log(String msg)
{
    TableRow log = actlog.addRow();
    setLogRowKeys(log, curPatient);
    int time = curPatient.time + (millis() - curPatientStartMillis) / 1000;

    log.setInt("Time", time);
    log.setString("Log", msg);
}

////////////////////////////////////////////////////////////////////////////////
public void setLogRowKeys(TableRow row, Patient pt)
{
    row.setInt("UserID", USER_ID);
    row.setInt("CDS", OPTION_CDS_TYPE);
    row.setInt("Shift", currentShift);
    row.setInt("PatientID", pt.id);
    row.setString("Version", VERSION);
}

////////////////////////////////////////////////////////////////////////////////
public void logPatientPOC(Patient pt)
{
    TableRow row;
    row = poclog.addRow();
    setLogRowKeys(row, pt);
    row.setString("Name", "TIME");
    row.setInt("Value", pt.time);
    
    // Add data for this patient to the POC log.
    ArrayList poc = pt.pocManager.scrollingView.subs;
    for (int i = 0; i < poc.size();i++ ) 
    {
        ColouredRowView tempRow = (ColouredRowView)poc.get(i);
        if(!tempRow.deleted)
        {
            row = poclog.addRow();
            setLogRowKeys(row, pt);
            row.setString("Name", tempRow.title);
            row.setString("Parent", "Root");
            
            for (int j = 0; j < tempRow.subs.size(); j++ ) 
            {
                SecondLevelRowView tempRow2 = (SecondLevelRowView) tempRow.subs.get(j);
                row = poclog.addRow();
                setLogRowKeys(row, pt);
                row.setString("Name", tempRow2.title);
                row.setString("Parent", tempRow.title);
                row.setString("Value", str(tempRow2.firstColumn) + "_" + str(tempRow2.secondColumn));
                
                for (int k = 0; k < tempRow2.subs.size(); k++ ) 
                {
                    ThirdLevelRowView tempRow3 = (ThirdLevelRowView) tempRow2.subs.get(k);
                    row = poclog.addRow();
                    setLogRowKeys(row, pt);
                    row.setString("Name", tempRow3.title);
                    row.setString("Parent", tempRow2.title);
                }
            }
        }
    }
}

////////////////////////////////////////////////////////////////////////////////
public void savePOC()
{
    logPatientPOC(patient1);
    logPatientPOC(patient2);
    saveTable(poclog, "UID" + str(USER_ID) + "-POC.csv");
    saveTable(actlog, "UID" + str(USER_ID) + "-LOG.csv");
}

////////////////////////////////////////////////////////////////////////////////
public void draw()
{
    // Do we need to show the intermission screen betwen shifts?
    if(shiftIntermission)
    {
        if(endShiftScreenshot == 0)
        {
            savePOC();
            // Take screenshot of first patient
            setActivePatient(patient1);
        }
        else if(endShiftScreenshot == 1)
        {
            // Take screenshot of second patient
            setActivePatient(patient2);
        }
        else
        {
            // Done with screenshots
            background(0); 
            fill(255);
            textFont(font);
            textSize(24);
            text("Press 6 To Confirm Shift END and Continue To Next Shift",10,10);
            text("Press 5 To GO BACK To this Shift",10,40);
            return;
        }
    }
    
	background(backgroundColor); 
	// Draw static view elements
	drawStaticViewElements();

	mainView.draw();
	
    // Do we need to show the intermission screen betwen shifts?
    if(shiftIntermission)
    {
        if(endShiftScreenshot == 0)
        {
			saveFrame("UID"+str(USER_ID)+"-CDS" + str(OPTION_CDS_TYPE) + "-SHFT" + str(currentShift) + "-PT" + str(curPatient.id) + ".png");
            endShiftScreenshot = 1;
        }
        else if(endShiftScreenshot == 1)
        {
			saveFrame("UID"+str(USER_ID)+"-CDS" + str(OPTION_CDS_TYPE) + "-SHFT" + str(currentShift) + "-PT" + str(curPatient.id) + ".png");
            endShiftScreenshot = 2;
        }
    }
    
	if(tooltipView != null)
	{
		tooltipView.draw();
	}
	if(helpTextFade > 0 && currentHelpText != null)
	{
		float helpTextX = mouseX + 10;
		float helpTextY = mouseY + 20;
		float helpTextHeight = 20;
		float helpTextWidth = textWidth(currentHelpText);
		
		noStroke();
		
		int contours = 4;
		for(int i = 0; i < contours; i++)
		{
			int alpha = 50 - (16 / contours) * (i * i);
			fill(0, 0, 0, alpha);
			stroke(0, 0, 0, alpha);
			strokeWeight(1);
			roundrect((int)helpTextX-i, (int)helpTextY-i, (int)helpTextWidth + i * 2, (int)helpTextHeight + i * 2, 5);
		}

		fill(#FFFCE5);
		roundrect((int)helpTextX, (int)helpTextY, (int)helpTextWidth, (int)helpTextHeight, 5);
		
		textFont(font);
		fill(0);
		text(currentHelpText, helpTextX, helpTextY + 8);
	}
}

////////////////////////////////////////////////////////////////////////////////
void drawStaticViewElements()
{
	int footerY = 500;
	int footerX = 1020;
	//if(!OPTION_NATIVE) image(IMG_LEGEND, footerX, footerY + 10);
    image(IMG_LEGEND, footerX, footerY + 10);
}

////////////////////////////////////////////////////////////////////////////////
void mouseReleased()
{
	// Kinda hack: if a tooltip window is enabled, a click closes it regardless of where the user clicks.
	if(tooltipView != null)
	{
		tooltipView = null;
		return;
	}
	
	mainView.mouseClicked(mouseX, mouseY);
    if(addNANDAButton.selected)
    {
        addNANDAButton.selected = false;
        if(curPatient.pocManager.NANDAPopup != null && popUpView == null)
        {
            log("OpenNativeNANDAPopup");
            curPatient.pocManager.NANDAPopup.show();
        }
    }

    if(endShiftButton.selected)
    {
        endShiftButton.selected = false;
        shiftIntermission = true;
        endShiftScreenshot = 0;
        
        // Save time for current patient.
        curPatient.time += (millis() - curPatientStartMillis) / 1000;
    }
    if(nextPatientButton.selected)
    {
        nextPatientButton.selected = false;
        if(curPatient == patient1)
        {
            setActivePatient(patient2);
            patientIndexView.entry = "2 of 2";
        }
    }
    if(prevPatientButton.selected)
    {
        prevPatientButton.selected = false;
        if(curPatient == patient2)
        {
            setActivePatient(patient1);
            patientIndexView.entry = "1 of 2";
        }
    }
        
	if(popUpView != null)
	{
		if(popUpView.moving) popUpView.moving = false;
	}
	mainView.mouseReleased(mouseX, mouseY);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
void mouseMoved()
{
	helpTextFade = 0;
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
}

///////////////////////////////////////////////////////////////////////////////////////////////////
void keyPressed() 
{
    if(shiftIntermission && key == '6')
    {
        shiftIntermission = false;
        nextShift();
    }
    else if(shiftIntermission && key == '5')
    {
        shiftIntermission = false;
    }
    
	if(!filterKeyInput)
	{
		if(key == '0')
		{
			saveFrame("HANDS-"+VERSION+"-####.png");
		}
	}
	if(activeTextBox != null)
	{
		activeTextBox.keypressed();
	}
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

