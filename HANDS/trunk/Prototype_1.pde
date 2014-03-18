///////////////////////////////////////////////////////////////////////////////////////////////////
// Global constants
static int SCREEN_WIDTH = 1400;
static int SCREEN_HEIGHT = 900;

static int POPUP_WIDTH = 400;

static String VERSION = "c3r3";	

static color STYLE_DELETED_ROW_BACK_COLOR = #888888;	

// Variables used to keep track of the prototype state
public boolean OPTION_NATIVE = false;
public boolean OPTION_ENABLE_POPUP_TEXT = true;
//public boolean OPTION_ENABLE_ACTION_INFO_POPUP = false;
public boolean OPTION_TOOLTIP_AUTO_OPEN = false;
public boolean OPTION_GRAPH_ALERT_BUTTON = false;
public int OPTION_NNN_ICON_STYLE = 1;
public int OPTION_NUMBER = 1;
public int CYCLE2_OPTION_NUMBER = 1;

public PImage IMG_LEGEND = null; 

// NNN definition images
public PImage IMG_PLACEHOLDER = null; 
public PImage IMG_IMP_GAS_EXC = null; 
public PImage IMG_ACUTE_PAIN = null;
public PImage IMG_DEATH_ANXIETY = null;
public PImage IMG_COMFORTABLE_DEATH = null;
public PImage IMG_CONSULTATION = null;
public PImage IMG_COPING = null;
public PImage IMG_ENERGY_CONSERVATION = null;
public PImage IMG_ENVIRONMENTAL_MANAGEMENT = null;
public PImage IMG_FAMILY_COPING = null;
public PImage IMG_FAMILY_INTEGRITY_PROMOTION = null;
public PImage IMG_FAMILY_SUPPORT = null;
public PImage IMG_FAMILY_THERAPY = null;
public PImage IMG_GRIEVING = null;
public PImage IMG_GUIDED_IMAGERY = null;
public PImage IMG_HEALTH_EDUCATION = null;
public PImage IMG_IMPAIRED_GAS_EXCHANGE = null;
public PImage IMG_INTERRUPTED_FAMILY_PROCESS = null;
public PImage IMG_MASSAGE = null;
public PImage IMG_PATIENT_CONTROLLED_ANALGESIA = null;
public PImage IMG_POSITIONING = null;
public PImage IMG_RELAXATION_THERAPY = null;
// Cycle 2 Additions
public PImage IMG_MUSIC_THERAPY = null;
public PImage IMG_CALMING_TECHNIQUE = null;
public PImage IMG_SPIRITUAL_SUPPORT = null;
public PImage IMG_MEDICATION_MANAGEMENT = null;
public PImage IMG_PAIN_MANAGEMENT = null;
public PImage IMG_ANXIETY_LEVEL = null;
public PImage IMG_PAIN_LEVEL = null;
// Cycle 3 Additions
public PImage IMG_IMPAIRED_PHYSICAL_MOBILITY = null;
public PImage IMG_ACID_BASE_MONITORING = null;
public PImage IMG_AIRWAY_MANAGEMENT = null;
public PImage IMG_BEDSIDE_LABORATORY_TESTING = null;
public PImage IMG_ENERGY_MANAGEMENT = null;
public PImage IMG_FALL_PREVENTION = null;
public PImage IMG_IMMOBILITY_CONSEQUENCES = null;
public PImage IMG_MOBILITY = null;
public PImage IMG_RESPIRATORY_STATUS_GAS_EXCHANGE = null;

///////////////////////////////////////////////////////////////////////////////////////////////////
// Message library
// Pain evidence message for popup screen.
String MSG_PAIN_EVIDENCE_POPUP = 			
	"<b> Evidence Suggests That: </b> \n \n " +
	"A combination of <b> Medication Management </b> , <b> Positioning </b> and <b> Pain Management </b> has the most positive impact on <b> Pain Level. </b> \n \n " + 
	"It is more difficult to control pain when EOL patient has both <b> Pain </b> and </b> Impaired Gas Exchange </b> problems. \n \n " + 
	"All pain can be relieved, however achieving pain control within the first 24 hours is critical to achieving pain goals throughout the hospitalization. <l> \n " +
	"<bl> Simple interventions control pain for <b> 90% </b> of EOL patients. \n " +
	"<bl> Palliative care and aggressive interventions are needed for the remaining <b> 10%. </b>";

