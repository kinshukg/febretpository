class DeathPopUpView extends PopUpViewBase
{
    POCManager pocManager;
	Button descriptionButton;
	
	CheckBox consultCheck;
	CheckBox prioritizeAnxietyCheck;
	CheckBox copingCheck;

	PopUpSection reasonSection;
	PopUpSection recommendedActionSection;
	PopUpSection actionSection;
	
	CheckBox reason1;
	CheckBox reason2;
	CheckBox reason3;
	
	boolean consultCheckAdded = false;
	
    TrendView trendView;
    
	///////////////////////////////////////////////////////////////////////////////////////////////
	DeathPopUpView(int w_, SecondLevelRowView parent, POCManager poc)
	{
		super(w_, parent);
        cds = true;
        pocManager = poc;
        int alertButtonX = 460;
        // Tis is the image that appears in the long access bar button.
        PImage actionButtonImage = null;
        parent.setAlertButton(3, "Action required", alertButtonX, actionButtonImage);
        parent.actionPopUp = this;
        
        NANDAParent = parent.parent;
        NOCParent = parent;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void reset()
	{
        PopUpSection title = new PopUpSection("");
        if(OPTION_CDS_TYPE != 1 && trendView != null) title.addTrendView(trendView);
        subviews.add(title);
        
        // Setup death axiety popup differently for patient 1 and 2.
        if(pocManager == patient1.pocManager)
        {
            consultCheck = new CheckBox("Add NIC: Consultation: Palliative Care", "Consultation: Palliative Care", thirdLevelIcon, 0);
            consultCheck.textBoxEnabled = false;
            consultCheck.owner = this;
            
            //consultCheck.setIconTooltip("Adds consultation to the current NOC");
            consultCheck.setIconTooltipImage(loadImage("consultation.PNG"));
            recommendedActionSection = new PopUpSection(
                "<info> Palliative care consultations help manage pain, symptoms, comorbidities, and patient/family communication.");
            recommendedActionSection.addAction(consultCheck);
            
            consultCheck.selected = false;
            
            subviews.add(recommendedActionSection);
            createConsultRefuseSection();
            subviews.add(5, reasonSection);
        }
        else
        {
            recommendedActionSection = new PopUpSection(
                "<info> The physical and emotional demands of caregiving can overwelm the family.");
            prioritizeAnxietyCheck = recommendedActionSection.prioritizeNANDA("Death Anxiety", "");
            
            copingCheck = new CheckBox("Add mini care plan: Family Coping", "Family Coping", firstLevelIcon, 0);
            copingCheck.textBoxEnabled = false;
            copingCheck.owner = this;
            
            recommendedActionSection.addAction(copingCheck);
            
            subviews.add(recommendedActionSection);
        }
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
		
		reasonSection = new PopUpSection("Adding palliative care consultation is highly recommended. If you choose not to add it, please specify a reason.");
		reasonSection.addAction(reason1);
		reasonSection.addAction(reason2);
		reasonSection.addAction(reason3);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void setupConsultRefuse()
	{
		PopUpSection title = new PopUpSection("Adding consultation is highly recommended. ");
		String alertDescription = "";
		title.setDescription(alertDescription);
		subviews.add(title);
		
		createConsultRefuseSection();
		subviews.add(reasonSection);
	}

	///////////////////////////////////////////////////////////////////////////////////////////////
	void onCheckBoxChanged(CheckBox cb) 
	{
		if(cb == consultCheck)
		{
            subviews.remove(reasonSection);
			if(!consultCheck.selected)
			{
				subviews.add(5, reasonSection);
			}
		}
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void onOkClicked()
	{
        if(consultCheck != null)
        {
            if(consultCheck.selected)
            {
                consultCheck.enabled = false;
                consultCheck.selected = false;
                SecondLevelRowView comfortableDeath = pocManager.getNOC("Death Anxiety", "Comfortable Death");
                pocManager.addNIC("Consultation: Palliative Care", "", comfortableDeath, loadImage("consultation.PNG"));
                //recommendedActionSection.removeAction(consultCheck);
                parent.addComment("");
                //consultCheck = null;
                //consultCheckAdded = true;
            }
            else
            {
                //if(!consultCheckAdded)
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
            }
        }
        
        if(prioritizeAnxietyCheck != null && prioritizeAnxietyCheck.selected)
        {
            prioritizeAnxietyCheck.selected = false;
            prioritizeAnxietyCheck.enabled = false;
            pocManager.prioritizeNANDA(NANDAParent);
        }
        if(copingCheck != null && copingCheck.selected)
        {
            copingCheck.selected = false;
            copingCheck.enabled = false;
            ColouredRowView nanda = pocManager.addNANDA("Dysfunctional Family Processes", loadImage("dysfunctionalFamilyProcesses.png"));
            SecondLevelRowView noc = pocManager.addNOC("Family Coping", "", nanda, loadImage("familyCoping.PNG"));
            pocManager.addNIC("Family Support", "", noc, loadImage("familySupport.PNG"));
            pocManager.addNIC("Family Integrity Promotion", "", noc, loadImage("familyIntegrityPromotion.PNG"));
            pocManager.addNIC("Health Education: End of Life Process", "", noc, loadImage("healthEducation.PNG"));
        }
        
        if(copingCheck != null && !copingCheck.enabled && 
            prioritizeAnxietyCheck != null && !prioritizeAnxietyCheck.enabled)
        {
            parent.removeAlertButton();
        }
		
		parent.stopBlinking();
		hide();
	}
    
	///////////////////////////////////////////////////////////////////////////////////////////////
    void onNICAdded(ThirdLevelRowView nic)
    {
        super.onNICAdded(nic);
        // Hide/show the consult refuse section when family coping is added or removed from the POC
        if(nic.title.equals(consultCheck.tag))
        {
            onCheckBoxChanged(consultCheck);
        }
    }
    
	///////////////////////////////////////////////////////////////////////////////////////////////
    void onNICRemoved(ThirdLevelRowView nic)
    {
        super.onNICRemoved(nic);
        // Hide/show the consult refuse section when family coping is added or removed from the POC
        if(consultCheck != null && nic.title.equals(consultCheck.tag))
        {
            onCheckBoxChanged(consultCheck);
        }
    }
}
