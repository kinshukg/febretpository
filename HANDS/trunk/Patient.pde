///////////////////////////////////////////////////////////////////////////////////////////////////
class Patient
{
    // Patient id
    int id;
    
    // Patient demographics
    String name, dob, gender, allergies, codeStatus, poc, shft, room, medicalDX, mr, physician, other;

    POCManager pocManager;
    
    // List of trends 
    ArrayList trends = new ArrayList();;
    
    ///////////////////////////////////////////////////////////////////////////////////////////////
    void reset()
    {
        pocManager = new POCManager();
        pocManager.reset();
        
        // Variables used to populate the native HANDS action popup.
        NativeActionsPopUpView popup = null;
        //PopUpSection actions = null;
        
        if(id == 1)
        {
            // NANDA Constipation
            ColouredRowView NANDAConstipation = pocManager.addNANDA("Constipation", IMG_PLACEHOLDER);
            SecondLevelRowView NOCBowelElimination = pocManager.addNOC("Bowel Elimination", "", NANDAConstipation, IMG_PLACEHOLDER);
            NOCBowelElimination.setScores(3, 4);
            pocManager.addNIC("Bowel Management", "", NOCBowelElimination, IMG_PLACEHOLDER);
            pocManager.addNIC("Self-Care Assistance: Toileting", "", NOCBowelElimination, IMG_PLACEHOLDER);
            
            // NANDA Acute Pain section
            ColouredRowView NANDAAcutePain = pocManager.addNANDA("Acute Pain", IMG_ACUTE_PAIN);
            SecondLevelRowView NOCPainLevel = pocManager.addNOC("Pain Level", "", NANDAAcutePain, IMG_PAIN_LEVEL);
            NOCPainLevel.setScores(2, 4);
            pocManager.addNIC("Medication Management", "", NOCPainLevel, IMG_MEDICATION_MANAGEMENT);
            pocManager.addNIC("Pain Management", "", NOCPainLevel, IMG_PAIN_MANAGEMENT);

            // We add the death anxiety section after the first shift.
            if(currentShift == 1)
            {
                // NANDA Death anxiety
                ColouredRowView NANDADeathAnxiety = pocManager.addNANDA("Death Anxiety", IMG_DEATH_ANXIETY);
                SecondLevelRowView NOCComfortableDeath = pocManager.addNOC("Comfortable Death", "", NANDADeathAnxiety, IMG_COMFORTABLE_DEATH);
                NOCComfortableDeath.setScores(3, 5);
                pocManager.addNIC("Calming Technique", "", NOCComfortableDeath, IMG_CALMING_TECHNIQUE);
                pocManager.addNIC("Spiritual Support", "", NOCComfortableDeath, IMG_SPIRITUAL_SUPPORT);
            }
        }
        else if(id == 2)
        {
            // NANDA Impaired Gas Exchange
            ColouredRowView NANDAImpairedGasExchange = pocManager.addNANDA("Impaired Gas Exchange", IMG_PLACEHOLDER);
            SecondLevelRowView NOCRespiratoryStatus = pocManager.addNOC("Respiratory Status: Gas Exhange", "", NANDAImpairedGasExchange, IMG_PLACEHOLDER);
            NOCRespiratoryStatus.setScores(2, 4);
            pocManager.addNIC("Acid Base Monitoring", "", NOCRespiratoryStatus, IMG_PLACEHOLDER);
            pocManager.addNIC("Bedside Laboratory Testing", "", NOCRespiratoryStatus, IMG_PLACEHOLDER);
            pocManager.addNIC("Airway Management", "", NOCRespiratoryStatus, IMG_PLACEHOLDER);

            // NANDA Death Anxiety
            ColouredRowView NANDADeath = pocManager.addNANDA("Death Anxiety", IMG_PLACEHOLDER);
            SecondLevelRowView NOCDeath = pocManager.addNOC("Comfortable Death", "", NANDADeath, IMG_PLACEHOLDER);
            NOCDeath.setScores(2, 5);
            pocManager.addNIC("Calming Technique", "", NOCDeath, IMG_PLACEHOLDER);
            pocManager.addNIC("Spritual Support", "", NOCDeath, IMG_PLACEHOLDER);
            
            // NANDA Impaired Physical Mobility
            ColouredRowView NANDAPhysMob = pocManager.addNANDA("Impaired Physical Mobility", IMG_PLACEHOLDER);
            SecondLevelRowView NOCMobility = pocManager.addNOC("Mobility", "", NANDAPhysMob, IMG_PLACEHOLDER);
            NOCMobility.setScores(1, 3);
            pocManager.addNIC("Fall Prevention", "", NOCMobility, IMG_PLACEHOLDER);
            pocManager.addNIC("Energy Conservation", "", NOCMobility, IMG_PLACEHOLDER);
            
            // NANDA Acute Pain
            ColouredRowView NANDAPain = pocManager.addNANDA("Acute Pain", IMG_PLACEHOLDER);
            SecondLevelRowView NOCPainLevel = pocManager.addNOC("Pain Level", "", NANDAPain, IMG_PLACEHOLDER);
            NOCPainLevel.setScores(4, 5);
            pocManager.addNIC("Pain Management", "", NOCPainLevel, IMG_PLACEHOLDER);
            pocManager.addNIC("Medication Management", "", NOCPainLevel, IMG_PLACEHOLDER);
            pocManager.addNIC("Positioning", "", NOCPainLevel, IMG_PLACEHOLDER);
        }
        
        if(!OPTION_NATIVE) setupPopup();
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////
    TrendView getTrend(String name)
    {
		for (int i = 0; i < trends.size(); i++ ) 
		{
			TrendView tw = (TrendView) trends.get(i);
            if(tw.title.equals(name)) return tw;
        }
        print("Patient::getTrend - could not find trend titled " + name);
        return null;
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////
    void show()
    {
		mainView.subviews.add(pocManager.scrollingView);
        
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////
    void hide()
    {
		mainView.subviews.remove(pocManager.scrollingView);
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////
    void nextShift()
    {
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////
    public void setupPopup()
    {
        if(id == 1)
        {
            // Acute Pain CDS
            SecondLevelRowView painLevel = pocManager.getNOC("Acute Pain", "Pain Level");
            PainPopUpView ppw = new PainPopUpView(705, painLevel, pocManager);
            ppw.trendView = getTrend(painLevel.title);
            ppw.trendView.noc = painLevel;
            ppw.reset();
            
            // Death Anxiety CDS
            SecondLevelRowView comfortableDeath = pocManager.getNOC("Death Anxiety", "Comfortable Death");
            DeathPopUpView dppw = new DeathPopUpView(600, comfortableDeath, pocManager);
            dppw.trendView = getTrend(comfortableDeath.title);
            dppw.trendView.noc = comfortableDeath;
            dppw.reset();
        }
        else if(id == 2)
        {
            // Death Anxiety CDS
            SecondLevelRowView comfortableDeath = pocManager.getNOC("Death Anxiety", "Comfortable Death");
            DeathPopUpView dppw = new DeathPopUpView(600, comfortableDeath, pocManager);
            dppw.trendView = getTrend(comfortableDeath.title);
            dppw.trendView.noc = comfortableDeath;
            dppw.reset();
            
            // Mobility CDS
            //SecondLevelRowView mob = pocManager.getNOC("Impaired Physical Mobility", "Mobility");
            //MobilityPopupView mpw = new MobilityPopupView(600, mob, pocManager);
            //mpw.trendView = getTrend(mpw.title);
            //mpw.reset();
        }
    }
}

