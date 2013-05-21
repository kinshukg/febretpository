///////////////////////////////////////////////////////////////////////////////////////////////////
class POCManager
{
	// Impaired Gas Exchange Section
	ColouredRowView impairedGasExchange;
	SecondLevelRowView respiratoryStatusView;
	ThirdLevelRowView acidBaseView;
	ThirdLevelRowView bedsideLaboratoryView;
	ThirdLevelRowView airwayManagementView;
	
	// NANDA lines
	ColouredRowView deathAnxietyView;
	ColouredRowView acutePainView;
	
	// NOC Lines
	SecondLevelRowView anxietySelfControlView;
	SecondLevelRowView painLevelView; 
	
	ThirdLevelRowView calmingTechniqueView_2; 
	ThirdLevelRowView spiritualSupportView;
	ThirdLevelRowView medicationManagementView;
	ThirdLevelRowView painManagementView;
	ScrollingView scrollingView;
	
	// Cycle 2
	
	// Family coping stuff
	ColouredRowView nandaInterruptedFamilyProcess;
	SecondLevelRowView nocFamilyCoping;
	ThirdLevelRowView nicFamilySupport;
	ThirdLevelRowView nicFamilyIntegrityPromotion;
	ThirdLevelRowView nicEducationEOL;
	
	// Cycle 3
	
	// Impaired Physical Mobility Section
	ColouredRowView NANDAImpairedPhysicalMobility;
	SecondLevelRowView NOCMobility;
	ThirdLevelRowView NICFallPrevention;
	ThirdLevelRowView NICEnergyConservation;
	
