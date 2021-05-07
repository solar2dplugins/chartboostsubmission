# CHARTBOOST - [Documents](https://solar2dplugins.tekgu.com/chartboost)
## Functions
1. **chartboost.init(listener, params)**
    - Initializes the Chartboost plugin. This call is required and must be executed before making other Chartboost calls such as chartboost.load() or chartboost.show().

2. **chartboost.isLoaded(params)**
    - Returns whether an ad is loaded or not.

3. **chartboost.load(params)**
    - Pre-loads a Chartboost static interstitial, video interstitial, rewarded video, or the "more apps" screen for instant loading upon a future call to chartboost.show().
    - Before calling this function, you must call chartboost.init() and wait for the "init" event phase.

4. **chartboost.show(params)**
    - Shows a Chartboost static interstitial, video interstitial, rewarded video, or the "more apps" screen.
    - An ad should be pre-loaded before calling this function. Use chartboost.load(), or enable auto-caching during chartboost.init(). 
    - Before calling this function, you must call chartboost.init() and and ensure that the "init" event phase occurs.

5. **chartboost.onBackPressed()**
    - Returns whether an ad was closed when the "back" key was pressed. This should be implemented in your handler function for the key handler

## Example
```
local chartboost = require "plugin.tekgu.chartboost"

local adType = {
	adType = "rewardedVideo", --interstitial
	--location = "default"
}
local function loadAd()
	local res = chartboost.isLoaded(adType)
	if(not res.isError) then
		if(not res.isLoaded) then
			chartboost.load(adType);
		end
	end
end

local countshow = 0
local function show()
	if countshow < 1 then
		local res = chartboost.show(adType)
		countshow = countshow + 1;
	end

end

local params = {
	READ_PHONE_STATE = true,
	appId = "4f7b433509b6025804000002", 
	appSig = "dd2d41b69ac01b80f443f5b6cf06096d457f82bd", 
}

local listener = function(event)
	print("phase = " .. event.phase, "type = " .. (event.type or "NULL") )
	if event.isError then
		print("errorCode = " .. event.response.errorCode, "message = " .. event.response.message)
	end
	if(event.phase == "init") then
		if(not event.isError) then
			loadAd();
		end
	else
		if(event.phase == "failed") then
			local response = event.response
			if(
			    response.errorCode == "LOAD_INTERSTITIAL_FAILED" --interstitial
				or response.errorCode == "LOAD_REWARDEDVIDEO_FAILED" --rewardedVideo
			) then
				--reload
				--loadAd();
			end
		elseif(event.phase == "loaded") then
			show()
		elseif(event.phase == "displayed") then
		elseif(event.phase == "clicked") then
		elseif(event.phase == "closed") then
		elseif(event.phase == "reward") then
		end
	end
end 
chartboost.init( listener, params)
```