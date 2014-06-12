class MobilityPopupView extends PopUpViewBase
{
    POCManager pocManager;
	Button descriptionButton;
	
	CheckBox immobilityConsequencesCheck;

	//PopUpSection reasonSection;
	PopUpSection immobilityNICS;
	//PopUpSection actionSection;
	
	PopUpSection recommendedActionSection;
	CheckBox fallPreventionCheck;
	CheckBox energyConservationCheck;
	//CheckBox reason2;
	//CheckBox reason3;
	//boolean consultCheckAdded = false;
	
    TrendView trendView;
    
	///////////////////////////////////////////////////////////////////////////////////////////////
	MobilityPopupView(int w_, SecondLevelRowView parent, POCManager poc)
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
        if(trendView != null) title.addTrendView(trendView);
        //title.setImage(anxietySelfControlTrend);
        //title.setInfoButton(MSG_DEATH_GRAPH_DESCRIPTION);
        subviews.add(title);
        
		immobilityConsequencesCheck = new CheckBox("Add NOC: Immobility Consequences", secondLevelIcon, 0);
		immobilityConsequencesCheck.textBoxEnabled = false;
		immobilityConsequencesCheck.owner = this;
		immobilityConsequencesCheck.setIconTooltipImage(IMG_IMMOBILITY_CONSEQUENCES);
		
		String icmsg = "";
		icmsg = MSG_IMMOBILITY_CONSEQUENCES_GENERIC;

		recommendedActionSection = new PopUpSection(icmsg);
		recommendedActionSection.addAction(immobilityConsequencesCheck);
		//immobilityConsequencesCheck.selected = true;
        
        // Create section with additional actions that can be added under NOC Immobility Consequences
		immobilityNICS = new PopUpSection("Recommended NICs for Immobility Consequences NOC");
        fallPreventionCheck = immobilityNICS.addNIC("Pressure Ulcer Prevention", "");
		energyConservationCheck = immobilityNICS.addNIC("Skin Surveillance", "");
		
		subviews.add(recommendedActionSection);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void onCheckBoxChanged(CheckBox cb) 
	{
		if(cb == immobilityConsequencesCheck)
		{
			if(immobilityConsequencesCheck.selected)
			{
				subviews.add(5, immobilityNICS);
			}
			else
			{
				subviews.remove(immobilityNICS);
			}
		}
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void onOkClicked()
	{
        ColouredRowView nanda = pocManager.getNANDA("Impaired Physical Mobility");
		if(immobilityConsequencesCheck != null && immobilityConsequencesCheck.selected)
		{
			pocManager.addNOC("Immobility Consequences","", nanda, IMG_IMMOBILITY_CONSEQUENCES);
			recommendedActionSection.removeAction(immobilityConsequencesCheck);
			parent.addComment("");
			immobilityConsequencesCheck = null;
			//consultCheckAdded = true;
		}
		if(fallPreventionCheck != null && fallPreventionCheck.selected)
		{
            SecondLevelRowView noc = pocManager.getNOC("Impaired Physical Mobility", "Immobility Consequences");
            if(noc != null)
            {
                pocManager.addNIC("Pressure Ulcer Prevention", "", noc, loadImage("pressureUlcerPrevention.png"));
            }
        }
		if(energyConservationCheck != null && energyConservationCheck.selected)
		{
            SecondLevelRowView noc = pocManager.getNOC("Impaired Physical Mobility", "Immobility Consequences");
            if(noc != null)
            {
                pocManager.addNIC("Skin Surveillance", "", noc, loadImage("surveillance.png"));
            }
        }
		
		parent.stopBlinking();
		hide();
		
		// If we added the action and we are in cycle3 option 2, remove the action button from the POC action bar
		// if(immobilityConsequencesCheck == null)
		// {
			// parent.removeAlertButton();
		// }
	}
}
