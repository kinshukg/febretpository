///////////////////////////////////////////////////////////////////////////////////////////////////
class RatingPopUpView extends PopUpViewBase
{
	PImage indicatorsImage;
	
	PopUpSection expectedRatingSection;
	PopUpSection currentRatingSection;

	ArrayList<CheckBox> currentRatings;
	ArrayList<CheckBox> expectedRatings;
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	RatingPopUpView(SecondLevelRowView parent, PImage image)
	{
		super(image.width > 650 ? image.width +50 : 700, parent);
		
		indicatorsImage = image;
		
		currentRatings = new ArrayList<CheckBox>();
		expectedRatings = new ArrayList<CheckBox>();
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void reset()
	{
		PopUpSection title = new PopUpSection("");
		title.setImage(indicatorsImage);
		title.centerImage = false;
		subviews.add(title);
		
		// Expected rating checkboxes
		expectedRatingSection = new PopUpSection("Expected Rating:");
		expectedRatingSection.layoutHorizontal = true;
	
		for(int i = 1; i <= 5; i++)
		{
			CheckBox ratingCheckbox = new CheckBox(str(i), null, 0);
			expectedRatingSection.addAction(ratingCheckbox);
			ratingCheckbox.radio = true;
			ratingCheckbox.textBoxEnabled = false;
			ratingCheckbox.w = 20;
			expectedRatings.add(ratingCheckbox);
		}
		subviews.add(expectedRatingSection);
		
		// Current rating checkboxes
		currentRatingSection = new PopUpSection("Current Rating:");
		currentRatingSection.layoutHorizontal = true;
		for(int i = 1; i <= 5; i++)
		{
			CheckBox ratingCheckbox = new CheckBox(str(i), null, 0);
			currentRatingSection.addAction(ratingCheckbox);
			ratingCheckbox.radio = true;
			ratingCheckbox.textBoxEnabled = false;
			ratingCheckbox.w = 20;
			currentRatings.add(ratingCheckbox);
		}
		subviews.add(currentRatingSection);
		
		// String expectedRatingTutorial =
			// "Setting an Expected NOC Rating: <l> \n " +
			// "1. <h> Review definition of <b> NOC </h> : " + parent.title + " </b> and current patient status. \n " +
			// "2. Identify the patient's expected rating where a rating of 5 is comparable to a healthy patient of similar age, gender, and cognition. \n " +
			// "3. Select a rating (1-5) that best represents patient's expected status at discharge from the unit. \n ";
			
		// String currentRatingTutorial =
			// "Setting a Current NOC Rating: <l> \n " +
			// "1. Review definition of <b> NOC: " + parent.title + " </b> and current patient status. \n " +
			// "2. Identify the patient's expected rating where a rating of 5 is comparable to a healthy patient of similar age, gender, and cognition. \n " +
			// "3. Select a rating (1-5) that best represents patient's expected status at the end of every shift. \n ";
		
		String expectedRatingTutorial =
			"<b> Rules for Setting an Expected NOC Rating: </b> <l> \n " +
			"1. Review the NOC <h> <b> Definition </b> </h> \n " +
			"2. Review the NOC <h> <b> Indicators </b> </h> \n " +
			"3. Select NOC rating (1-5) expected of patient at discharge from your unit <s1> \n " +
			"<s1> Consider <b> 5 </b> to be the rating that one would assign to a comparable healthy person (e.g. same age, mental capacity, gender) and <b> 1 </b> to be the lowest. \n " +
			"<s1> Please note that a 5 is <b> NOT </b> always a realistic discharge rating \n ";
			
		String currentRatingTutorial =
			"<b> Rules for Setting a Current NOC Rating: </b> <l> \n " +
			"1. Review the NOC <h> <b> Definition </b> </h> \n " +
			"2. Review the NOC <h> <b> Indicators </b> </h> \n " +
			"3. Select NOC rating (1-5) expected of patient at discharge from your unit <s1> \n " +
			"<s1> Consider <b> 5 </b> to be the rating that one would assign to a comparable healthy person (e.g. same age, mental capacity, gender) and <b> 1 </b> to be the lowest. \n ";
			
		if(OPTION_BIG_INFORMATION)
		{
			expectedRatingSection.setDescription(expectedRatingTutorial);
			currentRatingSection.setDescription(currentRatingTutorial);
		}
		else
		{
			expectedRatingSection.setInfoButton(expectedRatingTutorial);
			currentRatingSection.setInfoButton(currentRatingTutorial);
		}
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	void onOkClicked()
	{
		for(int i = 1; i <= 5; i++)
		{
			CheckBox cb = currentRatings.get(i - 1);
			if(cb.selected)
			{
				parent.currentRatingButton.t = str(i);
				break;
			}
		}
		for(int i = 1; i <= 5; i++)
		{
			CheckBox cb = expectedRatings.get(i - 1);
			if(cb.selected)
			{
				parent.secondColumn = i;
				parent.disableExpectedRatingButton();
				subviews.remove(expectedRatingSection);
				break;
			}
		}
		
		// if(consultCheck != null && consultCheck.selected)
		// {
			// pocManager.addNIC(NIC_CONSULTATION_TEXT, "", pocManager.anxietySelfControlView, IMG_CONSULTATION);
			// actionSection.removeAction(consultCheck);
			// parent.addComment("");
			// consultCheck = null;
			// consultCheckAdded = true;
		// }
		// else
		// {
			// if(!consultCheckAdded)
			// {
				// if(reason1.selected)
				// {
					// parent.addComment("Dismissed consultation: Family / Patient Refused");
				// }
				// else if(reason2.selected)
				// {
					// parent.addComment("Dismissed consultation: Doctor " + reason2.tb.text + " refused");
				// }
				// else if(reason3.selected)
				// {
					// parent.addComment("Dismissed consultation: " + reason3.tb.text);
				// }
			// }
			// parent.removeQuickActionButton1();
		// }
		// if(copingCheck != null && copingCheck.selected)
		// {
			// pocManager.addNANDA(pocManager.nandaInterruptedFamilyProcess);
			// actionSection.removeAction(copingCheck);
			// copingCheck = null;
		// }
		
		hide();
	}
}