	SecondLevelRowView NOCImmobilityConsequences;
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void reset()
	{
		scrollingView = new ScrollingView(0, 80, SCREEN_WIDTH - 400, SCREEN_HEIGHT - 100);
		mainView.subviews.add(scrollingView);

		// Impaired Gas Exchange Section
		impairedGasExchange = new ColouredRowView("Impaired Gas Exchange",firstLevelIcon);
		impairedGasExchange.iconButton.tooltipImage = IMG_IMP_GAS_EXC;
		scrollingView.subs.add(impairedGasExchange);
		
		respiratoryStatusView = new SecondLevelRowView("Respiratory Status: Gas Exchange",secondLevelIcon,2,3,impairedGasExchange);
		respiratoryStatusView.iconButton.tooltipImage = IMG_RESPIRATORY_STATUS_GAS_EXCHANGE;

		acidBaseView = new ThirdLevelRowView("Acid-Base Monitoring", thirdLevelIcon,respiratoryStatusView);
		acidBaseView.iconButton.tooltipImage = IMG_ACID_BASE_MONITORING;

		bedsideLaboratoryView = new ThirdLevelRowView("Bedside Laboratory Testing",thirdLevelIcon,respiratoryStatusView);
		bedsideLaboratoryView.iconButton.tooltipImage = IMG_BEDSIDE_LABORATORY_TESTING;

		airwayManagementView = new ThirdLevelRowView("Airway Management",thirdLevelIcon,respiratoryStatusView);
		airwayManagementView.iconButton.tooltipImage = IMG_AIRWAY_MANAGEMENT;
		
		// Death Anxiety Section
		deathAnxietyView = new ColouredRowView("Death Anxiety",firstLevelIcon);
		deathAnxietyView.iconButton.tooltipImage = IMG_DEATH_ANXIETY;
		scrollingView.subs.add(deathAnxietyView);

		anxietySelfControlView = new SecondLevelRowView("Comfortable Death",secondLevelIcon,2,5,deathAnxietyView);
		anxietySelfControlView.iconButton.tooltipImage = IMG_COMFORTABLE_DEATH;

		calmingTechniqueView_2 = new ThirdLevelRowView("Calming Technique",thirdLevelIcon,anxietySelfControlView);
		calmingTechniqueView_2.iconButton.tooltipImage = IMG_CALMING_TECHNIQUE;

		spiritualSupportView = new ThirdLevelRowView("Spiritual Support",thirdLevelIcon,anxietySelfControlView);
		spiritualSupportView.iconButton.tooltipImage = IMG_SPIRITUAL_SUPPORT;

		spiritualSupportView.addComment("Family Priest to Visit 2am");

		acutePainView = new ColouredRowView("Acute Pain",firstLevelIcon);
		acutePainView.iconButton.tooltipImage = IMG_ACUTE_PAIN;
		scrollingView.subs.add(acutePainView);

		painLevelView = new SecondLevelRowView("Pain Level",secondLevelIcon,1,5,acutePainView);
		painLevelView.iconButton.tooltipImage = IMG_PAIN_LEVEL;
		//acutePainView.subs.add(painLevelView);
		
		medicationManagementView = new ThirdLevelRowView("Medication Management",thirdLevelIcon,painLevelView);
		medicationManagementView.iconButton.tooltipImage = IMG_MEDICATION_MANAGEMENT;
		//painLevelView.subs.add(medicationManagementView);

		painManagementView = new ThirdLevelRowView("Pain Management",thirdLevelIcon,painLevelView);
		painManagementView.iconButton.tooltipImage = IMG_PAIN_MANAGEMENT;
		//painLevelView.subs.add(painManagementView);
		
		// Cycle 2 stuff
		nandaInterruptedFamilyProcess = new ColouredRowView("Interrupted Family Processes", firstLevelIcon);
		nandaInterruptedFamilyProcess.iconButton.tooltipImage = IMG_INTERRUPTED_FAMILY_PROCESS;

		nocFamilyCoping = new SecondLevelRowView("Family Coping", secondLevelIcon, 0, 0, nandaInterruptedFamilyProcess);
		nocFamilyCoping.iconButton.tooltipImage = IMG_FAMILY_COPING;
		nocFamilyCoping.enableCurrentRatingButton();
		nocFamilyCoping.enableExpectedRatingButton();
		
		nicFamilySupport = new ThirdLevelRowView("Family Support", thirdLevelIcon, nocFamilyCoping);
		nicFamilySupport.iconButton.tooltipImage = IMG_FAMILY_SUPPORT;
		
		nicFamilyIntegrityPromotion = new ThirdLevelRowView("Family Integrity Promotion", thirdLevelIcon, nocFamilyCoping);
		nicFamilyIntegrityPromotion.iconButton.tooltipImage = IMG_FAMILY_INTEGRITY_PROMOTION;
		
		nicEducationEOL = new ThirdLevelRowView("Health Education: End Of Life Process", thirdLevelIcon, nocFamilyCoping);
		nicEducationEOL.iconButton.tooltipImage = IMG_HEALTH_EDUCATION;
		
		// Cycle 3 stuff
		NANDAImpairedPhysicalMobility =  new ColouredRowView("Impaired Physical Mobility", firstLevelIcon);
		NANDAImpairedPhysicalMobility.iconButton.tooltipImage = IMG_IMPAIRED_PHYSICAL_MOBILITY;
		scrollingView.subs.add(NANDAImpairedPhysicalMobility);

		NOCMobility = addNOC("Mobility", "", NANDAImpairedPhysicalMobility, IMG_MOBILITY);
		NICFallPrevention = addNIC("Fall Prevention", "", NOCMobility, IMG_FALL_PREVENTION);
		NICEnergyConservation = addNIC("Energy Conservation", "", NOCMobility, IMG_ENERGY_CONSERVATION);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	ThirdLevelRowView addNIC(String text, String comment,SecondLevelRowView parentNOC, PImage tooltip)
	{
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
		SecondLevelRowView temp = new SecondLevelRowView(text, secondLevelIcon, 0, 0, parentNANDA);
		temp.iconButton.tooltipImage = tooltip;
		GraphPopUpView gp = new GraphPopUpView(500, temp);
		gp.reset(emptyTrend);
		temp.setGraphButton(0, emptySmallGraph, gp, 750); 
		
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
		scrollingView.subs.remove(nanda);
		scrollingView.subs.add(0, nanda);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void addNANDA(ColouredRowView nanda)
	{
		scrollingView.subs.add(nanda);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	int getBottom()
	{
		return (int)scrollingView.y + (int)scrollingView.h;
	}
}
