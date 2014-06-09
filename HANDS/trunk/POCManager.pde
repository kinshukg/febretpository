class POCManager
{
	ScrollingView scrollingView;
    
    // Native interface pick list popups.
    NANDAPickList NANDAPopup;
    NOCPickList NOCPopup;
    NICPickList NICPopup;
    
    // Stashed NOCs that have CDS popups (so we don't really delete them.)
    HashMap<String, SecondLevelRowView> stashedNOCS;
	
    // Cycle 4
    // These variables keep track of the user 'achievements'
    // that is, the desired actions takes on the patient plan of care.
    boolean achPositioningAdded = false;
    boolean achPainPrioritized = false;
    boolean achPalliativeConsultAdded = false;
    boolean achFamilyCopingAdded = false;
    
	///////////////////////////////////////////////////////////////////////////////////////////////
	void reset()
	{
        stashedNOCS = new HashMap<String, SecondLevelRowView>();
        
		scrollingView = new ScrollingView(0, 80, SCREEN_WIDTH - 400, SCREEN_HEIGHT - 100);
        NANDAPopup = new NANDAPickList(this);
        NOCPopup = new NOCPickList(this);
        NICPopup = new NICPickList(this);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	ColouredRowView addNANDA(String title, PImage tooltip)
	{
        ColouredRowView row = new ColouredRowView(title,firstLevelIcon);
        row.poc = this;
        row.iconButton.tooltipImage = tooltip;
        addNANDA(row);
        return row;
    }
    
	///////////////////////////////////////////////////////////////////////////////////////////////
	ThirdLevelRowView addNIC(String text, String comment,SecondLevelRowView parentNOC, PImage tooltip)
	{
        print(text);
        // check achievements
        if(text.equals("Positioning")) achPositioningAdded = true;
        else if(text.equals("Consultation: Palliative Care"))
        {
            print("SDDSD");
            achPalliativeConsultAdded = true;
        }
        //else if(text.equals("Family Coping")) achFamilyCopingAdded = true;
        
		ThirdLevelRowView temp = new ThirdLevelRowView(text,thirdLevelIcon,parentNOC);
		temp.iconButton.tooltipImage = tooltip;
		if(comment.length() != 0) temp.addComment(comment);
				
		for(int k =0 ; k < parentNOC.subs.size();k++)
		{
			ThirdLevelRowView tempo = (ThirdLevelRowView)parentNOC.subs.get(k);
                   	tempo.y = temp.y+((k+1)*temp.h);
		}
        
        parentNOC.onNICAdded(temp);
        NICPopup.onNICAdded(temp);
        
		return temp;
		//mainView.subviews.add(medicationManagementView);
		//parentNOC.subs.add(temp);
	}
	
	////////////////////////////////////////////////////////////////////////////
	void removeNIC(ThirdLevelRowView nic)
	{
        // check achievements
        if(nic.title.equals("Positioning")) achPositioningAdded = false;
        else if(nic.title.equals("Palliative Care Consult")) achPalliativeConsultAdded = false;
        else if(nic.title.equals("Family Coping")) achFamilyCopingAdded = false;
        
        nic.parent.subs.remove(nic);
        
        nic.parent.onNICRemoved(nic);
        NICPopup.onNICRemoved(nic);
    }
    
	////////////////////////////////////////////////////////////////////////////
	void removeNOC(SecondLevelRowView noc)
	{
        ArrayList tmpsubs = (ArrayList)noc.subs.clone();
        // Remove all the NICs in this NOC
        for (int j = 0; j < tmpsubs.size(); j++) 
        {
            ThirdLevelRowView nic = (ThirdLevelRowView)tmpsubs.get(j);
            print("removing " + nic.title);
            removeNIC(nic);
        }
        
        noc.parent.subs.remove(noc);
        
        // If this NOC had a CDS action popup, don't really delete it..
        // stash it so it can be restored later.
        if(noc.actionPopUp != null)
        {
            stashedNOCS.put(noc.title, noc);
        }
        
        //nic.parent.onNICRemoved(nic);
        NOCPopup.onNOCRemoved(noc);
    }
    
	///////////////////////////////////////////////////////////////////////////////////////////////
	SecondLevelRowView addNOC(String text,String comment, ColouredRowView parentNANDA, PImage tooltip)
	{
        SecondLevelRowView temp = null;
        // If we have a stashed NOC with this name, just restore it.
        if(stashedNOCS.containsKey(text))
        {
            temp = stashedNOCS.get(text);
            stashedNOCS.remove(temp);
            parentNANDA.subs.add(temp);
        }
        else
        {
            temp = new SecondLevelRowView(text, secondLevelIcon, 0, 0, parentNANDA, this);
            temp.iconButton.tooltipImage = tooltip;
            if(comment.length() != 0) temp.addComment(comment);
            //mainView.subviews.add(medicationManagementView);
            //parentNANDA.subs.add(0,temp);
            // Enable rating buttons
            //temp.enableCurrentRatingButton();
            temp.enableExpectedRatingButton();
        }
        for(int k =0 ; k < parentNANDA.subs.size();k++)
        {
            SecondLevelRowView tempo = (SecondLevelRowView)parentNANDA.subs.get(k);
                       tempo.y = temp.y+((k+1)*temp.h);
        }
		
		return temp;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void deleteNANDA(ColouredRowView nanda)
	{
		nanda.markDeleted();
		scrollingView.subs.remove(nanda);
		scrollingView.subs.add(nanda);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void prioritizeNANDA(ColouredRowView nanda)
	{
        PopUpViewBase popup = getNOC("Acute Pain", "Pain Level").actionPopUp;
        CheckBox prioritizePainAction = popup.findAction("Prioritize Acute Pain");
        // check achievements
        if(nanda.title.equals("Acute Pain"))
        {        
            achPainPrioritized = true;
            prioritizePainAction.enabled = false;
            prioritizePainAction.selected = false;
            // We are removing an actionable item from CDS. Should we hide the CDS?
            popup.checkCDSEnabled(true);
        }
        else
        {
            // If we prioritized anything else, Acute Pain is not prioritized anymore.
            achPainPrioritized = false;
            prioritizePainAction.enabled = true;
            prioritizePainAction.selected = false;
            // We are adding an actionable item to the CDS. Should we hide the CDS?
            popup.checkCDSEnabled(false);
        }
        
		scrollingView.subs.remove(nanda);
		scrollingView.subs.add(0, nanda);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void addNANDA(ColouredRowView nanda)
	{
		scrollingView.subs.add(nanda);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	ColouredRowView getNANDA(String title)
	{
		for (int i = 0; i < scrollingView.subs.size(); i++ ) 
		{
			ColouredRowView tempRow = (ColouredRowView) scrollingView.subs.get(i);
            if(tempRow.title.equals(title)) return tempRow;
        }
        print("POCManager::getNANDA - could not find NANDA row titled " + title);
        return null;
	}
    
	///////////////////////////////////////////////////////////////////////////////////////////////
    SecondLevelRowView getNOC(String NANDATitle, String NOCTitle)
	{
        ColouredRowView nanda = getNANDA(NANDATitle);
        if(nanda != null)
        {
            //print("NANDA subs: " + nanda.subs.size());
            for (int i = 0; i < nanda.subs.size(); i++ ) 
            {
                SecondLevelRowView tempRow = (SecondLevelRowView) nanda.subs.get(i);
                //print("NANDA subs: " + tempRow.title);
                if(tempRow.title.equals(NOCTitle)) return tempRow;
            }
        }
        print("POCManager::getNOC - could not find NOC row titled " + NOCTitle);
        return null;
	}
    
	///////////////////////////////////////////////////////////////////////////////////////////////
	int getBottom()
	{
		return (int)scrollingView.y + (int)scrollingView.h;
	}
}
