///////////////////////////////////////////////////////////////////////////////////////////////////
class PopUpView extends View 
{
	int ADD_NIC = 0;
	int ADD_NOC = 1;
	int REMOVE_NANDA = 2;
	int PRIORITIZE_NANDA = 3;

	float arrowX, arrowY;
	Button commit, notApplicable;
	SecondLevelRowView parent;
	ClosePopUpView close;
	
	Button descriptionButton;

	///////////////////////////////////////////////////////////////////////////////////////////////
	PopUpView(float w_, SecondLevelRowView parent)
	{
		super(0, 0,w_ ,0);
		close = new ClosePopUpView(0,-20,w,20);
		this.subviews.add(close);
		
		//commit = new Button(20,0,150,20,"Save Changes",0,255);
		//notApplicable = new Button(200,0,180,20,"Mark as Read",0,255);
		commit = new Button(20,0,150,20,"Save Changes",200,0);
		notApplicable = new Button(200,0,180,20,"Decline Changes",200,0);
		
		this.subviews.add(commit);
		this.subviews.add(notApplicable);	
		this.parent = parent;
		
		descriptionButton = null;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void reset()
	{
		PopUpSection title = new PopUpSection("<h1> Mrs. Taylor's Pain Level is not controlled");
		String alertDescription = 
			"Evidence Suggests That: <l> \n " +
				"- A combination of Medication Management, Positioning and Pain Management has the most positive impact on Pain Level. " + 
					"<*> <b> Add NIC Positioning. </b> <s1> \n " +
				"- It is more difficult to control pain when EOL patient has both Pain and Impaired Gas Exchange as problems. " + 
					"<*> <b> Prioritize pain and/or eliminate impaired gas exchange. </b> \n " +
				"- More than 50% of EOL patients do not achieve expected NOC Pain Level by discharge or death. " + 
					"<*> <b> Additional actions needed. </b> \n ";
		if(OPTION_ENABLE_POPUP_TEXT)
		{
			if(OPTION_GRAPH_ALERT_BUTTON)
			{
				descriptionButton = new Button(
					322, 55, 0, 40, "Pain Level will not\n be met without action", alertHighColor, 0);
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
				title.setInfoButton("Graph shows actual Pain NOC levels during first 24hr and projected levels to 72 hours if current actions are continued.");
			}
		}
		subviews.add(title);
		//title.setInfoButton("Here is some information insida a tooltip yall");
			
		// if(OPTION_GRAPH_IN_MAIN_POPUP)
		// {
			// PopUpSection graph = new PopUpSection(0, 0, null, "Pain Level Trend");
			// graph.setImage(painLevelTrend);
			// subviews.add(graph);
			// title.separatorStyle = 0;
			// graph.separatorStyle = 1;
		// }
		
		
		// v2.1: on option 2 we do not use the star icon.
		String positioningText = "Positioning <b> (Recommended) </b> <s1>";
		if(OPTION_NUMBER == 2)
		{
			positioningText = "Positioning <b> (Recommended) </b>";
		}
		
		CheckBox c = new CheckBox(positioningText, thirdLevelIcon, ADD_NIC);
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
	void layout()
	{
		h = 0;
		for(int i = 0; i < subviews.size();i++)
		{
			View v = (View)popUpView.subviews.get(i);
			v.y = h;
			h += v.h;
			if(v != commit && v != notApplicable && v != close)
			{
				v.w = this.w;
			}
		}
		
		// v2.1: popup never goes off-screen vertically.
		if(y + h > SCREEN_HEIGHT)
		{
			y = SCREEN_HEIGHT - h;
		}
	}

	///////////////////////////////////////////////////////////////////////////////////////////////
	void drawContent()
	{
		int ys = 0;
		for(int i = 0 ;i<subviews.size();i++)
		{
			View v = (View)subviews.get(i);

			if(!v.equals(commit) && !v.equals(notApplicable))
			{
				v.y = ys;
				ys +=v.h;
			}
		}
		
		commit.y = ys;
		notApplicable.y = ys;  

		
		int border = 5;
		fill(0, 0, 0, 180);
		noStroke();
		rect(-border, -border, w + border, h + border);
		triangle(-border, 10, arrowX - x, arrowY - y, -border, ys - 10);
		fill(255);
		rect(0, 0, w, h);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	boolean contentClicked(float lx, float ly)
	{
		if(notApplicable.selected)
		{
			parent.stopBlinking();		
			notApplicable.selected = false;
			mainView.subviews.remove(this);
			popUpView = null;
		}
		if(commit.selected)
		{
			parent.stopBlinking();		
			commit.selected = false;
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
		return true;
	}
}
