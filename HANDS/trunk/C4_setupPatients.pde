public void setupPatients()
{
    // Patient 1 ---------------------------------------------------------------
    patient1 = new Patient();
    patient1.id = 1;
    patient1.name = "Ann Taylor";
    patient1.dob = "03/12/1959";
    patient1.gender = "Female";
    patient1.allergies = "None";
    patient1.codeStatus = "DNR";
    patient1.poc = "09/17/2013";
    patient1.shft= "7:00a - 7:00p";
    patient1.room = "1240";
    patient1.medicalDX = "Malignant Neoplasm of the Pancreas";
    patient1.mr = "xxx xxx xxx";
    patient1.physician = "Piper";
    patient1.other = "Husband to be called ANYTIME \n at patient's request \n 776-894-1010";
    
    TrendView tw;
    
    // Setup patient 1 pain trends
    //if(OPTION_CDS_TYPE != 1)
    {
        if(OPTION_CDS_TYPE == 2) tw = new TrendGraph(0, 0);
        else tw = new TrendTable(0,0);
        
        tw.title = "Pain Level";
        patient1.trends.add(tw);
        
        tw.now = 2;
        tw.pastTrend[0] = 2;    
        tw.pastTrend[1] = 2;    
        tw.projectionGood[2] = 2;    
        tw.projectionGood[3] = 3;    
        tw.projectionGood[4] = 4;    
        tw.projectionGood[5] = 4;    
        tw.projectionGood[6] = 4;    
        tw.projectionBad[2] = 2;    
        tw.projectionBad[3] = 2;    
        tw.projectionBad[4] = 1;    
        tw.projectionBad[5] = 2;    
        tw.projectionBad[6] = 1;    

        if(OPTION_CDS_TYPE == 2) tw = new TrendGraph(0, 0);
        else tw = new TrendTable(0,0);
        tw.title = "Comfortable Death";
        patient1.trends.add(tw);
        
        tw.now = 2;
        tw.pastTrend[0] = 0;    
        tw.pastTrend[1] = 3;    
        tw.projectionGood[2] = 3;    
        tw.projectionGood[3] = 4;    
        tw.projectionGood[4] = 4;    
        tw.projectionGood[5] = 5;    
        tw.projectionGood[6] = 5;    
        tw.projectionBad[2] = 3;    
        tw.projectionBad[3] = 4;    
        tw.projectionBad[4] = 3;    
        tw.projectionBad[5] = 3;    
        tw.projectionBad[6] = 2;    
    }
    
    patient1.reset();

    // Patient 2 ---------------------------------------------------------------
    patient2 = new Patient();
    patient2.id = 2;
    patient2.name = "Charlene Schwab";
    patient2.dob = "10/16/1928";
    patient2.gender = "Female";
    patient2.allergies = "None";
    patient2.codeStatus = "DNR";
    patient2.poc = "09/17/2013";
    patient2.shft= "7:00a - 7:00p";
    patient2.room = "1240";
    patient2.medicalDX = "End Stage COPD";
    patient2.mr = "xxx xxx xxx";
    patient2.physician = "Allen Goldberg";
    patient2.other = "";
    
    //if(OPTION_CDS_TYPE != 1)
    {
        if(OPTION_CDS_TYPE == 2) tw = new TrendGraph(0, 0);
        else tw = new TrendTable(0,0);
        tw.title = "Respiratory Status: Gas Exchange";
        patient2.trends.add(tw);
        
        tw.now = 2;
        tw.pastTrend[0] = 2;    
        tw.pastTrend[1] = 2;    
        tw.projectionGood[2] = 2;    
        tw.projectionGood[3] = 3;    
        tw.projectionGood[4] = 2;    
        tw.projectionGood[5] = 2;    
        tw.projectionGood[6] = 2;    
        tw.projectionBad[2] = 2;    
        tw.projectionBad[3] = 2;    
        tw.projectionBad[4] = 1;    
        tw.projectionBad[5] = 2;    
        tw.projectionBad[6] = 1;    

        if(OPTION_CDS_TYPE == 2) tw = new TrendGraph(0, 0);
        else tw = new TrendTable(0,0);
        tw.title = "Comfortable Death";
        patient2.trends.add(tw);
        
        tw.now = 2;
        tw.pastTrend[0] = 0;    
        tw.pastTrend[1] = 3;    
        tw.projectionGood[2] = 3;    
        tw.projectionGood[3] = 4;    
        tw.projectionGood[4] = 4;    
        tw.projectionGood[5] = 5;    
        tw.projectionGood[6] = 5;    
        tw.projectionBad[2] = 3;    
        tw.projectionBad[3] = 4;    
        tw.projectionBad[4] = 3;    
        tw.projectionBad[5] = 3;    
        tw.projectionBad[6] = 2;    
        
        if(OPTION_CDS_TYPE == 2) tw = new TrendGraph(0, 0);
        else tw = new TrendTable(0,0);
        tw.title = "Mobility";
        patient2.trends.add(tw);
        
        tw.now = 2;
        tw.pastTrend[0] = 0;    
        tw.pastTrend[1] = 1;    
        tw.projectionGood[2] = 2;    
        tw.projectionGood[3] = 2;    
        tw.projectionGood[4] = 2;    
        tw.projectionGood[5] = 1;    
        tw.projectionGood[6] = 1;    
        tw.projectionBad[2] = 2;    
        tw.projectionBad[3] = 2;    
        tw.projectionBad[4] = 2;    
        tw.projectionBad[5] = 1;    
        tw.projectionBad[6] = 1;    
    }
    
    //--------------------------------------------------------------------------
    patient1.reset();
    patient2.reset();
    setActivePatient(patient1);
}
