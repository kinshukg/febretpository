///////////////////////////////////////////////////////////////////////////////////////////////////
class NativeActionsPopUpView extends PopUpViewBase
{
    POCManager pocManager;
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	NativeActionsPopUpView(int w_, SecondLevelRowView parent, POCManager poc)
	{
		super(w_, parent);
        pocManager = poc;
        parent.nativeActionPopUp = this;
	}
    
	///////////////////////////////////////////////////////////////////////////////////////////////
    PopUpSection addSection(String label)
    {
        PopUpSection section = new PopUpSection(label);
        subviews.add(section);
        return section;
    }
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void reset()
	{
		//setupPainTitleSection();
		//setupPainActionSections();
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
                                String[] tags = c.tag.split(": ");
                                if(tags.length > 1)
                                {
                                    pocManager.addNIC(tags[1], c.tb.text, parent, c.iconButton.tooltipImage);
                                }
                                else
                                {
                                    pocManager.addNIC(c.tag, c.tb.text, parent, c.iconButton.tooltipImage);
                                }
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
