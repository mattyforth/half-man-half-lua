#!/usr/bin/env lua

local http = require("http.request")

-- Perform a request to get a half man half biscuit lyric
local url = "https://halfmanhalfbiscuit.uk/rantex.php"
local request = http.new_from_uri(url)

local headers, stream = request:go()
local body = stream:get_body_as_string()

-- print(body .. "\n")

if headers:get(":status") ~= "200" then
	error(body)
end

-- Grab the lyric from the response
--
-- Sometimes the lyrics are returned in h1, and other times
-- they are returned in h2, so to solve this we can regex a generic tag.
local openingTagStart, openingTagEnd = string.find(body, "<h%d>")
local closingTagStart = string.find(body, "</h%d>")

local lyric = string.sub(body, openingTagEnd + 1, closingTagStart - 1)
lyric = lyric:gsub("<br%s?%/?>", "\n")
lyric = lyric:gsub("\\", "")

-- Print it to the screen
print(lyric)
