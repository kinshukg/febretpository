///////////////////////////////////////////////////////////////////////////////////////////////////
class MobilityPopupView extends PopUpViewBase
{
	Button descriptionButton;
	
	CheckBox immobilityConsequencesCheck;

	//PopUpSection reasonSection;
	PopUpSection recommendedActionSection;
	//PopUpSection actionSection;
	
	PopUpSection reasonSection;
	CheckBox reason1;
	CheckBox reason2;
	CheckBox reason3;
	//boolean consultCheckAdded = false;
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	MobilityPopupView(int w_, SecondLevelRowView parent)
	{
		super(w_, parent);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void createRefuseSection()
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
		
		//reason1.setIconTooltip(DEF_ACUTE_PAIN);
		//reason2.setIconTooltip(DEF_ENERGY_CONSERVATION);
		//reason3.setIconTooltip(DEF_COPING);
		
		reasonSection = new PopUpSection("Select a reason to dismiss suggestion: ");
		reasonSection.addAction(reason1);
		reasonSection.addAction(reason2);
		reasonSection.addAction(reason3);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void setupRefuseSection()
	{
		PopUpSection title = new PopUpSection("Adding Immobility Consequences is highly recommended. ");
		String alertDescription = "";
		title.setDescription(alertDescription);
		subviews.add(title);
		
		createRefuseSection();
		subviews.add(reasonSection);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void setupFull()
	{
		immobilityConsequencesCheck = new CheckBox("Add NOC: Immobility Consequences", secondLevelIcon, 0);
		immobilityConsequencesCheck.textBoxEnabled = false;
		immobilityConsequencesCheck.owner = this;
		immobilityConsequencesCheck.setIconTooltipImage(IMG_IMMOBILITY_CONSEQUENCES);
		
		String icmsg = "";
		if(OPTION_TAILORED_MESSAGES) icmsg = MSG_IMMOBILITY_CONSEQUENCES_TAILORED;
		else icmsg = MSG_IMMOBILITY_CONSEQUENCES_GENERIC;

		recommendedActionSection = new PopUpSection(icmsg);
		recommendedActionSection.addAction(immobilityConsequencesCheck);
		
		immobilityConsequencesCheck.selected = true;
		
		subviews.add(recommendedActionSection);
		createRefuseSection();
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void onCheckBoxChanged(CheckBox cb) 
	{
		if(cb == immobilityConsequencesCheck)
		{
			if(!immobilityConsequencesCheck.selected)
			{
				subviews.add(3, reasonSection);
			}
			else
			{
				subviews.remove(reasonSection);
			}
		}
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
		else
		{
			//if(!consultCheckAdded)
			{
				if(reason1.selected)
				{
					parent.addComment("Dismissed Immobility Consequences: Family / Patient Refused");
				}
				else if(reason2.selected)
				{
					parent.addComment("Dismissed Immobility Consequences: Doctor " + reason2.tb.text + " refused");
				}
				else if(reason3.selected)
				{
					parent.addComment("Dismissed Immobility Consequences: " + reason3.tb.text);
				}
			}
			parent.removeQuickActionButton2();
		}
		
		parent.stopBlinking();
		hide();
		
		// If we added the action and we are in cycle3 option 2, remove the action button from the POC action bar
		if(immobilityConsequencesCheck == null && OPTION_BIG_INFORMATION)
		{
			parent.removeAlertButton();
		}
	}
}