String MSG_PAIN_POSITIONING = "</b> A combination of <b> Medication Management </b> , <b> Positioning </b> and <b> Pain Management </b> has the most positive impact on <b> Pain Level. </b>";
String MSG_PAIN_GAS_EXCHANGE = "</b> It is more difficult to control pain when EOL patient has both <b> Pain </b> and </b> Impaired Gas Exchange </b> problems.";
String MSG_PAIN_OUTCOME = "</b> All pain can be relieved, however achieving pain control within the first 24 hours is critical to achieving pain goals throughout the hospitalization. <l> \n " +
	"<bl> Simple interventions control pain for <b> 90% </b> of EOL patients. \n " +
	"<bl> Palliative care and aggressive interventions are needed for the remaining <b> 10%. </b>";
	
// For the i icon related to Palliative Care Consultation
String MSG_PALLIATIVE_CARE_INFO =
	"Palliative care consultations help manage pain, symptoms, comorbidities, and patient/family communication.";

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

// Cycle 4: List of patients (substitutes POCManager instance, now there is one POCManager
// instance per patient)
Patient patient1;
Patient patient2;
Patient curPatient;
int currentShift = 1;
// When set to true, display a black screen between shifts.
boolean shiftIntermission = false;


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
	crossIcon.resize(0, 22);
	
	IMG_PLACEHOLDER = loadImage("tooltipPlaceholder.PNG");
    
	IMG_IMP_GAS_EXC = loadImage("impairedgasExchange.png");
	IMG_ACUTE_PAIN = loadImage("acutePain.png");
	IMG_DEATH_ANXIETY = loadImage("deathAnxiety.png");
	IMG_INTERRUPTED_FAMILY_PROCESS = loadImage("interruptedFamilyProcess.PNG");
	
	IMG_FAMILY_INTEGRITY_PROMOTION = loadImage("familyIntegrityPromotion.PNG");
	IMG_COMFORTABLE_DEATH = loadImage("comfortableDeath.PNG");
	IMG_CONSULTATION =  loadImage("consultation.PNG");
	IMG_COPING =  loadImage("coping.PNG");
	IMG_ENERGY_CONSERVATION =  loadImage("energyConservation.PNG");
	IMG_ENVIRONMENTAL_MANAGEMENT =  loadImage("environmentalManagement.PNG");
	IMG_FAMILY_COPING =  loadImage("familyCoping.PNG");
	IMG_FAMILY_INTEGRITY_PROMOTION =  loadImage("familyIntegrityPromotion.PNG");
	IMG_FAMILY_SUPPORT =  loadImage("familySupport.PNG");
	IMG_FAMILY_THERAPY =  loadImage("familyTherapy.PNG");
	IMG_GRIEVING =  loadImage("grieving.PNG");
	IMG_GUIDED_IMAGERY =  loadImage("guidedImagery.PNG");
	IMG_HEALTH_EDUCATION =  loadImage("healthEducation.PNG");
	IMG_MASSAGE =  loadImage("massage.PNG");
	IMG_PATIENT_CONTROLLED_ANALGESIA =  loadImage("patientControlledAnalgesia.PNG");
	IMG_POSITIONING =  loadImage("positioning.png");
	IMG_RELAXATION_THERAPY =  loadImage("NICRelaxationTherapy.PNG");
	
	IMG_MUSIC_THERAPY = loadImage("musicTherapy.PNG");
	IMG_CALMING_TECHNIQUE = loadImage("calmingTechnique.PNG");
	IMG_SPIRITUAL_SUPPORT = loadImage("spiritualSupport.PNG");
	IMG_MEDICATION_MANAGEMENT = loadImage("medicationManagement.PNG");
	IMG_PAIN_MANAGEMENT = loadImage("painManagement.PNG");
	IMG_ANXIETY_LEVEL = loadImage("anxietyLevel.PNG");
	IMG_PAIN_LEVEL = loadImage("painLevel.PNG");
	
	// Cycle 3
	IMG_IMPAIRED_PHYSICAL_MOBILITY = loadImage("NANDAImpairedPhysicalMobility.png");
	IMG_ACID_BASE_MONITORING = loadImage("NICAcidBaseMonitoring.png");
	IMG_AIRWAY_MANAGEMENT = loadImage("NICAirwayManagement.png");
	IMG_BEDSIDE_LABORATORY_TESTING = loadImage("NICBedsideLaboratoryTesting.png");
	IMG_ENERGY_MANAGEMENT = loadImage("NICEnergyManagement.png");
	IMG_FALL_PREVENTION = loadImage("NICFallPrevention.PNG");
	IMG_IMMOBILITY_CONSEQUENCES = loadImage("NOCImmobilityConsequences.png");
	IMG_MOBILITY = loadImage("NOCMobility.png");
	IMG_RESPIRATORY_STATUS_GAS_EXCHANGE = loadImage("NOCRespiratoryStatusGasExchange.png");;
	

	// Make sure initial options correspond to no suggestion version
	OPTION_NATIVE = true;
	OPTION_GRAPH_ALERT_BUTTON = false;
	OPTION_NUMBER = 2;
	CYCLE2_OPTION_NUMBER = 1;

	frame.setTitle("Prototype No Suggestions");
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
		firstLevelIcon.resize(0,15);
		secondLevelIcon.resize(0,15);
		thirdLevelIcon.resize(0,15);

		firstLevelIconLegend = loadImage("NANDA.png");
		secondLevelIconLegend  = loadImage("NOC.png");
		thirdLevelIconLegend = loadImage("NIC.png");
		firstLevelIconLegend.resize(0,32);
		secondLevelIconLegend.resize(0,32);
		thirdLevelIconLegend.resize(0,32);
	}
	
	anxietyLevelTrend = loadImage("anxietyLevelTrend.png");
	anxietyLevelTrend.resize(500, 0);
	anxietySelfControlTrend = loadImage("anxietySelfControlTrend2.png");
	anxietySelfControlTrend.resize(500, 0);
	emptyTrend = loadImage("emptyTrend.png");
	emptyTrend.resize(500, 0);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
