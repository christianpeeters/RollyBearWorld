--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:e2b2e8b0e67c86e3da3c4cb4d0e4e22a:1/1$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- crate64
            x=2,
            y=2,
            width=32,
            height=32,

        },
        {
            -- heart64
            x=2,
            y=36,
            width=32,
            height=30,

            sourceX = 0,
            sourceY = 1,
            sourceWidth = 32,
            sourceHeight = 32
        },
        {
            -- platform-brown128
            x=232,
            y=2,
            width=64,
            height=24,

        },
        {
            -- platform-brown256
            x=36,
            y=28,
            width=128,
            height=24,

        },
        {
            -- platform-brown64
            x=266,
            y=28,
            width=32,
            height=24,

        },
        {
            -- platform-brownbrick128
            x=166,
            y=28,
            width=64,
            height=24,

        },
        {
            -- platform-brownbrick256
            x=36,
            y=2,
            width=128,
            height=24,

        },
        {
            -- platform-brownbrick512
            x=2,
            y=68,
            width=256,
            height=24,

        },
        {
            -- platform-brownbrick64
            x=260,
            y=54,
            width=32,
            height=24,

        },
        {
            -- platform-green128
            x=298,
            y=2,
            width=64,
            height=20,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 64,
            sourceHeight = 24
        },
        {
            -- platform-green64
            x=262,
            y=80,
            width=32,
            height=20,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 32,
            sourceHeight = 24
        },
        {
            -- platform-rock128
            x=166,
            y=2,
            width=64,
            height=24,

        },
        {
            -- platform-rock256
            x=132,
            y=94,
            width=128,
            height=24,

        },
        {
            -- platform-rock64
            x=232,
            y=28,
            width=32,
            height=24,

        },
        {
            -- propellor256
            x=2,
            y=94,
            width=128,
            height=24,

        },
    },
    
    sheetContentWidth = 512,
    sheetContentHeight = 128
}

SheetInfo.frameIndex =
{

    ["crate64"] = 1,
    ["heart64"] = 2,
    ["platform-brown128"] = 3,
    ["platform-brown256"] = 4,
    ["platform-brown64"] = 5,
    ["platform-brownbrick128"] = 6,
    ["platform-brownbrick256"] = 7,
    ["platform-brownbrick512"] = 8,
    ["platform-brownbrick64"] = 9,
    ["platform-green128"] = 10,
    ["platform-green64"] = 11,
    ["platform-rock128"] = 12,
    ["platform-rock256"] = 13,
    ["platform-rock64"] = 14,
    ["propellor256"] = 15,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
