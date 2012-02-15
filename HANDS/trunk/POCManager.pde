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
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void reset()
	{
		
		scrollingView = new ScrollingView(0, 250, SCREEN_WIDTH, SCREEN_HEIGHT - 400);
		mainView.subviews.add(scrollingView);

		impairedGasExchange = new ColouredRowView("Impaired Gas Exchange",firstLevelIcon);
		scrollingView.subs.add(impairedGasExchange);  

		anxietyLevelView = new SecondLevelRowView("Anxiety Level",secondLevelIcon,2,3,impairedGasExchange);
		impairedGasExchange.subs.add(anxietyLevelView);

		musicTherapyView = new ThirdLevelRowView("Music Therapy", thirdLevelIcon,anxietyLevelView);
		anxietyLevelView.subs.add(musicTherapyView);

		calmingTechniqueView = new ThirdLevelRowView("Calming Technique",thirdLevelIcon,anxietyLevelView);
		anxietyLevelView.subs.add(calmingTechniqueView);

		deathAnxietyView = new ColouredRowView("Death Anxiety",firstLevelIcon);
		scrollingView.subs.add(deathAnxietyView);

		anxietySelfControlView = new SecondLevelRowView("Anxiety Self-Control",secondLevelIcon,5,5,deathAnxietyView);
		deathAnxietyView.subs.add(anxietySelfControlView);

		calmingTechniqueView_2 = new ThirdLevelRowView("Calming Technique",thirdLevelIcon,anxietySelfControlView);
		anxietySelfControlView.subs.add(calmingTechniqueView_2);

		spiritualSupportView = new ThirdLevelRowView("Spiritual Support",thirdLevelIcon,anxietySelfControlView);
		anxietySelfControlView.subs.add(spiritualSupportView);

		spiritualSupportView.addComment("Family Priest to Visit 2am");

		acutePainView = new ColouredRowView("Acute Pain",firstLevelIcon);
		scrollingView.subs.add(acutePainView);

		painLevelView = new SecondLevelRowView("Pain Level",secondLevelIcon,1,5,acutePainView);
		acutePainView.subs.add(painLevelView);
		
		medicationManagementView = new ThirdLevelRowView("Medical Management",thirdLevelIcon,painLevelView);
		painLevelView.subs.add(medicationManagementView);

		painManagementView = new ThirdLevelRowView("Pain Management",thirdLevelIcon,painLevelView);
		painLevelView.subs.add(painManagementView);
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
		parentNOC.subs.add(0,temp);
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void addNOC(String text,String comment, ColouredRowView parentNANDA)
	{
		SecondLevelRowView temp = new SecondLevelRowView(text, secondLevelIcon, 0, 0, parentNANDA);
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
	int getBottom()
	{
		return (int)scrollingView.y + (int)scrollingView.h;
	}
}
