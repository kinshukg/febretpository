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
    
    TrendView trendView;
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	PainPopUpView(int w_, SecondLevelRowView parent, POCManager poc)
	{
		super(w_, parent);
        cds = true;
        pocManager = poc;
        parent.actionPopUp = this;
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
		CheckBox c = new CheckBox("Add NIC: Positioning", "Positioning", thirdLevelIcon, ADD_NIC);
		c.setIconTooltipImage(loadImage("positioning.png"));
        
		CheckBox c1 = new CheckBox("Prioritize NANDA: Acute Pain", "Prioritize Acute Pain", firstLevelIcon, PRIORITIZE_NANDA);
		CheckBox c2 = new CheckBox("Add NIC: Consultation: Palliative Care", "Consultation: Palliative Care", thirdLevelIcon, ADD_NIC);
		
		c1.setIconTooltipImage(loadImage("acutePain.png"));
		c2.setIconTooltipImage(loadImage("consultation.PNG"));
		
		// Big information: we present EBI side-by-side with actions
        PopUpSection section1 = new PopUpSection(
            "<info> </b> <n> A combination of <b> Medication Management </b> , <b> Positioning </b> and <b> Pain Management </b> has the most positive impact on <b> Pain Level. </b>");
        //section1.setDescription(MSG_PAIN_POSITIONING);
        section1.addAction(c);
        
        PopUpSection section3 = new PopUpSection(
            "<info> </b> <n> It is more difficult to control pain when EOL patient has both <b> Pain </b> and </b> Impaired Gas Exchange </b> problems.");            
        section3.addAction(c1);
        section3.addAction(c2);
        
        subviews.add(section1);
        subviews.add(section3);
        //subviews.add(section3);
		//totalActions = 3;
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
				if(pps.actionBoxes != null) 
				{
					for(int j = 0; j < pps.actionBoxes.size(); j++)
					{
						CheckBox c = pps.actionBoxes.get(j);
						if(c.selected)
						{
                            c.selected = false;
                            c.enabled = false;
							if(c.id == ADD_NIC)
							{
                                pocManager.addNIC(c.tag, c.tb.text, parent, c.iconButton.tooltipImage);
							}
							if(c.id == ADD_NOC)
							{
                                String[] tags = c.tag.split(": ");
                                if(tags.length > 1)
                                {
                                    pocManager.addNOC(tags[1], c.tb.text, parent.parent, c.iconButton.tooltipImage);
                                }
                                else
                                {
                                    pocManager.addNOC(c.tag, c.tb.text, parent.parent, c.iconButton.tooltipImage);
                                }
							}
							// if(c.id == REMOVE_NANDA)
							// {
								// pocManager.deleteNANDA(pocManager.impairedGasExchange);
								// if(c.tb.text.length() != 0) pocManager.impairedGasExchange.addComment(c.tb.text);
							// }
							if(c.id == PRIORITIZE_NANDA)
							{
								pocManager.prioritizeNANDA(parent.parent);
								if(c.tb.text.length() != 0) parent.parent.addComment(c.tb.text);
							}
						}
					}
				}
			}
		}
		mainView.subviews.remove(this);
		popUpView = null;
	}
    
}
