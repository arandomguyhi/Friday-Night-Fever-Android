-- deixando aqui ja que é a unica musica que roda mais de boa pra mim

function start (song) -- do nothing

end

function update (elapsed)
if curStep >= 0 and curStep < 1792 then -- down bad wave!!!
	local currentBeat = (songPos / 1000)*(bpm/120)
		for i=0,7 do
			setActorX(_G['defaultStrum'..i..'X'] + 5 * math.sin((currentBeat + i*50) * math.pi), i)
			setActorY(_G['defaultStrum'..i..'Y'] + 10 * math.cos((currentBeat + i*0.25) * math.pi), i)
	end
	end

end

function stepHit (step) -- do nothing

end