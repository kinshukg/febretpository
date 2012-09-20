///////////////////////////////////////////////////////////////////////////////////////////////////
class POCManager
{
	// NANDA lines
	ColouredRowView impairedGasExchange;
	ColouredRowView deathAnxietyView;
	ColouredRowView acutePainView;
	
	// NOC Lines
	SecondLevelRowView anxietyLevelView;
	SecondLevelRowView anxietySelfControlView;
	SecondLevelRowView painLevelView; 
	
	ThirdLevelRowView musicTherapyView;
	ThirdLevelRowView calmingTechniqueView;
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
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void reset()
	{
		scrollingView = new ScrollingView(0, 80, SCREEN_WIDTH - 400, SCREEN_HEIGHT - 100);
		mainView.subviews.add(scrollingView);

		impairedGasExchange = new ColouredRowView("Impaired Gas Exchange",firstLevelIcon);
		impairedGasExchange.iconButton.tooltipImage = IMG_IMP_GAS_EXC;
		scrollingView.subs.add(impairedGasExchange);  

		anxietyLevelView = new SecondLevelRowView("Anxiety Level",secondLevelIcon,3,3,impairedGasExchange);
		//calmingTechniqueView_2.iconButton.tooltipImage = IMG_COMFORTABLE_DEATH;
		impairedGasExchange.subs.add(anxietyLevelView);

		musicTherapyView = new ThirdLevelRowView("Music Therapy", thirdLevelIcon,anxietyLevelView);
		//calmingTechniqueView_2.iconButton.tooltipImage = IMG_COMFORTABLE_DEATH;
		anxietyLevelView.subs.add(musicTherapyView);

		calmingTechniqueView = new ThirdLevelRowView("Calming Technique",thirdLevelIcon,anxietyLevelView);
		anxietyLevelView.subs.add(calmingTechniqueView);

		deathAnxietyView = new ColouredRowView("Death Anxiety",firstLevelIcon);
		deathAnxietyView.iconButton.tooltipImage = IMG_DEATH_ANXIETY;
		scrollingView.subs.add(deathAnxietyView);

		anxietySelfControlView = new SecondLevelRowView("Comfortable Death",secondLevelIcon,2,5,deathAnxietyView);
		anxietySelfControlView.iconButton.tooltipImage = IMG_COMFORTABLE_DEATH;
		deathAnxietyView.subs.add(anxietySelfControlView);

		calmingTechniqueView_2 = new ThirdLevelRowView("Calming Technique",thirdLevelIcon,anxietySelfControlView);
		//calmingTechniqueView_2.iconButton.tooltipImage = IMG_COMFORTABLE_DEATH;
		anxietySelfControlView.subs.add(calmingTechniqueView_2);

		spiritualSupportView = new ThirdLevelRowView("Spiritual Support",thirdLevelIcon,anxietySelfControlView);
		//spiritualSupportView
		anxietySelfControlView.subs.add(spiritualSupportView);

		spiritualSupportView.addComment("Family Priest to Visit 2am");

		acutePainView = new ColouredRowView("Acute Pain",firstLevelIcon);
		acutePainView.iconButton.tooltipImage = IMG_ACUTE_PAIN;
		scrollingView.subs.add(acutePainView);

		painLevelView = new SecondLevelRowView("Pain Level",secondLevelIcon,1,5,acutePainView);
		//
		acutePainView.subs.add(painLevelView);
		
		medicationManagementView = new ThirdLevelRowView("Medical Management",thirdLevelIcon,painLevelView);
		//
		painLevelView.subs.add(medicationManagementView);

		painManagementView = new ThirdLevelRowView("Pain Management",thirdLevelIcon,painLevelView);
		//painManagementView
		painLevelView.subs.add(painManagementView);
		
		// Cycle 2 stuff
		nandaInterruptedFamilyProcess = new ColouredRowView("Interrupted Family Processes", firstLevelIcon);
		nandaInterruptedFamilyProcess.iconButton.tooltipImage = IMG_INTERRUPTED_FAMILY_PROCESS;

		nocFamilyCoping = new SecondLevelRowView("Family Coping", secondLevelIcon, 0, 0, nandaInterruptedFamilyProcess);
		nocFamilyCoping.iconButton.tooltipImage = IMG_FAMILY_COPING;
		nandaInterruptedFamilyProcess.subs.add(nocFamilyCoping);
		
		nicFamilySupport = new ThirdLevelRowView("Family Support", thirdLevelIcon, nocFamilyCoping);
		nicFamilySupport.iconButton.tooltipImage = IMG_FAMILY_SUPPORT;
		nocFamilyCoping.subs.add(nicFamilySupport);
		
		nicFamilyIntegrityPromotion = new ThirdLevelRowView("Family Integrity Promotion", thirdLevelIcon, nocFamilyCoping);
		nicFamilyIntegrityPromotion.iconButton.tooltipImage = IMG_FAMILY_INTEGRITY_PROMOTION;
		nocFamilyCoping.subs.add(nicFamilyIntegrityPromotion);
		
		nicEducationEOL = new ThirdLevelRowView("Health Education: End Of Life Process", thirdLevelIcon, nocFamilyCoping);
		nicEducationEOL.iconButton.tooltipImage = IMG_HEALTH_EDUCATION;
		nocFamilyCoping.subs.add(nicEducationEOL);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void addNIC(String text, String comment,SecondLevelRowView parentNOC)
	{
		ThirdLevelRowView temp = new ThirdLevelRowView(text,thirdLevelIcon,parentNOC);
		if(comment.length() != 0) temp.addComment(comment);
				
		for(int k =0 ; k < parentNOC.subs.size();k++)
		{
			ThirdLevelRowView tempo = (ThirdLevelRowView)parentNOC.subs.get(k);
                   	tempo.y = temp.y+((k+1)*temp.h);
		}
		//mainView.subviews.add(medicationManagementView);
		parentNOC.subs.add(temp);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void addNOC(String text,String comment, ColouredRowView parentNANDA)
	{
		SecondLevelRowView temp = new SecondLevelRowView(text, secondLevelIcon, 0, 0, parentNANDA);
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
		parentNANDA.subs.add(0,temp);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void deleteNANDA(ColouredRowView nanda)
	{
		nanda.markDeleted();
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
