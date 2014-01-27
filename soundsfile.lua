-- Rolly Bear World Project by Christian Peeters
-- See all tutorial @christian.peeters.com


--soundeffects 
audiolaunchbear = audio.loadSound ("audio/wee.mp3")
audiowinsound = audio.loadSound ("audio/winsound.wav")
audioclick = audio.loadSound ("audio/click.mp3")
audiolever = audio.loadSound ("audio/soundlever.mp3")
gamebgmusic = audio.loadStream ("audio/gamebgmonomusic.mp3")


soundisOn = true 
musicisOn = true 

audio.reserveChannels (1) -- one audio channel we need to reserve for the background music 


function playSFX (soundfile, volumelevel)

 	if soundisOn == true then 
		local volumelevel = volumelevel or 1.0
		audio.play(soundfile)
		audio.setVolume(volumelevel, {soundfile} )
	end 
	
end 

function playgameMusic (soundfile)
	 
	if musicisOn == true then 
	audio.play (soundfile, {channel = 1, loops = -1 , fadein=2500})
	end

end

function resetMusic (soundfile)

	if musicisOn == true then 
		audio.stop(1)
		audio.rewind (gamebgmusic)	
	end

end

function pauseMusic (soundfile)
	if musicisOn == true then 
	audio.pause()
	end
end

function resumeMusic (channel)
	if musicisOn == true then 
	audio.resume(channel)
	end
end


