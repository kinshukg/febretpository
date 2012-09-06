///////////////////////////////////////////////////////////////////////////////////////////////////
class DeathPopUpView extends PopUpViewBase
{
	Button descriptionButton;
	
	CheckBox consultCheck;
	CheckBox copingCheck;

	PopUpSection reasonSection;
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
		consultCheck = new CheckBox("Add NIC: Consultation", thirdLevelIcon, 0);
		consultCheck.textBoxEnabled = false;
		consultCheck.owner = this;
		copingCheck = new CheckBox("Add NANDA: Family coping mini POC", firstLevelIcon, 0);
		copingCheck.textBoxEnabled = false;
		copingCheck.owner = this;
		
		consultCheck.setIconTooltip("Adds consultation to the current NOC");
		copingCheck.setIconTooltip("Adds a NANDA section with: <l> \n " +
			"<*> NANDA: Interrupted Family Proceses \n " +
			"<*>   NOC: Family Coping \n " +
			"<*>     NIC: Family Support \n " +
			"<*>     NIC: Family Integrity Promotion \n " +
			"<*>     NIC: Health Education: End Of Life Process \n ");
		
		actionSection = new PopUpSection("Suggested actions: ");
		actionSection.addAction(consultCheck);
		actionSection.addAction(copingCheck);
		
		consultCheck.selected = true;
		copingCheck.selected = true;
		
		subviews.add(actionSection);
		
		createConsultRefuseSection();
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void createConsultRefuseSection()
	{
		reason1 = new CheckBox("Does not apply", starIcon, 0);
		reason2 = new CheckBox("Doctor refused it", starIcon, 0);
		reason3 = new CheckBox("Other reason", starIcon, 0);
		
		reason1.radio = true;
		reason2.radio = true;
		reason3.radio = true;
		reason1.textBoxEnabled = false;
		reason2.textBoxEnabled = false;
		reason3.textBoxEnabled = false;
		
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
				subviews.add(reasonSection);
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
			pocManager.addNIC(NIC_CONSULTATION_TEXT, "", pocManager.anxietySelfControlView);
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
					parent.addComment("Dismissed consultation: reason 1");
				}
				else if(reason2.selected)
				{
					parent.addComment("Dismissed consultation: reason 2");
				}
				else if(reason3.selected)
				{
					parent.addComment("Dismissed consultation: reason 3");
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
