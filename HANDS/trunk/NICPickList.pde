class NICPickList extends NativeActionsPopUpView
{
    PopUpSection actions;
    
	////////////////////////////////////////////////////////////////////////////
	NICPickList(POCManager poc)
	{
		super(510, poc);
        actions = addSection("Add NIC(s)");
        actions.addNIC("Active Listening", "");
        actions.addNIC("Anxiety Reduction", "");
        actions.addNIC("Bowel Management", "");
        actions.addNIC("Bowel Training", "");
        actions.addNIC("Caregiver Support", "");
        actions.addNIC("Constipation/Impaction Management", "");
        actions.addNIC("Consultation: Palliative Care", "");
        actions.addNIC("Consultation: Spiritual", "");
        actions.addNIC("Coping Enhancement", "");
        actions.addNIC("Energy Conservation", "");
        actions.addNIC("Fall Prevention", "");
        actions.addNIC("Family Coping", "");
        actions.addNIC("Fluid and Electrolyte Management", "");
        actions.addNIC("Grief Work Facilitation", "");
        actions.addNIC("Guided Imagery", "");
        actions.addNIC("Massage", "");
        actions.addNIC("Medication Management", "");
        actions.addNIC("Nausea Management", "");
        actions.addNIC("Nutrition Management", "");
        actions.addNIC("Patient Controlled Analgesia", "");
        actions.addNIC("Positioning", "");
        actions.addNIC("Pressure Ulcer Prevention", "");
        actions.addNIC("Relaxation Therapy", "");
        actions.addNIC("Respiratory Monitoring", "");
        actions.addNIC("Self-Care Assistance: Toileting", "");
        actions.addNIC("Surveillance", "");
        actions.addNIC("Urinary Elimination Management", "");
    }
}
