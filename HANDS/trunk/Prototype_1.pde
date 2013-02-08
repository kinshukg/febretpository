//import controlP5.*;

///////////////////////////////////////////////////////////////////////////////////////////////////
// Global constants
static int SCREEN_WIDTH = 1400;
static int SCREEN_HEIGHT = 900;

static int POPUP_WIDTH = 400;

static String VERSION = "c2r2";	

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
public boolean OPTION_TAILORED_MESSAGES = false;

public PImage IMG_LEGEND = null; 

// NNN definition images
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
	"Evidence Suggests That: <l> \n " +
	"- A combination of Medication Management, Positioning and Pain Management has the most positive impact on Pain Level. " + 
		"<*> <b> Add NIC Positioning. </b> <s1> \n " +
	"- It is more difficult to control pain when EOL patient has both Pain and Impaired Gas Exchange as problems. " + 
		"<*> <b> Prioritize pain and/or eliminate impaired gas exchange. </b> \n " +
	"- More than 50% of EOL patients do not achieve expected NOC Pain Level by discharge or death. " + 
		"<*> <b> Additional actions needed. </b> \n ";

// For the i icon related to Palliative Care Consultation
String MSG_PALLIATIVE_CARE_INFO =
	"Palliative care consultations assist with the management of complex pain, symptom control, comorbidities, " +
	"and patient/family communication in the presence of a serious, chronic illness. Palliative care services are found " +
	"to enhance patient outcomes (pain and symptom control), provider satisfaction, caregiver satisfaction, and cost savings.";

// For the i icon related to Mini POC for Family Coping
String MSG_FAMILY_COPING =
	"Care giving for the EOL CA patient requires family members to provide supportive care while simultaneously " +
	"coping with their own grief. The physical and emotional demands of care giving can overwhelm the family. " +
	"Use of adaptive coping strategies such as social support, EOL education, and problem solving are associated " +
	"with better acceptance and psychological adjustment for family caregivers.";
	
// For the i icon related Immobility Consequences
String MSG_IMMOBILITY_CONSEQUENCES = "Consequences of immobility include pneumonia, pressure ulcers, contractures, constipation, and venous thrombosis.  These outcomes are more important than improving mobility for some patients.";

// Message for info button next to pain graph
String MSG_PAIN_GRAPH_DESCRIPTION = 
	"Graph shows actual Pain NOC levels during first 24hr and projected levels to 72 hours if current actions are continued.";

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

POCManager pocManager;

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
public PImage plusIcon, minusIcon, prioritizeIcon, starIcon, checkIcon, crossIcon;
public PImage infoIcon;
public PImage IMG_EBI;
public PImage IMG_SUGGESTION;
public PImage IMG_TUTORIAL;

public PImage emptySmallGraph;
public PImage smallGraph1;
public PImage smallGraph2;
public PImage smallGraph3;

public PImage anxietyLevelTrend;
public PImage anxietySelfControlTrend;
public PImage painLevelTrend;
public PImage emptyTrend;

