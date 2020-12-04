debug.setmetatable(vec(0,0,0,0), {
    __index = function(self, value)
        if value == 'r' then
            return math.floor(self.x)
        elseif value == 'g' then
            return math.floor(self.y)
        elseif value == 'b' then
            return math.floor(self.z)
        elseif value == 'a' then
            return math.floor(self.w)
        else
            return 0
        end
    end
})

xnMarkers = {}

AddEventHandler('getMapDirectives', function(add)
    add('xnMarkers', function(state, name)
		return function(mData)
			if xnMarkers[name] then return end

			local rangeToShow = mData.rangeToShow ~= nil and mData.rangeToShow or 50.0
			local bobUpAndDown = mData.bobUpAndDown or false
			local mScale = mData.scale ~= nil and mData.scale or vec(1, 1, 1)
			local mRot = mData.rotation ~= nil and mData.rotation or vec(0, 0, 0)
			local mDir = mData.direction ~= nil and mData.direction or vec(0, 0, 0)
			local faceCamera = mData.faceCamera or false
			local textureDict = mData.textureDict or nil
			local textureName = mData.textureName or nil
			local mActivateRange = mData.activateRange ~= nil and mData.activateRange or mScale.x
			local rgba = mData.rgba
			
			local markerData = {
				range = rangeToShow,
				mType = mData.type,
				pos = mData.position,
				dir = mDir,
				rot = mRot,
				scale = mScale,
				r = rgba.r,
				g = rgba.g,
				b = rgba.b,
				a = rgba.a,
				bob = bobUpAndDown,
				faceCam = faceCamera,
				dict = textureDict,
				name = textureName,
				activateRange = mActivateRange,
				isInside = false,
				deleteNow = false
			}
			
			xnMarkers[name] = markerData
		end
    end)
end)

function xnMarkers_Remove(markerKey)
	xnMarkers[markerKey].deleteNow = true
end

function ReqTexture(dict)
	RequestStreamedTextureDict(dict)
	while not HasStreamedTextureDictLoaded(dict) do
		Wait(0)
	end
end

local markerWait = 500
CreateThread(function()
	while true do
		Wait(markerWait)
		markerWait = 500
		for markerKey, marker in pairs(xnMarkers) do
			if marker.deleteNow then
				marker = nil
			else
				local ped = PlayerPedId()
				local pedCoords = GetEntityCoords(ped)
				if #(pedCoords - marker.pos) < marker.range then
					local textureDict = marker.textureDict
					markerWait = 1
					if textureDict ~= nil and not HasStreamedTextureDictLoaded(textureDict) then
						ReqTexture(textureDict)
					end
					DrawMarker(marker.mType, marker.pos, marker.dir, marker.rot, marker.scale, marker.r, marker.g, marker.b, marker.a, marker.bob, marker.faceCam, 0, false, marker.dict, marker.name, false)
				else
					local textureDict = marker.textureDict
					if textureDict ~= nil and HasStreamedTextureDictLoaded(textureDict) then
						SetStreamedTextureDictAsNoLongerNeeded(textureDict)
					end
				end
				if #(pedCoords - marker.pos) < marker.activateRange then
					if not marker.isInside then
						TriggerServerEvent("xnMarkers:IsInMarker", markerKey)
						TriggerEvent("xnMarkers:IsInMarker", markerKey)
						marker.isInside = true
					end
				else
					marker.isInside = false
				end
			end
		end
	end
end)

exports("Remove", xnMarkers_Remove)