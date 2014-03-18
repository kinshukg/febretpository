///////////////////////////////////////////////////////////////////////////////////////////////////
class POCManager
{
	// Impaired Gas Exchange Section
	// ColouredRowView impairedGasExchange;
	// SecondLevelRowView respiratoryStatusView;
	// ThirdLevelRowView acidBaseView;
	// ThirdLevelRowView bedsideLaboratoryView;
	// ThirdLevelRowView airwayManagementView;
	
	ScrollingView scrollingView;
	
	// Cycle 2
	
	// Family coping stuff
	// ColouredRowView nandaInterruptedFamilyProcess;
	// SecondLevelRowView nocFamilyCoping;
	// ThirdLevelRowView nicFamilySupport;
	// ThirdLevelRowView nicFamilyIntegrityPromotion;
	// ThirdLevelRowView nicEducationEOL;
	
	// Cycle 3
	
	// Impaired Physical Mobility Section
	// ColouredRowView NANDAImpairedPhysicalMobility;
	// SecondLevelRowView NOCMobility;
	// ThirdLevelRowView NICFallPrevention;
	// ThirdLevelRowView NICEnergyConservation;
	
	// SecondLevelRowView NOCImmobilityConsequences;
    
    // Cycle 4
    // These variables keep track of the user 'achievements'
    // that is, the desired actions takes on the patient plan of care.
    boolean achPositioningAdded = false;
    boolean achPainPrioritized = false;
    boolean achPalliativeConsultAdded = false;
    
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void reset()
	{
		scrollingView = new ScrollingView(0, 80, SCREEN_WIDTH - 400, SCREEN_HEIGHT - 100);
		//mainView.subviews.add(scrollingView);

		// Impaired Gas Exchange Section
		// impairedGasExchange = new ColouredRowView("Impaired Gas Exchange",firstLevelIcon);
		// impairedGasExchange.iconButton.tooltipImage = IMG_IMP_GAS_EXC;
		// scrollingView.subs.add(impairedGasExchange);
		
		// respiratoryStatusView = new SecondLevelRowView("Respiratory Status: Gas Exchange",secondLevelIcon,2,3,impairedGasExchange, this);
		// respiratoryStatusView.iconButton.tooltipImage = IMG_RESPIRATORY_STATUS_GAS_EXCHANGE;

		// acidBaseView = new ThirdLevelRowView("Acid-Base Monitoring", thirdLevelIcon,respiratoryStatusView);
		// acidBaseView.iconButton.tooltipImage = IMG_ACID_BASE_MONITORING;

		// bedsideLaboratoryView = new ThirdLevelRowView("Bedside Laboratory Testing",thirdLevelIcon,respiratoryStatusView);
		// bedsideLaboratoryView.iconButton.tooltipImage = IMG_BEDSIDE_LABORATORY_TESTING;

		// airwayManagementView = new ThirdLevelRowView("Airway Management",thirdLevelIcon,respiratoryStatusView);
		// airwayManagementView.iconButton.tooltipImage = IMG_AIRWAY_MANAGEMENT;
		
		// Cycle 2 stuff
		// nandaInterruptedFamilyProcess = new ColouredRowView("Interrupted Family Processes", firstLevelIcon);
		// nandaInterruptedFamilyProcess.iconButton.tooltipImage = IMG_INTERRUPTED_FAMILY_PROCESS;

		// nocFamilyCoping = new SecondLevelRowView("Family Coping", secondLevelIcon, 0, 0, nandaInterruptedFamilyProcess, this);
		// nocFamilyCoping.iconButton.tooltipImage = IMG_FAMILY_COPING;
		// nocFamilyCoping.enableCurrentRatingButton();
		// nocFamilyCoping.enableExpectedRatingButton();
		
		// nicFamilySupport = new ThirdLevelRowView("Family Support", thirdLevelIcon, nocFamilyCoping);
		// nicFamilySupport.iconButton.tooltipImage = IMG_FAMILY_SUPPORT;
		
		// nicFamilyIntegrityPromotion = new ThirdLevelRowView("Family Integrity Promotion", thirdLevelIcon, nocFamilyCoping);
		// nicFamilyIntegrityPromotion.iconButton.tooltipImage = IMG_FAMILY_INTEGRITY_PROMOTION;
		
		// nicEducationEOL = new ThirdLevelRowView("Health Education: End Of Life Process", thirdLevelIcon, nocFamilyCoping);
		// nicEducationEOL.iconButton.tooltipImage = IMG_HEALTH_EDUCATION;
		
		// Cycle 3 stuff
		// NANDAImpairedPhysicalMobility =  new ColouredRowView("Impaired Physical Mobility", firstLevelIcon);
		// NANDAImpairedPhysicalMobility.iconButton.tooltipImage = IMG_IMPAIRED_PHYSICAL_MOBILITY;
		// scrollingView.subs.add(NANDAImpairedPhysicalMobility);

		// NOCMobility = addNOC("Mobility", "", NANDAImpairedPhysicalMobility, IMG_MOBILITY);
		// NICFallPrevention = addNIC("Fall Prevention", "", NOCMobility, IMG_FALL_PREVENTION);
		// NICEnergyConservation = addNIC("Energy Conservation", "", NOCMobility, IMG_ENERGY_CONSERVATION);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	ColouredRowView addNANDA(String title, PImage tooltip)
	{
        ColouredRowView row = new ColouredRowView(title,firstLevelIcon);
        row.iconButton.tooltipImage = tooltip;
        addNANDA(row);
        return row;
    }
    
	///////////////////////////////////////////////////////////////////////////////////////////////
	ThirdLevelRowView addNIC(String text, String comment,SecondLevelRowView parentNOC, PImage tooltip)
	{
        // check achievements
        if(text.equals("Positioning")) achPositioningAdded = true;
        else if(text.equals("Palliative Care Consult")) achPalliativeConsultAdded = true;
        
		ThirdLevelRowView temp = new ThirdLevelRowView(text,thirdLevelIcon,parentNOC);
		temp.iconButton.tooltipImage = tooltip;
		if(comment.length() != 0) temp.addComment(comment);
				
		for(int k =0 ; k < parentNOC.subs.size();k++)
		{
			ThirdLevelRowView tempo = (ThirdLevelRowView)parentNOC.subs.get(k);
                   	tempo.y = temp.y+((k+1)*temp.h);
		}
		return temp;
		//mainView.subviews.add(medicationManagementView);
		//parentNOC.subs.add(temp);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	SecondLevelRowView addNOC(String text,String comment, ColouredRowView parentNANDA, PImage tooltip)
	{
		SecondLevelRowView temp = new SecondLevelRowView(text, secondLevelIcon, 0, 0, parentNANDA, this);
		temp.iconButton.tooltipImage = tooltip;
		
		if(comment.length() != 0) temp.addComment(comment);
					
		for(int k =0 ; k < parentNANDA.subs.size();k++)
		{
			SecondLevelRowView tempo = (SecondLevelRowView)parentNANDA.subs.get(k);
                       tempo.y = temp.y+((k+1)*temp.h);
		}
		//mainView.subviews.add(medicationManagementView);
		//parentNANDA.subs.add(0,temp);
		
		// Enable rating buttons
		temp.enableCurrentRatingButton();
		temp.enableExpectedRatingButton();
		
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
        // check achievements
        if(nanda.title.equals("Acute Pain")) achPainPrioritized = true;
        
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
