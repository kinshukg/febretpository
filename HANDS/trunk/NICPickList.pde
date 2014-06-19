class NICPickList extends NativeActionsPopUpView
{
    PopUpSection actions;
    
	////////////////////////////////////////////////////////////////////////////
	NICPickList(POCManager poc)
	{
		super(510, poc);
        actions = addSection("Add NIC(s)");
        actions.addNIC("Active Listening", "tooltipPlaceholder.PNG");
        actions.addNIC("Anxiety Reduction", "tooltipPlaceholder.PNG");
        actions.addNIC("Bowel Management", "tooltipPlaceholder.PNG");
        actions.addNIC("Bowel Training", "tooltipPlaceholder.PNG");
        actions.addNIC("Caregiver Support", "caregiverSupport.png");
        actions.addNIC("Constipation/Impaction Management", "tooltipPlaceholder.PNG");
        actions.addNIC("Consultation: Palliative Care", "consultation.PNG");
        actions.addNIC("Consultation: Spiritual", "consultation.PNG");
        actions.addNIC("Coping Enhancement", "copingEnhancement.png");
        actions.addNIC("Energy Conservation", "energyConservation.PNG");
        actions.addNIC("Fall Prevention", "fallPrevention.png");
        actions.addNIC("Family Coping", "familyCoping.PNG");
        actions.addNIC("Fluid and Electrolyte Management", "fluidElectrolyteManagement.png");
        actions.addNIC("Grief Work Facilitation", "griefResolution.png");
        actions.addNIC("Guided Imagery", "guidedImagery.PNG");
        actions.addNIC("Massage", "massage.PNG");
        actions.addNIC("Medication Management", "medicationManagement.PNG");
        actions.addNIC("Nausea Management", "nauseaManagement.png");
        actions.addNIC("Nutrition Management", "nutritionManagement.png");
        actions.addNIC("Patient Controlled Analgesia", "patientControlledAnalgesia.PNG");
        actions.addNIC("Positioning", "positioning.png");
        actions.addNIC("Pressure Ulcer Prevention", "pressureUlcerPrevention.png");
        actions.addNIC("Relaxation Therapy", "NICRelaxationTherapy.PNG");
        actions.addNIC("Respiratory Monitoring", "respiratoryMonitoring.png");
        actions.addNIC("Self-Care Assistance: Toileting", "tooltipPlaceholder.PNG");
        actions.addNIC("Surveillance", "surveillance.png");
        actions.addNIC("Urinary Elimination Management", "urinaryEliminationManagement.png");
        CheckBox oth = actions.addNIC("Other", "tooltipPlaceholder.PNG");
        oth.showTextBox();
        oth.tb.suggestion = "Enter NIC Name";
    }
}
