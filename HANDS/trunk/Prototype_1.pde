// ############################################################################################################################################################################################
// EVL - Hands On Project Prototype # 1
// Draft # 2
// Added Buttons, Checkboxes and PopUpSections Functionality - To be Continued
// ############################################################################################################################################################################################


// Variables used to keep track of the prototype state
public int prototypeVariant = 0;
public int prototypeState = 0;

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
public TooltipView tooltipView = null;

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
public color alertHighColor = #FF6A6A ;
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

// Variables holding data of currently showing patient
public String name = "Ann Taylor";
public String dob = "03/12/1938",gender = "Female", allergies = "None" ,codeStatus = "DNR" ,poc = "09/17/2010", shft= "7:00a - 3:00p", room = "1240", medicalDX = "Malignant Neoplasm of the Pancreas" , mr = "xxx xxx xxx", physician = "Piper";
public String other = "Sister wants to be called ANYTIME at patient's request -- 776-894-1010-#################################";

// Other text strings.
public String rationale1 = "Data Mining Revealed that the combination of Medication Management, Positioning, and Pain Management has the most positive impact on pain level. ";
public String rationale2 = "Mrs Taylor's POC indicates that pain level is not controlled, a common finding for EOL patients who have Pain and Impaired Gas Exchange listed as problems on the POC.";
public String rationale3 = "Research has discovered that >50% of EOL patients do not achieve the expected NOC Pain Level goal by discharge or death.";

///////////////////////////////////////////////////////////////////////////////////////////////////
public void setup()
{
  size(1024, 800);
 
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
 
 plusIcon = loadImage(plusIconString);
 plusIcon.resize(0,15);
 
 minusIcon = loadImage(minusIconString);
 minusIcon.resize(0,15);

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
  for(int i = 0 ; i<otherPieces.length;i++)
  {
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
  
  CheckBox c = new CheckBox(0,0,true,false,false,"NIC Positioning",plusIcon,null);
  ArrayList a = new ArrayList ();
  a.add(c);
  
  PopUpSection recommended = new PopUpSection(0,0,a,"Recommended Actions: ");
  
  CheckBox c1 = new CheckBox(0,0,true,false,false,"NOC Energy Conservation",plusIcon,null);
  CheckBox c2 = new CheckBox(0,0,true,false,false,"NOC Coping",plusIcon,null);
  CheckBox c3 = new CheckBox(0,0,true,false,false,"NIC Pain Controlled Analgesia",plusIcon,null);
  CheckBox c4 = new CheckBox(0,0,true,false,false,"NIC Relaxation Therapy",minusIcon,null);

  ArrayList a1 = new ArrayList ();
  a1.add(c1);
  a1.add(c2); 
  a1.add(c3);
  a1.add(c4);

 
  PopUpSection alsoConsider = new PopUpSection(0,0,a1,"Also Consider: ");
 

  popUpView = new PopUpView(600,scrollingView.y-10,400);

  popUpView.subviews.add(recommended);
  popUpView.subviews.add(alsoConsider);
  
  painLevelView.setAlertButton(3,popUpView);
  
  medicationManagementView = new ThirdLevelRowView(0, 50+calmingTechniqueView_2.h+spiritualSupportView.h+acutePainView.h+titleView.h+15+nameView.h+dobView.h+20+genderView.h+allergiesView.h+codeStatusView.h+calmingTechniqueView.h+musicTherapyView.h+otherView.h+40+ impairedGasExchange.h+anxietyLevelView.h+deathAnxietyView.h + anxietySelfControlView.h+painLevelView.h,"Medical Management",thirdLevelIcon);
  //mainView.subviews.add(medicationManagementView);
  painLevelView.subs.add(medicationManagementView);
  
  painManagementView = new ThirdLevelRowView(0, 50+medicationManagementView.h+calmingTechniqueView_2.h+spiritualSupportView.h+acutePainView.h+titleView.h+15+nameView.h+dobView.h+20+genderView.h+allergiesView.h+codeStatusView.h+calmingTechniqueView.h+musicTherapyView.h+otherView.h+40+ impairedGasExchange.h+anxietyLevelView.h+deathAnxietyView.h + anxietySelfControlView.h+painLevelView.h,"Pain Management",thirdLevelIcon);
  //mainView.subviews.add(painManagementView);
  painLevelView.subs.add(painManagementView);
  
  
  
 /* Button b = new Button(0,0,100,20,"",0,255);
  mainView.subviews.add(b);
  */
  
  /*
  PopUpSection p1 = new PopUpSection(0,0,rationale1);
  popUpView.subviews.add(p1);
  PopUpSection p2 = new PopUpSection(0,0,rationale2);
  popUpView.subviews.add(p2);
  PopUpSection p3 = new PopUpSection(0,0,rationale3);
  popUpView.subviews.add(p3);
  
  mainView.subviews.add(popUpView);
  */

  //checkbox = new CheckBox(0,0,true,true,false,"Some Action",plusIcon,minusIcon);
  //mainView.subviews.add(checkbox);
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
	int footerY = (int)scrollingView.y + (int)scrollingView.h + 90;
	
	fill(0);
	text("Current \nRating", 640, scrollingView.y - 30);
	text("Expected \nRating", 740, scrollingView.y - 30);
	
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
static String [] wrapText (String text, int len)
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

///////////////////////////////////////////////////////////////////////////////////////////////////
void mousePressed()
{
	// KInda hack: after a mouse clikc ANYWHERE, if a tooltip vindow is open we close it.)
	if(tooltipView != null)
	{
		tooltipView = null;
	}

	//System.out.println(mouseX + " , "+ mouseY);
	mainView.mousePressed(mouseX, mouseY);
	if(popUpView.c.pressed)
	{
		mainView.subviews.remove(popUpView);
		popUpView.c.pressed = false;  
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


