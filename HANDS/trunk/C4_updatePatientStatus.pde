public void updatePatientStatus(Patient patient)
{
    // No changes on first shift
    if(currentShift == 1)
    {
        if(OPTION_CDS_TYPE != 0)
        {
            OPTION_NATIVE = false;
        }
        patient1.reset();
        patient2.reset();
        return;
    }
    
    TrendView tw = null;
    
    // PATIENT 1 ---------------------------------------------------------------
    if(patient == patient1)
    {
        // Update pain status based on user actions
        tw = patient.getTrend("Pain Level");
        // current value;
        //int c = tw.pastTrend[tw.now - 1];
        // now index
        tw.now = tw.now + 1;
        int i = tw.now - 1;
        POCManager poc = patient.pocManager;
        // If user added positioning, pain score always goes up by 1
        if(poc.achPositioningAdded)
        {
            // If all three suggestions have been applied, pain goes up by 2.
            if(poc.achPainPrioritized && poc.achPalliativeConsultAdded)
            {
                tw.pastTrend[i] = 4;
            }
            else
            {
                tw.pastTrend[i] = 3;
            }
        }
        // If both the other suggestions have been considered, pain goes up by 1 
        else if(poc.achPainPrioritized && poc.achPalliativeConsultAdded)
        {
            tw.pastTrend[i] = 3;
        }
        // If no suggstion has been followed, pain goes down by 1.
        else if(!poc.achPainPrioritized && !poc.achPalliativeConsultAdded)
        {
            tw.pastTrend[i] = 1;
        }
        else
        {
            tw.pastTrend[i] = tw.pastTrend[i - 1];
        }
        
        // If any action has been takes, no action pain trend from now on
        // just follows the current value.
        if(poc.achPainPrioritized || 
            poc.achPalliativeConsultAdded || 
            poc.achPositioningAdded)
        {
            for(int j = i; j < 8; j++) tw.projectionBad[j] = tw.pastTrend[i];
        }
        
        // Update the current pain level score to mach value from the trend view
        SecondLevelRowView noc = poc.getNOC("Acute Pain", "Pain Level");
        noc.startBlinking();
        if(noc != null) noc.firstColumn = tw.pastTrend[i];
        
        // Update comfortable death status
        tw = patient.getTrend("Comfortable Death");
        tw.now = tw.now + 1;
        // current value;
        //c = tw.pastTrend[tw.now - 1];
        // now index

        if(poc.achPalliativeConsultAdded)
        {
            tw.pastTrend[i] = 4;
        }
        else
        {
            tw.pastTrend[i] = 3;
        }
        // If action has been takes, death anxiety score no act projection 
        // stays constant
        if(poc.achPalliativeConsultAdded)
        {
            for(int j = i; j < 8; j++) tw.projectionBad[j] = tw.pastTrend[i];
        }
        
        // Update the current pain level score to mach value from the trend view
        noc = poc.getNOC("Death Anxiety", "Comfortable Death");
        noc.startBlinking();
        if(noc != null) noc.firstColumn = tw.pastTrend[i];
    }
    else if(patient == patient2)
    // PATIENT 2 ---------------------------------------------------------------
    {
        POCManager poc = patient.pocManager;
        SecondLevelRowView noc;
        
        // RESPIRATORY STATUS
        // Patient 2, if respiratory monitoring has been added, pain level goes to 5.
        if(poc.achRespiratoryMonitoringAdded)
        {
            noc = poc.getNOC("Acute Pain", "Pain Level");
            noc.firstColumn = 5;
        }
        // Update impaired gas exchange status
        noc = poc.getNOC("Impaired Gas Exchange", "Respiratory Status: Gas Exchange");
        tw = patient.getTrend("Respiratory Status: Gas Exchange");
        tw.pastTrend[tw.now] = noc.firstColumn;
        for(int j = tw.now; j < 8; j++) tw.projectionBad[j] = tw.pastTrend[tw.now];
        tw.now = tw.now + 1;
        
        
        // DEATH ANXIETY
        noc = poc.getNOC("Death Anxiety", "Comfortable Death");
        // Death anxiety, if we do nothing goes to 1.
        if(poc.achFamilyCopingAdded || poc.achDeathAnxietyPrioritized)
        {
            if(poc.achFamilyCopingAdded && poc.achDeathAnxietyPrioritized)
            {
                noc.firstColumn = 4;
            }
            else 
            {
                noc.firstColumn = 3;
            }
        }
        else
        {
            noc.firstColumn = 1;
        }
        // Update comfortable death status
        tw = patient.getTrend("Comfortable Death");
        tw.pastTrend[tw.now] = noc.firstColumn;
        // If action has been takes, death anxiety score no act projection 
        // stays constant
        for(int j = tw.now; j < 8; j++) tw.projectionBad[j] = tw.pastTrend[tw.now];
        tw.now = tw.now + 1;
        
        // MOBILITY
        noc = poc.getNOC("Impaired Physical Mobility", "Mobility");
        // Update mobility status
        tw = patient.getTrend("Mobility");
        tw.pastTrend[tw.now] = noc.firstColumn;
        // If action has been takes, death anxiety score no act projection 
        // stays constant
        for(int j = tw.now; j < 8; j++) tw.projectionBad[j] = tw.pastTrend[tw.now];
        tw.now = tw.now + 1;
    }
}
