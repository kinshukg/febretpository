class NICPickList extends NativeActionsPopUpView
{
    PopUpSection actions;
    
	////////////////////////////////////////////////////////////////////////////
	NICPickList(POCManager poc)
	{
		super(800, poc);
        actions = addSection("Add NIC(s)");
        actions.addNIC("Acid Base Monitoring", "NICAcidBaseMonitoring.png");
        actions.addNIC("Active Listening", "NICActiveListening.png");
        actions.addNIC("Airway Management", "NICAirwayManagement.png");
        actions.addNIC("Anxiety Reduction", "NICAnxietyReduction.png");
        actions.addNIC("Bedside Laboratory Testing", "NICBedsideLaboratoryTesting.png");
        actions.addNIC("Bowel Management", "NICBowelManagement.PNG");
        actions.addNIC("Bowel Training", "NICBowelTraining.png");
        actions.addNIC("Calming Technique", "calmingTechnique.PNG");
        actions.addNIC("Caregiver Support", "caregiverSupport.png");
        actions.addNIC("Constipation/Impaction Management", "NICConstipationImpactionManagement.png");
        actions.addNIC("Consultation: Palliative Care", "consultation.PNG");
        actions.addNIC("Consultation: Spiritual", "consultation.PNG");
        actions.addNIC("Coping Enhancement", "copingEnhancement.png");
        actions.addNIC("Energy Management", "NICEnergyManagement.png");
        actions.addNIC("Fall Prevention", "fallPrevention.png");
        actions.addNIC("Family Integrity Promotion", "familyIntegrityPromotion.PNG");
        actions.addNIC("Family Support", "familySupport.PNG");
        actions.addNIC("Fluid and Electrolyte Management", "fluidElectrolyteManagement.png");
        actions.addNIC("Grief Resolution", "griefResolution.png");
        actions.addNIC("Guided Imagery", "guidedImagery.PNG");
        actions.addNIC("Health Education: End of Life Process", "healthEducation.PNG");
        actions.addNIC("Massage", "massage.PNG");
        actions.addNIC("Medication Management", "medicationManagement.PNG");
        actions.addNIC("Nausea Management", "nauseaManagement.png");
        actions.addNIC("Nutrition Management", "nutritionManagement.png");
        CheckBox oth = actions.addNIC("Other", "tooltipPlaceholder.PNG");
        oth.text.text = "Add Other: ";
        
        actions.addNIC("Pain Management", "painManagement.PNG");
        actions.addNIC("Patient Controlled Analgesia", "patientControlledAnalgesia.PNG");
        actions.addNIC("Positioning", "positioning.png");
        actions.addNIC("Pressure Ulcer Prevention", "pressureUlcerPrevention.png");
        actions.addNIC("Relaxation Therapy", "NICRelaxationTherapy.PNG");
        actions.addNIC("Respiratory Monitoring", "respiratoryMonitoring.png");
        actions.addNIC("Self-Care Assistance: Toileting", "NICSelfCareAssistanceToileting.PNG");
        actions.addNIC("Skin Surveillance", "surveillance.png");
        actions.addNIC("Spiritual Support", "spiritualSupport.PNG");
        actions.addNIC("Urinary Elimination Management", "urinaryEliminationManagement.png");
        oth.showTextBox();
        oth.tb.suggestion = "Enter Intervention";
    }
}
