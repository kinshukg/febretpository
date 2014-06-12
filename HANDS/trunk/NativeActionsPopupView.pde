class NativeActionsPopUpView extends PopUpViewBase
{
    POCManager pocManager;
    
	////////////////////////////////////////////////////////////////////////////
	NativeActionsPopUpView(int w_, POCManager poc)
	{
		super(w_, null);
        pocManager = poc;
	}
    
	////////////////////////////////////////////////////////////////////////////
    PopUpSection addSection(String label)
    {
        PopUpSection section = new PopUpSection(label);
        subviews.add(section);
        return section;
    }
	
	////////////////////////////////////////////////////////////////////////////
	void reset()
	{
		//setupPainTitleSection();
		//setupPainActionSections();
	}
	
	////////////////////////////////////////////////////////////////////////////
	void onOkClicked()
	{
		for(int i = 0; i < subviews.size(); i++)
		{
			View v = (View)subviews.get(i);
			if(v != commit && v != notApplicable && v != close)
			{
				PopUpSection pps = (PopUpSection)v;
				//ArrayList toRemove = new ArrayList();
				if(pps.actionBoxes != null) 
				{
					for(int j = 0; j < pps.actionBoxes.size(); j++)
					{
						CheckBox c = pps.actionBoxes.get(j);
						if(c.selected && c.enabled)
						{
                            c.selected = false;
                            c.enabled = false;
							//toRemove.add(c);
							if(c.id == ADD_NIC)
							{
                                pocManager.addNIC(c.tag, c.tb.text, NOCParent, c.iconButton.tooltipImage);
							}
							if(c.id == ADD_NANDA)
							{
                                pocManager.addNANDA(c.tag, c.iconButton.tooltipImage);
							}
							if(c.id == ADD_NOC)
							{
                                pocManager.addNOC(c.tag, c.tb.text, NANDAParent, c.iconButton.tooltipImage);
							}
							// if(c.id == REMOVE_NANDA)
							// {
								// pocManager.deleteNANDA(pocManager.impairedGasExchange);
								// if(c.tb.text.length() != 0) pocManager.impairedGasExchange.addComment(c.tb.text);
							// }
							if(c.id == PRIORITIZE_NANDA)
							{
								pocManager.prioritizeNANDA(NANDAParent);
								if(c.tb.text.length() != 0) NANDAParent.addComment(c.tb.text);
							}
						}
					}
				}
				// Remove checked items after a commit.
				// for(int j = 0; j < toRemove.size(); j++)
				// {
					// v.subviews.remove(toRemove.get(j));
					// pps.actionBoxes.remove(toRemove.get(j));
				// }
			}
		}
		mainView.subviews.remove(this);
		popUpView = null;
	}
}
