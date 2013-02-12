///////////////////////////////////////////////////////////////////////////////////////////////////
class DeathPopUpView extends PopUpViewBase
{
	Button descriptionButton;
	
	CheckBox consultCheck;
	CheckBox copingCheck;

	PopUpSection reasonSection;
	PopUpSection recommendedActionSection;
	PopUpSection actionSection;
	
	CheckBox reason1;
	CheckBox reason2;
	CheckBox reason3;
	
	boolean consultCheckAdded = false;
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	DeathPopUpView(int w_, SecondLevelRowView parent)
	{
		super(w_, parent);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void setupFull()
	{
		// PopUpSection title = new PopUpSection("");
		// title.setDescription("<l> \n - " + MSG_PALLIATIVE_CARE_INFO + " \n \n - " + MSG_FAMILY_COPING + " \n \n");
		// subviews.add(title);

		if(OPTION_BIG_INFORMATION)
		{
			PopUpSection title = new PopUpSection("");
			title.setImage(anxietySelfControlTrend);
			title.setInfoButton(MSG_PAIN_GRAPH_DESCRIPTION);
			subviews.add(title);
		}
		
		consultCheck = new CheckBox("Add NIC: Consultation - Palliative Care", thirdLevelIcon, 0);
		consultCheck.textBoxEnabled = false;
		consultCheck.owner = this;
		
		//consultCheck.setIconTooltip("Adds consultation to the current NOC");
		consultCheck.setIconTooltipImage(IMG_CONSULTATION);
		if(OPTION_TAILORED_MESSAGES) recommendedActionSection = new PopUpSection(MSG_PALLIATIVE_CARE_INFO_TAILORED);
		else recommendedActionSection = new PopUpSection(MSG_PALLIATIVE_CARE_INFO);
		recommendedActionSection.addAction(consultCheck);
		
		copingCheck = new CheckBox("Add NANDA: Family Coping Mini POC", firstLevelIcon, 0);
		copingCheck.textBoxEnabled = false;
		copingCheck.owner = this;
		
		// copingCheck.setIconTooltip("Adds a NANDA section with: <l> \n " +
			// "<*> <nanda> Interrupted Family Processes \n " +
			// "<*>   <noc> Family Coping \n " +
			// "<*>     <nic> Family Support \n " +
			// "<*>     <nic> Family Integrity Promotion \n " +
			// "<*>     <nic> Health Education: End Of Life Process \n ");
		
		copingCheck.setIconTooltipImage(IMG_INTERRUPTED_FAMILY_PROCESS);
		
		if(OPTION_TAILORED_MESSAGES) actionSection = new PopUpSection(MSG_FAMILY_COPING_TAILORED);
		else actionSection = new PopUpSection(MSG_FAMILY_COPING);
		actionSection.addAction(copingCheck);
		
		consultCheck.selected = true;
		copingCheck.selected = true;
		
		subviews.add(recommendedActionSection);
		subviews.add(actionSection);
		createConsultRefuseSection();
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
		
		//reason1.setIconTooltip(DEF_ACUTE_PAIN);
		//reason2.setIconTooltip(DEF_ENERGY_CONSERVATION);
		//reason3.setIconTooltip(DEF_COPING);
		
		reasonSection = new PopUpSection("Select a reason to dismiss Consultation suggestion: ");
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
			if(!consultCheck.selected)
			{
				subviews.add(5, reasonSection);
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
		if(consultCheck != null && consultCheck.selected)
		{
			pocManager.addNIC(NIC_CONSULTATION_TEXT, "", pocManager.anxietySelfControlView, IMG_CONSULTATION);
			actionSection.removeAction(consultCheck);
			parent.addComment("");
			consultCheck = null;
			consultCheckAdded = true;
		}
		else
		{
			if(!consultCheckAdded)
			{
				if(reason1.selected)
				{
					parent.addComment("Dismissed consultation: Family / Patient Refused");
				}
				else if(reason2.selected)
				{
					parent.addComment("Dismissed consultation: Doctor " + reason2.tb.text + " refused");
				}
				else if(reason3.selected)
				{
					parent.addComment("Dismissed consultation: " + reason3.tb.text);
				}
			}
			parent.removeQuickActionButton1();
		}
		if(copingCheck != null && copingCheck.selected)
		{
			pocManager.addNANDA(pocManager.nandaInterruptedFamilyProcess);
			actionSection.removeAction(copingCheck);
			copingCheck = null;
		}
		
		hide();
		
		// If we added both actions and we are in cycle2 option 2, remove the action button from the POC action bar
		if(copingCheck == null && consultCheck == null && CYCLE2_OPTION_NUMBER == 2)
		{
			parent.removeAlertButton();
		}
	}
}
