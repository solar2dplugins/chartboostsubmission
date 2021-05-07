local Library = require "CoronaLibrary"
-- Create library
local lib = Library:new{ name='plugin.tekgu.chartboost', publisherId='com.tekgu' }
 
-------------------------------------------------------------------------------
-- START
-------------------------------------------------------------------------------
lib.init = function( listener, params )
	 --[[
		**Initializes the Chartboost plugin. This call is required and must be executed before making other Chartboost calls such as chartboost.load() or chartboost.show().
		--Listener function that will receive adsRequest events.
		--The params table includes parameters for Chartboost initialization.

		--==============================================================
		-- START: Example
		--==============================================================
			local chartboost = require( "plugin.tekgu.chartboost" )  
			local function adListener( event )
				print("phase = " .. event.phase, "type = " .. (event.type or "NULL") )
				if event.isError then
					print("errorCode = " .. event.response.errorCode, "message = " .. event.response.message)
				end
				if(event.phase == "init") then
					if(not event.isError) then 
					
					end
				else
					if(event.phase == "failed") then
						local response = event.response
						if(
							response.errorCode == "LOAD_INTERSTITIAL_FAILED" --interstitial
							or response.errorCode == "LOAD_REWARDEDVIDEO_FAILED" --rewardedVideo
						) then  
						end
					elseif(event.phase == "loaded") then 
					elseif(event.phase == "displayed") then
					elseif(event.phase == "clicked") then
					elseif(event.phase == "closed") then
					elseif(event.phase == "reward") then
					end
				end
			end 
			chartboost.init( adListener, { appId="YOUR_CHARTBOOST_APP_ID", appSig="YOUR_CHARTBOOST_APP_SIGNATURE" } )
		--==============================================================
		-- END
		--==============================================================
	 ]]
end

lib.load = function( params )
	--[[
		 **Pre-loads a Chartboost static interstitial, video interstitial, rewarded video, or the "more apps" screen for instant loading upon a future call to chartboost.show().
		 **Before calling this function, you must call chartboost.init() and wait for the "init" event phase.
		--The params table includes parameters.
		--NOTE: Listener at chartboost.init( listener, params ).	

		--==============================================================
		-- START: Example
		--==============================================================
			local chartboost = require( "plugin.tekgu.chartboost" )
			local params = {
				adType = "rewardedVideo", --interstitial
				--location = "default"
			}
			local res = chartboost.isLoaded(params)
			if(not res.isError) then
				if(not res.isLoaded) then
					chartboost.load(params);
				end
			end 
		--==============================================================
		-- END
		--==============================================================
	]]
end

lib.isloaded = function( params )
	--[[
		**Returns whether an ad is loaded or not.
		--The params table includes parameters.
		--NOTE: Listener at chartboost.init( listener, params ).

		--==============================================================
		-- START: Example
		--==============================================================
			local chartboost = require( "plugin.tekgu.chartboost" )
			local params = {
				adType = "rewardedVideo", --interstitial
				--location = "default"
			}
			-- Check if default interstitial is loaded
			print( chartboost.isLoaded(params)) 
		--==============================================================
		-- END
		--==============================================================
	]]
end

lib.show = function( params )
	 --[[
		**Shows a Chartboost static interstitial, video interstitial, rewarded video, or the "more apps" screen.
		**An ad should be pre-loaded before calling this function. Use chartboost.load(), or enable auto-caching during chartboost.init().
 		**Before calling this function, you must call chartboost.init() and and ensure that the "init" event phase occurs.
		--The params table includes parameters.
		--NOTE: Listener at chartboost.init( listener, params ).

		--==============================================================
		-- START: Example
		--==============================================================
			local chartboost = require( "plugin.tekgu.chartboost" ) 
			local params = {
				adType = "rewardedVideo", --interstitial
				--location = "default"
			}
			-- Chartboost listener function
			local function adListener( event )
				if ( event.phase == "init" ) then  -- Successful initialization
					chartboost.load( params ) 
				elseif ( event.phase == "loaded" ) then
					if ( event.type == "rewardedVideo" ) then
						chartboost.show( params )
					end
				end
			end 
			-- Initialize the Chartboost plugin
			chartboost.init( adListener, { appId="YOUR_CHARTBOOST_APP_ID", appSig="YOUR_CHARTBOOST_APP_SIGNATURE" } )
		--==============================================================
		-- END
		--==============================================================
	]]
end

lib.onbackpressed = function( )
	 --[[
		**Returns whether an ad was closed when the "back" key was pressed. This should be implemented in your handler function for the key handler (see example below).

		--==============================================================
		-- START: Example
		--==============================================================
			local chartboost = require( "plugin.tekgu.chartboost" )
 
			-- Called when a key event has been received
			local function onKeyEvent( event )
			
				if ( event.keyName == "back" and event.phase == "up" ) then
					local platformName = system.getInfo( "platformName" )
					if ( platformName == "Android" ) then
						if ( chartboost.onBackPressed() ) then
							-- Chartboost closed an active ad
							return true  -- Don't pass the event down the responder chain
						end
					end
				end
			
				-- IMPORTANT! Return false to indicate that this app is NOT overriding the received key
				-- This lets the operating system execute its default handling of the key
				return false
			end
			
			-- Add the key event listener
			Runtime:addEventListener( "key", onKeyEvent )
		--==============================================================
		-- END
		--==============================================================
	]]
end
-------------------------------------------------------------------------------
-- END
-------------------------------------------------------------------------------
 
return lib