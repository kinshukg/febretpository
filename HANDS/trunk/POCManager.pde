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
    boolean achDeathAnxietyPrioritized = false;
    boolean achFamilyCopingAdded = false;
    boolean achPalliativeConsultAdded = false;
    boolean achRespiratoryMonitoringAdded = false;
    
	////////////////////////////////////////////////////////////////////////////
	void nextShift()
	{
        // Update previous rating for all NOC rows.
		for (int i = 0; i < scrollingView.subs.size(); i++ ) 
		{
			ColouredRowView tempRow = (ColouredRowView) scrollingView.subs.get(i);
			for (int j = 0; j < tempRow.subs.size(); j++ ) 
			{
				SecondLevelRowView tempRow2 = (SecondLevelRowView) tempRow.subs.get(j);
                tempRow2.previousRating = tempRow2.firstColumn;
                
                // If NOC row has a delayed enable CDS popup, enable it now.
                if(tempRow2.actionPopUp != null && tempRow2.actionPopUp.delayedEnable)
                {
                    tempRow2.actionPopUp.delayedEnable = false;
                    tempRow2.actionPopUp.checkCDSEnabled(false);
                }
            }
        }
	}
	
	////////////////////////////////////////////////////////////////////////////
	void reset()
	{
        stashedNOCS = new HashMap<String, SecondLevelRowView>();
        
		scrollingView = new ScrollingView(0, 80, SCREEN_WIDTH - 400, SCREEN_HEIGHT - 100);
        NANDAPopup = new NANDAPickList(this);
        NOCPopup = new NOCPickList(this);
        NICPopup = new NICPickList(this);
	}
	
	////////////////////////////////////////////////////////////////////////////
	ColouredRowView addNANDA(String title, PImage tooltip)
	{
        ColouredRowView row = new ColouredRowView(title,firstLevelIcon);
        row.poc = this;
        row.iconButton.tooltipImage = tooltip;
        addNANDA(row);
        
        log("AddNANDA " + title);
        
        return row;
    }
    
	////////////////////////////////////////////////////////////////////////////
	ThirdLevelRowView addNIC(String text, String comment,SecondLevelRowView parentNOC, PImage tooltip)
	{
        //print(text);
        // check achievements
        if(text.equals("Positioning")) achPositioningAdded = true;
        else if(text.equals("Consultation: Palliative Care")) achPalliativeConsultAdded = true;
        else if(text.equals("Respiratory Monitoring")) achRespiratoryMonitoringAdded = true;
        else if(text.equals("Family Coping")) achFamilyCopingAdded = true;
        
		ThirdLevelRowView temp = new ThirdLevelRowView(text,thirdLevelIcon,parentNOC);
		temp.iconButton.tooltipImage = tooltip;
		if(comment.length() != 0) temp.addComment(comment);
				
		for(int k =0 ; k < parentNOC.subs.size();k++)
		{
			ThirdLevelRowView tempo = (ThirdLevelRowView)parentNOC.subs.get(k);
                   	tempo.y = temp.y+((k+1)*temp.h);
		}
        
        // Notify all NOC rows of NIC added
		for (int i = 0; i < scrollingView.subs.size(); i++ ) 
		{
			ColouredRowView tempRow = (ColouredRowView) scrollingView.subs.get(i);
			for (int j = 0; j < tempRow.subs.size(); j++ ) 
			{
				SecondLevelRowView tempRow2 = (SecondLevelRowView) tempRow.subs.get(j);
                tempRow2.onNICAdded(temp);
            }
        }
        
        NICPopup.onNICAdded(temp);
        
        log("AddNIC " + text);
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
        else if(nic.title.equals("Respiratory Monitoring")) achRespiratoryMonitoringAdded = false;
        
        nic.parent.subs.remove(nic);
        
        // Notify all NOC rows of NIC added
		for (int i = 0; i < scrollingView.subs.size(); i++ ) 
		{
			ColouredRowView tempRow = (ColouredRowView) scrollingView.subs.get(i);
			for (int j = 0; j < tempRow.subs.size(); j++ ) 
			{
				SecondLevelRowView tempRow2 = (SecondLevelRowView) tempRow.subs.get(j);
                tempRow2.onNICRemoved(nic);
            }
        }
        NICPopup.onNICRemoved(nic);
        
        log("RemoveNIC " + nic.title);
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
        
        log("RemoveNOC " + noc.title);
    }
    
	////////////////////////////////////////////////////////////////////////////
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
        
        NOCPopup.onNOCAdded(temp);
		
        log("AddNOC " + text);
        
		return temp;
	}
	
	////////////////////////////////////////////////////////////////////////////
	void deleteNANDA(ColouredRowView nanda)
	{
		nanda.markDeleted();
		scrollingView.subs.remove(nanda);
		scrollingView.subs.add(nanda);
        
        log("RemoveNANDA " + nanda.title);
	}
	
	////////////////////////////////////////////////////////////////////////////
	void restoreNANDA(ColouredRowView nanda)
	{
        nanda.deleted = false;
        if(nanda.popup != null)
        {
            nanda.popup.onNANDAAdded(nanda);
        }
        
        log("RestoreNANDA " + nanda.title);
	}
	
	////////////////////////////////////////////////////////////////////////////
	void prioritizeNANDA(ColouredRowView nanda)
	{
        // check achievements
        if(nanda.title.equals("Acute Pain"))
        {        
            achPainPrioritized = true;
            achDeathAnxietyPrioritized = false;
        }
        else if(nanda.title.equals("Death Anxiety"))
        {    
            achDeathAnxietyPrioritized = true;
            achPainPrioritized = false;
        }
        else
        {
            achDeathAnxietyPrioritized = false;
            achPainPrioritized = false;
        }
        
        PopUpViewBase popup = getNOC("Acute Pain", "Pain Level").actionPopUp;
        if(popup != null)
        {
            CheckBox prioritizePainAction = popup.findAction("Prioritize Acute Pain");
            if(prioritizePainAction != null)
            {
                // check achievements
                if(nanda.title.equals("Acute Pain"))
                {        
                    prioritizePainAction.enabled = false;
                    prioritizePainAction.selected = false;
                    // We are removing an actionable item from CDS. Should we hide the CDS?
                    popup.checkCDSEnabled(true);
                }
                else
                {
                    // If we prioritized anything else, Acute Pain is not prioritized anymore.
                    prioritizePainAction.enabled = true;
                    prioritizePainAction.selected = false;
                    // We are adding an actionable item to the CDS. Should we hide the CDS?
                    popup.checkCDSEnabled(false);
                }
            }
        }
        popup = getNOC("Death Anxiety", "Comfortable Death").actionPopUp;
        if(popup != null)
        {
            // check achievements
            if(nanda.title.equals("Death Anxiety"))
            {        
                popup.checkCDSEnabled(true);
            }
            else
            {
                popup.checkCDSEnabled(false);
            }
        }        
        
		scrollingView.subs.remove(nanda);
		scrollingView.subs.add(0, nanda);
        
        log("PrioritizeNANDA " + nanda.title);
	}
	
	////////////////////////////////////////////////////////////////////////////
	void addNANDA(ColouredRowView nanda)
	{
		scrollingView.subs.add(nanda);
        if(nanda.title.equals("Dysfunctional Family Processes")) achFamilyCopingAdded = true;
        NANDAPopup.onNANDAAdded(nanda);
	}
	
	////////////////////////////////////////////////////////////////////////////
	ColouredRowView getNANDA(String title)
	{
		for (int i = 0; i < scrollingView.subs.size(); i++ ) 
		{
			ColouredRowView tempRow = (ColouredRowView) scrollingView.subs.get(i);
            if(tempRow.title.equals(title)) return tempRow;
        }
        print("POCManager::getNANDA - could not find NANDA row titled " + title + "\n");
        return null;
	}
    
	////////////////////////////////////////////////////////////////////////////
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
        if(stashedNOCS.containsKey(NOCTitle))
        {
            return stashedNOCS.get(NOCTitle);
        }
        print("POCManager::getNOC - could not find NOC row titled " + NOCTitle + "\n");
        return null;
	}
    
	////////////////////////////////////////////////////////////////////////////
	int getBottom()
	{
		return (int)scrollingView.y + (int)scrollingView.h;
	}
}
