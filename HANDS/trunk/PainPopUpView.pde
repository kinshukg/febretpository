///////////////////////////////////////////////////////////////////////////////////////////////////
class PainPopUpView extends PopUpViewBase
{
	int ADD_NIC = 0;
	int ADD_NOC = 1;
	int REMOVE_NANDA = 2;
	int PRIORITIZE_NANDA = 3;
	
	Button descriptionButton;
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	PainPopUpView(int w_, SecondLevelRowView parent)
	{
		super(w_, parent);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void setupPainTitleSection()
	{
		PopUpSection title = new PopUpSection("<h1> Mrs. Taylor's Pain Level is not controlled");
		String alertDescription = MSG_PAIN_EVIDENCE_POPUP;
		
		if(OPTION_ENABLE_POPUP_TEXT)
		{
			if(OPTION_GRAPH_ALERT_BUTTON)
			{
				descriptionButton = new Button(
					322, 55, 0, 20, "Action required!", alertHighColor, 0);
				descriptionButton.tooltipText = alertDescription;
				descriptionButton.blinking = true;
				title.subviews.add(descriptionButton);
			}
			else
			{
				title.setDescription(alertDescription);
			}
			title.separatorStyle = 1;
			if(OPTION_EXPANDABLE_POPUP_TEXT) title.enableExpandableDescription();
			// v2.1: graph has info button (we hack the infobutton from popup section)
			if(OPTION_GRAPH_IN_MAIN_POPUP)
			{
				title.setImage(painLevelTrend);
				title.setInfoButton(MSG_PAIN_GRAPH_DESCRIPTION);
			}
		}
		subviews.add(title);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void setupPainActionSections()
	{
		// v2.1: on option 2 we do not use the star icon.
		String positioningText = "Positioning <b> (Recommended) </b> <s1>";
		if(OPTION_NUMBER == 2)
		{
			positioningText = "Positioning <b> (Recommended) </b>";
		}
		
		CheckBox c = new CheckBox(positioningText, "Positioning", thirdLevelIcon, ADD_NIC);
		c.setIconTooltip(DEF_POSITIONING);
		if(OPTION_ENABLE_ACTION_INFO_POPUP)
		{
			c.setInfoButton("Analysis of similar patient's data shows: <l> \n " +
							"A combination of Medication Management, Positioning and Pain Management has most positive impact on Pain Level.\n");
		}
		CheckBox c1 = new CheckBox("Acute Pain", firstLevelIcon, PRIORITIZE_NANDA);
		CheckBox c2 = new CheckBox("Impaired Gas Exchange", firstLevelIcon, REMOVE_NANDA);
		CheckBox c3 = new CheckBox("Energy Conservation", secondLevelIcon, ADD_NOC);
		CheckBox c4 = new CheckBox("Coping", secondLevelIcon, ADD_NOC);
		CheckBox c5 = new CheckBox("Patient controlled analgesia", thirdLevelIcon, ADD_NIC);
		CheckBox c6 = new CheckBox("Massage", thirdLevelIcon, ADD_NIC);
		CheckBox c7 = new CheckBox("Relaxation Therapy", thirdLevelIcon, ADD_NIC);
		CheckBox c8 = new CheckBox("Guided Imagery", thirdLevelIcon, ADD_NIC);
		
		c1.setIconTooltip(DEF_ACUTE_PAIN);
		c2.setIconTooltip(DEF_IMPAIRED_GAS_EXCHANGE);
		c3.setIconTooltip(DEF_ENERGY_CONSERVATION);
		c4.setIconTooltip(DEF_COPING);
		c5.setIconTooltip(DEF_PATIENT_CONTROLLED_ANALGESIA);
		c6.setIconTooltip(DEF_MASSAGE);
		c7.setIconTooltip(DEF_RELAXATION_THERAPY);
		c8.setIconTooltip(DEF_GUIDED_IMAGERY);
		
		PopUpSection addSection = new PopUpSection("Consider Adding: ");
		addSection.addAction(c);
		addSection.addAction(c3);
		addSection.addAction(c4);
		addSection.addAction(c5);
		addSection.addAction(c6);
		addSection.addAction(c7);
		addSection.addAction(c8);
		
		PopUpSection removeSection = new PopUpSection("Removing: ");
		removeSection.addAction(c2);
		
		PopUpSection prioritizeSection = new PopUpSection("Prioritizing: ");
		prioritizeSection.addAction(c1);
		
		subviews.add(addSection);
		subviews.add(removeSection);
		subviews.add(prioritizeSection);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void reset()
	{
		setupPainTitleSection();
		setupPainActionSections();
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void onOkClicked()
	{
		parent.stopBlinking();		
		for(int i = 0; i < subviews.size(); i++)
		{
			View v = (View)subviews.get(i);
			if(v != commit && v != notApplicable && v != close)
			{
				PopUpSection pps = (PopUpSection)v;
				ArrayList toRemove = new ArrayList();
				if(pps.actionBoxes != null) 
				{
					for(int j = 0; j < pps.actionBoxes.size(); j++)
					{
						CheckBox c = pps.actionBoxes.get(j);
						if(c.selected)
						{
							toRemove.add(c);
							if(c.id == ADD_NIC)
							{
								pocManager.addNIC(c.tag, c.tb.text, parent);
							}
							if(c.id == ADD_NOC)
							{
								pocManager.addNOC(c.tag, c.tb.text, parent.parent);
							}
							if(c.id == REMOVE_NANDA)
							{
								pocManager.deleteNANDA(pocManager.impairedGasExchange);
								if(c.tb.text.length() != 0) pocManager.impairedGasExchange.addComment(c.tb.text);
							}
							if(c.id == PRIORITIZE_NANDA)
							{
								pocManager.prioritizeNANDA(parent.parent);
								if(c.tb.text.length() != 0) parent.parent.addComment(c.tb.text);
							}
						}
					}
				}
				// Remove checked items after a commit.
				for(int j = 0; j < toRemove.size(); j++)
				{
					v.subviews.remove(toRemove.get(j));
					pps.actionBoxes.remove(toRemove.get(j));
				}
			}
		}
		mainView.subviews.remove(this);
		popUpView = null;
	}
}