// Variables holding data of currently showing patient
public String name = "Ann Taylor";
public String dob = "03/12/1959",gender = "Female", allergies = "None" ,codeStatus = "DNR" ,poc = "09/17/2010", shft= "7:00a - 3:00p", room = "1240", medicalDX = "Malignant Neoplasm of the Pancreas" , mr = "xxx xxx xxx", physician = "Piper";
public String other = "Husband to be called ANYTIME \n at patient's request \n 776-894-1010";

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
	infoIcon.resize(0, 22);
	IMG_EBI = loadImage("information.png");
	IMG_EBI.resize(0, 22);
	IMG_SUGGESTION = loadImage("suggestion.png");
	IMG_SUGGESTION.resize(0, 22);
	IMG_TUTORIAL = loadImage("tutorial.png");
	IMG_TUTORIAL.resize(0, 22);
	
	emptySmallGraph = loadImage("emptySmallGraph.png");
	smallGraph1 = loadImage("SmallGraph1.png");
	smallGraph2 = loadImage("SmallGraph2.png");
	smallGraph3 = loadImage("SmallGraph3.png");
	smallGraph1.resize(0, 15);
	smallGraph2.resize(0, 15);
	smallGraph3.resize(0, 15);
	emptySmallGraph.resize(0, 15);
	
	starIcon = loadImage("star.png");
	checkIcon = loadImage("accept.png");
	checkIcon.resize(0, 22);
	crossIcon = loadImage("cross.png");
	crossIcon.resize(0, 22);
	
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
	painLevelTrend = loadImage("painLevelTrend.png");
	painLevelTrend.resize(500, 0);
	emptyTrend = loadImage("emptyTrend.png");
	emptyTrend.resize(500, 0);
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
	float cx = width - 380;
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
	if(OPTION_ALERT_INFO_BUTTON) ppwidth = 570;
	
	PainPopUpView ppw = new PainPopUpView(ppwidth, pocManager.painLevelView);
	ppw.reset();
	
	GraphPopUpView gp1 = new GraphPopUpView(500, pocManager.respiratoryStatusView);
	gp1.reset(anxietyLevelTrend);

	GraphPopUpView gp2 = new GraphPopUpView(500, pocManager.anxietySelfControlView);
	gp2.reset(anxietySelfControlTrend);
	
	GraphPopUpView gp3 = new GraphPopUpView(500, pocManager.painLevelView);
	gp3.reset(painLevelTrend);

	GraphPopUpView gp4 = new GraphPopUpView(500, pocManager.nocFamilyCoping);
	gp4.reset(emptyTrend);
	
	// Tis is the image that appears in the long access bar button.
	PImage painLevelActionButtonImage = null;
	
	if(OPTION_GRAPH_IN_MAIN_POPUP)
	{
		if( OPTION_NUMBER != 3 &&  OPTION_NUMBER !=4)
		{
			int graphButtonX = 750;
			pocManager.respiratoryStatusView.setGraphButton(2, smallGraph1, gp1, graphButtonX); 
			pocManager.anxietySelfControlView.setGraphButton(3, smallGraph2, gp2, graphButtonX); 
			pocManager.painLevelView.setGraphButton(3, smallGraph3, gp3, graphButtonX); 
			pocManager.nocFamilyCoping.setGraphButton(0, emptySmallGraph, gp4, graphButtonX); 
			//painLevelActionButtonImage = smallGraph3;
			pocManager.painLevelView.actionPopUp = ppw;
		}
		else
		{
			int graphButtonX = 750;
			pocManager.respiratoryStatusView.setGraphButton(2, smallGraph1, gp1, graphButtonX); 
			pocManager.anxietySelfControlView.setGraphButton(3, smallGraph2, gp2, graphButtonX); 
			pocManager.painLevelView.setGraphButton(3, smallGraph3, gp3, graphButtonX); 
			pocManager.nocFamilyCoping.setGraphButton(0, emptySmallGraph, gp4, graphButtonX); 
			graphButtonX = 750;
			//painLevelActionButtonImage = smallGraph3;
			pocManager.painLevelView.actionPopUp = ppw;
		}
	}
	else
	{
		// Default
		int graphButtonX = 750;
		pocManager.painLevelView.actionPopUp = ppw;
		pocManager.respiratoryStatusView.setGraphButton(2, smallGraph1, gp1, graphButtonX); 
		pocManager.anxietySelfControlView.setGraphButton(3, smallGraph2, gp2, graphButtonX); 
		pocManager.painLevelView.setGraphButton(3, smallGraph3, gp3, graphButtonX); 
		pocManager.nocFamilyCoping.setGraphButton(0, emptySmallGraph, gp4, graphButtonX); 
	}

	// alert button position, used for inter-row button alignment
	int alertButtonX;
	if(OPTION_LONG_ALERT_BUTTON)
	{
		alertButtonX = 360;
		pocManager.painLevelView.setAlertButton(3, "Mrs. Taylor's Pain Level is not controlled.", alertButtonX, painLevelActionButtonImage);
	}
	else 
	{
		alertButtonX = 575;
		pocManager.painLevelView.setAlertButton(3, "Actions", alertButtonX, painLevelActionButtonImage);
		pocManager.painLevelView.message = "Mrs. Taylor's Pain Level is not controlled.";
	}
	
	if(OPTION_ALERT_INFO_BUTTON)
	{
		pocManager.painLevelView.setInfoButton(645, 
			"This requires action because analysis of similar patient's data shows: <l> \n " +
			"* It is difficult to control Pain in EOL patients who also have impaired Gas Exchange \n " + 
			"* >50% of EOL patients do not achieve expected NOC Pain Rating by discharge or death\n");
	}
	
	// Cycle 2 addition
	if(CYCLE2_OPTION_NUMBER == 1)
	{
		DeathPopUpView dppw = new DeathPopUpView(400, pocManager.anxietySelfControlView);
		dppw.setupConsultRefuse();
		pocManager.anxietySelfControlView.enableQuickActionButton1(300, 300, MSG_ACTION_CONSULTATION, true, MSG_PALLIATIVE_CARE_INFO);
		pocManager.anxietySelfControlView.qa1Text.tooltipImage = IMG_CONSULTATION;
		pocManager.anxietySelfControlView.enableQuickActionButton2(300, 300, MSG_ACTION_COPING, false, MSG_FAMILY_COPING);
		pocManager.anxietySelfControlView.qa2Text.tooltipImage = IMG_INTERRUPTED_FAMILY_PROCESS;
		pocManager.anxietySelfControlView.actionPopUp = dppw;
	}
	else if(CYCLE2_OPTION_NUMBER == 2)
	{
		DeathPopUpView dppw = new DeathPopUpView(400, pocManager.anxietySelfControlView);
		dppw.setupFull();
		pocManager.anxietySelfControlView.setAlertButton(3, "Action required", alertButtonX, null);
		pocManager.anxietySelfControlView.actionPopUp = dppw;
	}
	
	// Cycle 3 addition
	if(CYCLE2_OPTION_NUMBER == 1)
	{
		pocManager.NOCMobility.enableQuickActionButton2(300, 300, MSG_ACTION_IMMOBILITY_CONSEQUENCES, false, MSG_IMMOBILITY_CONSEQUENCES);
		pocManager.NOCMobility.qa2Text.tooltipImage = IMG_CONSULTATION;
	}
	else if(CYCLE2_OPTION_NUMBER == 2)
	{
		MobilityPopupView mppw = new MobilityPopupView(400, pocManager.NOCMobility);
		mppw.setupFull();
		pocManager.NOCMobility.setAlertButton(3, "Action required", alertButtonX, null);
		pocManager.NOCMobility.actionPopUp = mppw;
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
	image(IMG_LEGEND, footerX, footerY + 10);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
void hideHelpText(String text)
{
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
	if(!filterKeyInput)
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
			OPTION_GRAPH_ALERT_BUTTON = false;
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
			OPTION_GRAPH_ALERT_BUTTON = false;
			OPTION_NUMBER = 4;
			CYCLE2_OPTION_NUMBER = 2;
			reset();
		}
		else if(key == '0')
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

