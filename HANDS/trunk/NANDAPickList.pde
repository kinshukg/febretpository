class NANDAPickList extends NativeActionsPopUpView
{
	////////////////////////////////////////////////////////////////////////////
	NANDAPickList(POCManager poc)
	{
		super(510, poc);

        PopUpSection actions = addSection("Add NANDA");
        actions.addNANDA("Acute Pain", "Test");
        actions.addNANDA("Complicated Grieving", "Test");
        actions.addNANDA("Compromised Family Coping", "Test");
        actions.addNANDA("Constipation", "Test");
        actions.addNANDA("Death Anxiety", "Test");
        actions.addNANDA("Dysfunctional Family Processes", "Test");
        actions.addNANDA("Impaired Gas Exchange", "Test");
        actions.addNANDA("Impaired Physical Mobility", "Test");
        actions.addNANDA("Impaired Skin Integrity", "Test");
        actions.addNANDA("Nausea", "Test");
        actions.addNANDA("Readiness for Family Coping", "Test");
        actions.addNANDA("Caregiver Support", "Test");
	}
}