void reset()
{
	popUpView = null;
	tooltipView = null;
	
	loadNNNIcons();
	
	// Views created
	mainView = new View(0, 0, width, height);

	titleView = new TitleView(0,0,width,handIcon,"HANDS","- Hands-On Automated Nursing Data System",titleBackgroundColor, titleColor,subtitleColor);
	mainView.subviews.add(titleView); 

	setupPatientInfoView();
	setupPatients();
}

///////////////////////////////////////////////////////////////////////////////////////////////////
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
}

///////////////////////////////////////////////////////////////////////////////////////////////////
public void setupPatients()
{
	//pocManager = new POCManager();
	//pocManager.reset();
    
    patient1 = new Patient();
    patient1.id = 1;
    patient1.name = "Ann Taylor";
    patient1.dob = "03/12/1959";
    patient1.gender = "Female";
    patient1.allergies = "None";
    patient1.codeStatus = "DNR";
    patient1.poc = "09/17/2013";
    patient1.shft= "7:00a - 7:00p";
    patient1.room = "1240";
    patient1.medicalDX = "Malignant Neoplasm of the Pancreas";
    patient1.mr = "xxx xxx xxx";
    patient1.physician = "Piper";
    patient1.other = "Husband to be called ANYTIME \n at patient's request \n 776-894-1010";
    
    // Setup patient 1 pain trends
    patient1.painTrendView = new TrendGraph(0, 0);
    TrendView tw = patient1.painTrendView;
    
    tw.now = 3;
    tw.pastTrend[0] = 3;    
    tw.pastTrend[1] = 2;    
    tw.pastTrend[2] = 2;    
    tw.projectionGood[3] = 1;    
    tw.projectionGood[4] = 3;    
    tw.projectionGood[5] = 5;    
    tw.projectionGood[6] = 5;    
    tw.projectionBad[3] = 1;    
    tw.projectionBad[4] = 2;    
    tw.projectionBad[5] = 1;    
    tw.projectionBad[6] = 1;    

    patient1.reset();
    
    ///////// Patient 2

    patient2 = new Patient();
    patient2.id = 1;
    patient2.name = "Ciccio Pasticcio";
    patient2.dob = "03/12/1821";
    patient2.gender = "Male";
    patient2.allergies = "None";
    patient2.codeStatus = "DNR";
    patient2.poc = "09/17/2013";
    patient2.shft= "7:00a - 7:00p";
    patient2.room = "1240";
    patient2.medicalDX = "Broken Head";
    patient2.mr = "xxx xxx xxx";
    patient2.physician = "Piper";
    patient2.other = "Nobody likes him.";
    
    // Setup patient 1 pain trends
    patient2.painTrendView = new TrendGraph(0, 0);
    tw = patient2.painTrendView;
    
    tw.now = 3;
    tw.pastTrend[0] = 3;    
    tw.pastTrend[1] = 2;    
    tw.pastTrend[2] = 2;    
    tw.projectionGood[3] = 1;    
    tw.projectionGood[4] = 3;    
    tw.projectionGood[5] = 5;    
    tw.projectionGood[6] = 5;    
    tw.projectionBad[3] = 1;    
    tw.projectionBad[4] = 2;    
    tw.projectionBad[5] = 1;    
    tw.projectionBad[6] = 1;    
    
    patient2.reset();
    
    setActivePatient(patient1);
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////
public void nextShift()
{
    currentShift++;
    if(currentShift == 2)
    {
        // update POC dates.
        patient1.poc = "09/19/2013";
        patient2.poc = "09/19/2013";
    }
    else if(currentShift == 3)
    {
        // update POC dates.
        patient1.poc = "09/23/2013";
        patient2.poc = "09/23/2013";
    }
    
    updatePatientStatus(patient1);
    updatePatientStatus(patient2);
    
    // When switching to another shift, always go back to patient 1.
    setActivePatient(patient1);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
public void updatePatientStatus(Patient patient)
{
    // Update pain status based on user actions
    TrendView tw = patient.painTrendView;
    // current value;
    int c = tw.pastTrend[tw.now - 1];
    // now index
    tw.now = tw.now + 1;
    int i = tw.now - 1;
    POCManager poc = patient.pocManager;
    // If user added positioning, pain score always goes up by 1
    if(poc.achPositioningAdded)
    {
        // If all three suggestions have been applied, pain goes up by 2.
        if(poc.achPainPrioritized && poc.achPalliativeConsultAdded)
        {
            tw.pastTrend[i] = 4;
        }
        else
        {
            tw.pastTrend[i] = 3;
        }
    }
    // If both the other suggestions have been considered, pain goes up by 1 
    else if(poc.achPainPrioritized && poc.achPalliativeConsultAdded)
    {
        tw.pastTrend[i] = 3;
    }
    // If no suggstion has been followed, pain goes down by 1.
    else if(!poc.achPainPrioritized && !poc.achPalliativeConsultAdded)
    {
        tw.pastTrend[i] = 1;
    }
    // Update the current pain level score to mach value from the trend view
    poc.getNOC("Acute Pain", "Pain Level").firstColumn = tw.pastTrend[i];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
public void setActivePatient(Patient p)
{
    // Hide all patients
    patient1.hide();
    
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

///////////////////////////////////////////////////////////////////////////////////////////////////
public void draw()
{
    // Do we need to show the intermission screen betwen shifts?
    if(shiftIntermission)
    {
        background(0); 
		fill(255);
		textFont(font);
		textSize(24);
		text("Shift Ended. Press 6 To Continue To Next Shift",10,10);
        return;
    }
    
	background(backgroundColor); 
	// Draw static view elements
	drawStaticViewElements();

	mainView.draw();
	
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

///////////////////////////////////////////////////////////////////////////////////////////////////
void drawStaticViewElements()
{
	int footerY = 500;
	int footerX = 1020;
	if(!OPTION_NATIVE) image(IMG_LEGEND, footerX, footerY + 10);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
void hideHelpText(String text)
{
}

///////////////////////////////////////////////////////////////////////////////////////////////////
void mouseReleased()
{
	// Kinda hack: if a tooltip window is enabled, a click closes it regardless of where the user clicks.
	if(tooltipView != null)
	{
		tooltipView = null;
		return;
	}
	
	mainView.mouseClicked(mouseX, mouseY);
	
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
	if(!filterKeyInput)
	{
		if(key == '1')
		{
			frame.setTitle("Prototype Variant 1");
			OPTION_NATIVE = false;
			//OPTION_ENABLE_ACTION_INFO_POPUP = true;
			OPTION_GRAPH_ALERT_BUTTON = false;
			OPTION_NUMBER = 2;
			CYCLE2_OPTION_NUMBER = 1;
			reset();
		}
		else if(key == '2')
		{
			frame.setTitle("Prototype Variant 2");
			OPTION_NATIVE = false;
			OPTION_ENABLE_POPUP_TEXT = true;
			//OPTION_ENABLE_ACTION_INFO_POPUP = false;
			OPTION_GRAPH_ALERT_BUTTON = false;
			OPTION_NUMBER = 4;
			CYCLE2_OPTION_NUMBER = 1;
			reset();
		}
		if(key == '3')
		{
			frame.setTitle("Prototype Variant 3");
			OPTION_NATIVE = false;
			OPTION_ENABLE_POPUP_TEXT = false;
			//OPTION_ENABLE_ACTION_INFO_POPUP = true;
			OPTION_GRAPH_ALERT_BUTTON = false;
			OPTION_NUMBER = 2;
			CYCLE2_OPTION_NUMBER = 2;
			reset();
		}
		else if(key == '4')
		{
			frame.setTitle("Prototype Variant 4");
			OPTION_NATIVE = false;
			OPTION_ENABLE_POPUP_TEXT = true;
			OPTION_GRAPH_ALERT_BUTTON = false;
			OPTION_NUMBER = 4;
			CYCLE2_OPTION_NUMBER = 2;
			reset();
		}
		else if(key == '5')
		{
			frame.setTitle("Prototype No Suggestions");
			OPTION_NATIVE = true;
			reset();
		}
		else if(key == '0')
		{
			saveFrame("HANDS-"+VERSION+"-####.png");
		}
		else if(key == '9')
		{
			setActivePatient(patient1);
		}
		else if(key == '8')
		{
			setActivePatient(patient2);
		}
		else if(key == '7')
		{
            shiftIntermission = true;
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

