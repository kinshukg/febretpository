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

    // The number of seconds spent working on this patient for the current shift.
    int time;
    
    ///////////////////////////////////////////////////////////////////////////////////////////////
    void reset()
    {
        time = 0;
        pocManager = new POCManager();
        pocManager.reset();
        
        // Variables used to populate the native HANDS action popup.
        NativeActionsPopUpView popup = null;
        //PopUpSection actions = null;
        
        if(id == 1)
        {
            // NANDA Constipation
            ColouredRowView NANDAConstipation = pocManager.addNANDA("Constipation", loadImage("NANDAConstipation.png"));
            SecondLevelRowView NOCBowelElimination = pocManager.addNOC("Bowel Elimination", "", NANDAConstipation, loadImage("NOCBowelElimination.png"));
            NOCBowelElimination.setScores(3, 4);
            pocManager.addNIC("Bowel Management", "", NOCBowelElimination, loadImage("NICBowelManagement.PNG"));
            pocManager.addNIC("Self-Care Assistance: Toileting", "", NOCBowelElimination, loadImage("NICSelfCareAssistanceToileting.PNG"));
            
            // NANDA Acute Pain section
            ColouredRowView NANDAAcutePain = pocManager.addNANDA("Acute Pain", loadImage("acutePain.png"));
            SecondLevelRowView NOCPainLevel = pocManager.addNOC("Pain Level", "", NANDAAcutePain, loadImage("painLevel.PNG"));
            NOCPainLevel.setScores(2, 4);
            pocManager.addNIC("Medication Management", "", NOCPainLevel, loadImage("medicationManagement.PNG"));
            pocManager.addNIC("Pain Management", "", NOCPainLevel, loadImage("painManagement.PNG"));

            // We add the death anxiety section after the first shift.
            if(currentShift == 1)
            {
                // NANDA Death anxiety
                ColouredRowView NANDADeathAnxiety = pocManager.addNANDA("Death Anxiety", loadImage("deathAnxiety.png"));
                SecondLevelRowView NOCComfortableDeath = pocManager.addNOC("Comfortable Death", "", NANDADeathAnxiety, loadImage("comfortableDeath.PNG"));
                NOCComfortableDeath.setScores(3, 5);
                pocManager.addNIC("Calming Technique", "", NOCComfortableDeath, loadImage("calmingTechnique.PNG"));
                pocManager.addNIC("Spiritual Support", "", NOCComfortableDeath, loadImage("spiritualSupport.PNG"));
            }
        }
        else if(id == 2)
        {
            // NANDA Impaired Gas Exchange
            ColouredRowView NANDAImpairedGasExchange = pocManager.addNANDA("Impaired Gas Exchange", loadImage("impairedgasExchange.png"));
            SecondLevelRowView NOCRespiratoryStatus = pocManager.addNOC("Respiratory Status: Gas Exchange", "", NANDAImpairedGasExchange, loadImage("NOCRespiratoryStatusGasExchange.png"));
            NOCRespiratoryStatus.setScores(2, 4);
            pocManager.addNIC("Acid Base Monitoring", "", NOCRespiratoryStatus, loadImage("NICAcidBaseMonitoring.png"));
            pocManager.addNIC("Bedside Laboratory Testing", "", NOCRespiratoryStatus, loadImage("NICBedsideLaboratoryTesting.png"));
            pocManager.addNIC("Airway Management", "", NOCRespiratoryStatus, loadImage("NICAirwayManagement.png"));

            // NANDA Death Anxiety
            ColouredRowView NANDADeath = pocManager.addNANDA("Death Anxiety", loadImage("deathAnxiety.png"));
            SecondLevelRowView NOCDeath = pocManager.addNOC("Comfortable Death", "", NANDADeath, loadImage("comfortableDeath.PNG"));
            NOCDeath.setScores(2, 5);
            pocManager.addNIC("Calming Technique", "", NOCDeath, loadImage("calmingTechnique.PNG"));
            pocManager.addNIC("Spritual Support", "", NOCDeath, loadImage("spiritualSupport.PNG"));
            
            // NANDA Impaired Physical Mobility
            ColouredRowView NANDAPhysMob = pocManager.addNANDA("Impaired Physical Mobility", loadImage("impairedPhysicalMobility.PNG"));
            SecondLevelRowView NOCMobility = pocManager.addNOC("Mobility", "", NANDAPhysMob, loadImage("NOCMobility.png"));
            NOCMobility.setScores(1, 3);
            pocManager.addNIC("Fall Prevention", "", NOCMobility, loadImage("fallPrevention.png"));
            pocManager.addNIC("Energy Management", "", NOCMobility, loadImage("NICEnergyManagement.png"));
            
            // NANDA Acute Pain
            ColouredRowView NANDAPain = pocManager.addNANDA("Acute Pain", loadImage("acutePain.png"));
            SecondLevelRowView NOCPainLevel = pocManager.addNOC("Pain Level", "", NANDAPain, loadImage("painLevel.PNG"));
            NOCPainLevel.setScores(4, 5);
            pocManager.addNIC("Pain Management", "", NOCPainLevel, loadImage("painManagement.PNG"));
            pocManager.addNIC("Medication Management", "", NOCPainLevel, loadImage("medicationManagement.PNG"));
            pocManager.addNIC("Positioning", "", NOCPainLevel, loadImage("positioning.png"));
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
            if(ppw.trendView != null) ppw.trendView.noc = painLevel;
            ppw.reset();
            
            // Death Anxiety CDS
            SecondLevelRowView comfortableDeath = pocManager.getNOC("Death Anxiety", "Comfortable Death");
            DeathPopUpView dppw = new DeathPopUpView(705, comfortableDeath, pocManager);
            dppw.trendView = getTrend(comfortableDeath.title);
            if(dppw.trendView != null) dppw.trendView.noc = comfortableDeath;
            dppw.reset();
        }
        else if(id == 2)
        {
            // Gas Exchange CDS
            SecondLevelRowView gasExchange = pocManager.getNOC("Impaired Gas Exchange", "Respiratory Status: Gas Exchange");
            ImpairedGasExchangePopup ige = new ImpairedGasExchangePopup(705, gasExchange, pocManager);
            ige.trendView = getTrend(gasExchange.title);
            if(ige.trendView != null) ige.trendView.noc = gasExchange;
            ige.reset();
            
            // Death Anxiety CDS
            SecondLevelRowView comfortableDeath = pocManager.getNOC("Death Anxiety", "Comfortable Death");
            DeathPopUpView dppw = new DeathPopUpView(705, comfortableDeath, pocManager);
            dppw.trendView = getTrend(comfortableDeath.title);
            if(dppw.trendView != null) dppw.trendView.noc = comfortableDeath;
            dppw.reset();
            
            // Mobility CDS
            SecondLevelRowView mobility = pocManager.getNOC("Impaired Physical Mobility", "Mobility");
            MobilityPopupView mppw = new MobilityPopupView(705, mobility, pocManager);
            mppw.trendView = getTrend(mobility.title);
            if(mppw.trendView != null) mppw.trendView.noc = mobility;
            mppw.reset();
        }
    }
}

