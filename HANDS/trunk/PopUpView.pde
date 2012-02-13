///////////////////////////////////////////////////////////////////////////////////////////////////
class PopUpView extends View 
{
	ClosePopUpView c;
	float arrowX, arrowY;
	Button commit, notApplicable;
	SecondLevelRowView parent;

	///////////////////////////////////////////////////////////////////////////////////////////////
	PopUpView(float x_, float y_, float w_, SecondLevelRowView parent)
	{
		super(x_, y_,w_ ,0);
		c = new ClosePopUpView(0,0,w,20); 
		this.subviews.add(c);
		commit = new Button(20,0,150,20,"Save Changes",0,255);
		notApplicable = new Button(200,0,180,20,"Not Applicable, because...",0,255);
		this.subviews.add(commit);
		this.subviews.add(notApplicable);	
		this.parent = parent;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void reset()
	{
		CheckBox c = new CheckBox(0,0,true,false,false,"Positioning",plusIcon,null,"NIC");
		ArrayList a = new ArrayList ();
		a.add(c);

		PopUpSection title = new PopUpSection(0, 0, null, "Mrs. Taylor's Pain Level is not controlled");
		title.setDescription(
			"Evidence Sugests That: BULLET \n " +
				"- A combination of Medication Management, Poitioning and Pain Management has most positive impact on Pain Level\n " +
				"- It is more difficult to control pain when EOL patient has both Pain and Impaired Gas Exchange as problems\n " +
				"- More than 50% of EOL patients do not achieve expected NOC Pain Level by discharge or death.\n ");
		title.separatorStyle = 1;
		//title.setInfoButton("Here is some information insida a tooltip yall");
		
		if(OPTION_EXPANDABLE_POPUP_TEXT) title.enableExpandableDescription();
		
		
		PopUpSection recommended = new PopUpSection(0,0,a,"Recommended Actions: ");

		CheckBox c1 = new CheckBox(10,0,true,false,false,"Energy Conservation",plusIcon,null,"NOC");
		CheckBox c2 = new CheckBox(10,0,true,false,false,"Coping",plusIcon,null,"NOC");
		CheckBox c3 = new CheckBox(10,0,true,false,false,"Pain Controlled Analgesia",plusIcon,null,"NIC");
		CheckBox c4 = new CheckBox(10,0,true,false,false,"Relaxation Therapy",minusIcon,null,"NIC");

		ArrayList a1 = new ArrayList ();
		a1.add(c1);
		a1.add(c2); 
		a1.add(c3);
		a1.add(c4);
		
		PopUpSection alsoConsider = new PopUpSection(0,0,a1,"Also Consider: ");
		subviews.add(title);
		subviews.add(recommended);
		subviews.add(alsoConsider);
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
		noStroke();
		fill(popUpSectionColor);
		rect(0,ys,w,ys+30);
		commit.y = ys;
		notApplicable.y = ys;                
		fill(popUpSectionColor);
		triangle(0, 0, arrowX - x, arrowY - y, 0, ys);
	}
}
