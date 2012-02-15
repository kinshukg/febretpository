///////////////////////////////////////////////////////////////////////////////////////////////////
class PopUpView extends View 
{
	float arrowX, arrowY;
	Button commit, notApplicable;
	SecondLevelRowView parent;
	ClosePopUpView close;

	///////////////////////////////////////////////////////////////////////////////////////////////
	PopUpView(float w_, SecondLevelRowView parent)
	{
		super(0, 0,w_ ,0);
		close = new ClosePopUpView(0,-20,w,20);
		this.subviews.add(close);
		
		//commit = new Button(20,0,150,20,"Save Changes",0,255);
		//notApplicable = new Button(200,0,180,20,"Mark as Read",0,255);
		commit = new Button(20,0,150,20,"Save Changes",200,0);
		notApplicable = new Button(200,0,180,20,"Mark as Read",200,0);
		
		this.subviews.add(commit);
		this.subviews.add(notApplicable);	
		this.parent = parent;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void reset()
	{
		PopUpSection title = new PopUpSection(0, 0, null, "Mrs. Taylor's Pain Level is not controlled");
		if(OPTION_ENABLE_POPUP_TEXT)
		{
			title.setDescription(
				"Evidence Suggests That: BULLET \n " +
					"- A combination of Medication Management, Poitioning and Pain Management has most positive impact on Pain Level\n " +
					"- It is more difficult to control pain when EOL patient has both Pain and Impaired Gas Exchange as problems\n " +
					"- More than 50% of EOL patients do not achieve expected NOC Pain Level by discharge or death.\n ");
			title.separatorStyle = 1;
			if(OPTION_EXPANDABLE_POPUP_TEXT) title.enableExpandableDescription();
			if(OPTION_GRAPH_IN_MAIN_POPUP)
			{
				title.setImage(painLevelTrend);
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
		
		
		CheckBox c = new CheckBox(0,0,true,false,false,"Positioning",plusIcon,null,"NIC");
		if(OPTION_ENABLE_ACTION_INFO_POPUP)
		{
			c.setInfoButton("Evidence suggests that Positioning and Pain Management are effective in treating pain level");
		}
		ArrayList a = new ArrayList ();
		a.add(c);
		
		PopUpSection recommended = new PopUpSection(0,0,a,"Recommended Actions: ");

		CheckBox c1 = new CheckBox(10,0,true,false,false,"Pain Prioritize", prioritizeIcon, null, "NANDAI");
		CheckBox c2 = new CheckBox(10,0,true,false,false,"Impaired Gas Exchange", minusIcon, null, "NANDAI");
		CheckBox c3 = new CheckBox(10,0,true,false,false,"Energy Conservation", plusIcon, null, "NOC");
		CheckBox c4 = new CheckBox(10,0,true,false,false,"Coping", plusIcon, null, "NOC");
		CheckBox c5 = new CheckBox(10,0,true,false,false,"Pain controlled analgesia", plusIcon, null, "NIC");
		CheckBox c6 = new CheckBox(10,0,true,false,false,"Massage", plusIcon, null, "NIC");
		CheckBox c7 = new CheckBox(10,0,true,false,false,"Relaxation Therapy", plusIcon, null, "NIC");
		CheckBox c8 = new CheckBox(10,0,true,false,false,"Guided Imagery", plusIcon, null, "NIC");

		ArrayList a1 = new ArrayList ();
		a1.add(c1);
		a1.add(c2); 
		a1.add(c3);
		a1.add(c4);
		a1.add(c5);
		a1.add(c6);
		a1.add(c7);
		a1.add(c8);
		
		PopUpSection alsoConsider = new PopUpSection(0,0,a1,"Also Consider: ");
		subviews.add(recommended);
		subviews.add(alsoConsider);
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
	boolean contentPressed(float lx, float ly)
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
								if(c.icon1.equals(plusIcon) && c.type.equals("NIC"))
								{
									pocManager.addNIC(c.t, c.tb.text, parent);
								}
								if(c.icon1.equals(plusIcon) && c.type.equals("NOC"))
								{
									pocManager.addNOC(c.t, c.tb.text, parent.parent);
								}
								if(c.icon1.equals(minusIcon) && c.type.equals("NANDAI"))
								{
									pocManager.deleteNANDA(pocManager.impairedGasExchange);
									if(c.tb.text.length() != 0) pocManager.impairedGasExchange.addComment(c.tb.text);
								}
								if(c.icon1.equals(prioritizeIcon) && c.type.equals("NANDAI"))
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
