class MobilityPopupView extends PopUpViewBase
{
    POCManager pocManager;
	//Button descriptionButton;
	
	PopUpSection recommendedActionSection;
	CheckBox immobilityConsequencesCheck;

	PopUpSection immobilityNICS;
	CheckBox fallPreventionCheck;
	CheckBox energyConservationCheck;
	
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
        if(OPTION_CDS_TYPE != 1 && trendView != null) title.addTrendView(trendView);
        //title.setImage(anxietySelfControlTrend);
        //title.setInfoButton(MSG_DEATH_GRAPH_DESCRIPTION);
        subviews.add(title);
        
		immobilityConsequencesCheck = new CheckBox("Add NOC: Immobility Consequences", secondLevelIcon, 0);
		immobilityConsequencesCheck.textBoxEnabled = false;
		immobilityConsequencesCheck.owner = this;
		immobilityConsequencesCheck.setIconTooltipImage(loadImage("immobilityConsequences.png"));
		
		String icmsg = "";
		icmsg = "<n> " + MSG_IMMOBILITY_CONSEQUENCES_GENERIC;

		recommendedActionSection = new PopUpSection(icmsg);
		recommendedActionSection.addAction(immobilityConsequencesCheck);
		//immobilityConsequencesCheck.selected = true;
        
        // Create section with additional actions that can be added under NOC Immobility Consequences
		immobilityNICS = new PopUpSection("<n> Recommended NICs for Immobility Consequences NOC");
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
		if(immobilityConsequencesCheck.selected)
		{
            immobilityConsequencesCheck.selected = false;
            immobilityConsequencesCheck.enabled = false;
			pocManager.addNOC("Immobility Consequences","", nanda, loadImage("immobilityConsequences.png"));
			recommendedActionSection.removeAction(immobilityConsequencesCheck);
			parent.addComment("");
		}
		if(fallPreventionCheck.selected)
		{
            fallPreventionCheck.selected = false;
            fallPreventionCheck.enabled = false;
            SecondLevelRowView noc = pocManager.getNOC("Impaired Physical Mobility", "Immobility Consequences");
            if(noc != null)
            {
                pocManager.addNIC("Pressure Ulcer Prevention", "", noc, loadImage("pressureUlcerPrevention.png"));
            }
        }
		if(energyConservationCheck.selected)
		{
            energyConservationCheck.selected = false;
            energyConservationCheck.enabled = false;
            SecondLevelRowView noc = pocManager.getNOC("Impaired Physical Mobility", "Immobility Consequences");
            if(noc != null)
            {
                pocManager.addNIC("Skin Surveillance", "", noc, loadImage("surveillance.png"));
            }
        }
		
		parent.stopBlinking();
		hide();
		
		// If we added the action and we are in cycle3 option 2, remove the action button from the POC action bar
		if(!immobilityConsequencesCheck.enabled && !fallPreventionCheck.enabled && !energyConservationCheck.enabled)
		{
			parent.removeAlertButton();
		}
	}
}
