local metadata =
{
	plugin =
	{
		format = 'jar',
		manifest = 
		{
			permissions = {},
			usesPermissions =
			{ 
				"android.permission.INTERNET",
				"android.permission.ACCESS_NETWORK_STATE",
				"android.permission.READ_PHONE_STATE",
			},
			usesFeatures = {},
			applicationChildElements =
			{				 
				[[
                    <activity android:name="com.mycompany.MyActivity" 
						android:hardwareAccelerated="true" 
						android:configChanges="keyboardHidden|orientation|screenSize" />
                ]],
			},
		},
	},
	coronaManifest = {
		dependencies = { 
		},
	},
}

return metadata