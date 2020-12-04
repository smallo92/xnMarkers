xnMarkers 'Burgershot' {						-- (Required) No Default; (This name here needs to be unique, if it's not unique the first one with the name will be the one that's created)
	['type'] = 1,								-- (Required) No Default; (This is the marker type found at https://docs.fivem.net/docs/game-references/markers/)
	['position'] = vec(-1183, -883.91, 12.8),	-- (Required) No Default; (Position you want the marker to be at)
	['rgba'] = vec(255, 0, 0, 100),				-- (Required) No Default; (This is a vector4 for red, green, blue, alpha values. There is some metadata trickery going on in xnMarkers to make this work for rgba)
	['rangeToShow'] = 25.0,						-- (Optional) Default: 50.0; (The range at which to show the marker)
	['bobUpAndDown'] = false,					-- (Optional) Default: False; (Do you want the marker to bob up and down?)
	['scale'] = vec(1, 1, 0.8),					-- (Optional) Default: vec(1, 1, 1); (Size of the marker)
	['rotation'] = vec(0, 0, 0),				-- (Optional) Default: vec(0, 0, 0); (Rotation of the marker)
	['direction'] = vec(0, 0, 0),				-- (Optional) Default: vec(0, 0, 0); (Pointing direction of the marker)
	['faceCamera'] = false,						-- (Optional) Default: False; (Do you want the marker to always face the camera)
	['textureDict'] = nil,						-- (Optional) Default: nil; (Custom texture dictionary for marker)
	['textureName'] = nil,						-- (Optional) Default: nil; (Custom texture name for marker)
	['activationRange'] = 1.0					-- (Optional) Default: scale.x; (Custom range which to trigger the activation of the marker)
}

-- If you don't want to include an optional value, then just remove the line, for example, the marker below will work fine

xnMarkers 'Burgershot Carpark' { 					
	['type'] = 1,
	['position'] = vec(-1170.42, -879.55, 13.2),
	['rgba'] = vec(0, 100, 255, 100),
	['scale'] = vec(2, 2, 0.6)
}