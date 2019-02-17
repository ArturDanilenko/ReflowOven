Serial_Flash_inst : Serial_Flash PORT MAP (
		asmi_access_granted	 => asmi_access_granted_sig,
		data_in	 => data_in_sig,
		data_oe	 => data_oe_sig,
		dclk_in	 => dclk_in_sig,
		ncso_in	 => ncso_in_sig,
		noe_in	 => noe_in_sig,
		asmi_access_request	 => asmi_access_request_sig,
		data_out	 => data_out_sig
	);
