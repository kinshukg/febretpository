///////////////////////////////////////////////////////////////////////////////////////////////////
class MobilityPopupView extends PopUpViewBase
{
	Button descriptionButton;
	
	CheckBox immobilityConsequencesCheck;

	//PopUpSection reasonSection;
	PopUpSection recommendedActionSection;
	//PopUpSection actionSection;
	
	//boolean consultCheckAdded = false;
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	MobilityPopupView(int w_, SecondLevelRowView parent)
	{
		super(w_, parent);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void setupFull()
	{
		PopUpSection title = new PopUpSection("<h1> TITLE FOR MOBILITY POPUP");
		title.setDescription("Consequences of immobility include pneumonia, pressure ulcers, contractures, constipation, and venous thrombosis.  These outcomes are more important than improving mobility for some patients.\n");
		subviews.add(title);
		
		
		immobilityConsequencesCheck = new CheckBox("Add NOC: Immobility Consequences", secondLevelIcon, 0);
		immobilityConsequencesCheck.textBoxEnabled = false;
		immobilityConsequencesCheck.owner = this;
		
		recommendedActionSection = new PopUpSection("Recommended actions: ");
		recommendedActionSection.addAction(immobilityConsequencesCheck);
		
		immobilityConsequencesCheck.selected = true;
		
		subviews.add(recommendedActionSection);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void onCheckBoxChanged(CheckBox cb) 
	{
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void onOkClicked()
	{
		if(immobilityConsequencesCheck != null && immobilityConsequencesCheck.selected)
		{
			pocManager.addNOC("Immobility Consequences","", pocManager.NANDAImpairedPhysicalMobility, IMG_IMMOBILITY_CONSEQUENCES);
			recommendedActionSection.removeAction(immobilityConsequencesCheck);
			parent.addComment("");
			immobilityConsequencesCheck = null;
			//consultCheckAdded = true;
		}
		
		hide();
		
		// If we added the action and we are in cycle3 option 2, remove the action button from the POC action bar
		if(immobilityConsequencesCheck == null && CYCLE2_OPTION_NUMBER == 2)
		{
			parent.removeAlertButton();
		}
	}
}
