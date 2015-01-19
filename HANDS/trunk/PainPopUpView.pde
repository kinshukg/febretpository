///////////////////////////////////////////////////////////////////////////////////////////////////
class PainPopUpView extends PopUpViewBase
{
    POCManager pocManager;
	int ADD_NIC = 0;
	int ADD_NOC = 1;
	int REMOVE_NANDA = 2;
	int PRIORITIZE_NANDA = 3;
	
	Button descriptionButton;
	
	//int totalActions;
    
    CheckBox consultCheck;
    CheckBox prioritizePainCheck;
    CheckBox addPositioningCheck;

    
	PopUpSection reasonSection;
	CheckBox reason1;
	CheckBox reason2;
	CheckBox reason3;
    
    TrendView trendView;
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	PainPopUpView(int w_, SecondLevelRowView parent, POCManager poc)
	{
		super(w_, parent);
        cds = true;
        pocManager = poc;
        parent.actionPopUp = this;
        NANDAParent = parent.parent;
        int alertButtonX = 460;
        // Tis is the image that appears in the long access bar button.
        PImage painLevelActionButtonImage = null;
        parent.setAlertButton(3, "Action required", alertButtonX, painLevelActionButtonImage);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void setupPainTitleSection()
	{
        PopUpSection title = new PopUpSection("");
        if(OPTION_CDS_TYPE != 1 && trendView != null) title.addTrendView(trendView);
        //title.setInfoButton(MSG_PAIN_GRAPH_DESCRIPTION);
        subviews.add(title);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void setupPainActionSections()
	{
		addPositioningCheck = new CheckBox("Add NIC: Positioning", "Positioning", thirdLevelIcon, ADD_NIC);
		addPositioningCheck.setIconTooltipImage(loadImage("positioning.png"));
        
		prioritizePainCheck = new CheckBox("Prioritize NANDA: Acute Pain", "Prioritize Acute Pain", firstLevelIcon, PRIORITIZE_NANDA);
		consultCheck = new CheckBox("Add NIC: Consultation: Palliative Care", "Consultation: Palliative Care", thirdLevelIcon, ADD_NIC);
        consultCheck.owner = this;
		
		prioritizePainCheck.setIconTooltipImage(loadImage("acutePain.png"));
		consultCheck.setIconTooltipImage(loadImage("consultation.PNG"));
		
		// Big information: we present EBI side-by-side with actions
        PopUpSection section1 = new PopUpSection(
            "<info> </b> <n> A combination of <b> Medication Management </b> , <b> Positioning </b> and <b> Pain Management </b> has the most positive impact on <b> Pain Level. </b>");
        //section1.setDescription(MSG_PAIN_POSITIONING);
        section1.addAction(addPositioningCheck);
        
        PopUpSection section3 = new PopUpSection(
            "<info> </b> <n> It is more difficult to control pain when EOL patient has both <b> Pain </b> and </b> Impaired Gas Exchange </b> problems.");            
        section3.addAction(prioritizePainCheck);
        section3.addAction(consultCheck);
        
        subviews.add(section1);
        subviews.add(section3);
        
        createConsultRefuseSection();
        subviews.add(6, reasonSection);
        //subviews.add(section3);
		//totalActions = 3;
	}
    
	///////////////////////////////////////////////////////////////////////////////////////////////
	void createConsultRefuseSection()
	{
		reason1 = new CheckBox("Patient / Family refused", null, 0);
		reason2 = new CheckBox("Doctor refused", null, 0);
		reason3 = new CheckBox("", null, 0);
		
		reason1.radio = true;
		reason2.radio = true;
		reason3.radio = true;
		reason1.textBoxEnabled = false;
		reason2.textBoxEnabled = true;
		reason3.textBoxEnabled = true;
		reason2.showTextBox();
		reason2.tb.suggestion = "Enter doctor name";
		reason3.tb.suggestion = "Other reason";
		reason3.showTextBox();
		
		reason1.selected = true;
		
		reasonSection = new PopUpSection(" <n> Adding palliative care consultation is highly recommended. If you choose not to add it, please specify a reason.");
		reasonSection.addAction(reason1);
		reasonSection.addAction(reason2);
		reasonSection.addAction(reason3);
        
        consultCheck.dismissSection = reasonSection;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void reset()
	{
		setupPainTitleSection();
		setupPainActionSections();
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void onCheckBoxChanged(CheckBox cb) 
	{
		if(cb == consultCheck)
		{
            subviews.remove(reasonSection);
			if(!consultCheck.selected)
			{
				subviews.add(6, reasonSection);
			}
		}
	}
    
	///////////////////////////////////////////////////////////////////////////////////////////////
	void onOkClicked()
	{
        if(consultCheck != null)
        {
            if(!consultCheck.selected)
            {
                if(reason1.selected)
                {
                    parent.addComment("Dismissed Palliative Care Consultation: Family / Patient Refused");
                }
                else if(reason2.selected)
                {
                    parent.addComment("Dismissed Palliative Care Consultation: Doctor " + reason2.tb.text + " refused");
                }
                else if(reason3.selected)
                {
                    parent.addComment("Dismissed Palliative Care Consultation: " + reason3.tb.text);
                }
            }
            else
            {
                consultCheck.selected = false;
                consultCheck.enabled = false;
                pocManager.addNIC(consultCheck.tag, "", parent, consultCheck.iconButton.tooltipImage);
                parent.addComment("");
            }
        }
        
        if(addPositioningCheck != null && addPositioningCheck.selected)
        {
            addPositioningCheck.selected = false;
            addPositioningCheck.enabled = false;
            pocManager.addNIC(addPositioningCheck.tag, "", parent, addPositioningCheck.iconButton.tooltipImage);
        }
        
        if(prioritizePainCheck != null && prioritizePainCheck.selected)
        {
            prioritizePainCheck.selected = false;
            prioritizePainCheck.enabled = false;
            pocManager.prioritizeNANDA(NANDAParent);
        }
        
		parent.stopBlinking();		
		mainView.subviews.remove(this);
		popUpView = null;
	}
    
}
