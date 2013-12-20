--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:e9c91ca7ba46f2ff7979e791146bef50:1/1$
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
            x=4,
            y=4,
            width=64,
            height=64,

        },
        {
            -- heart64
            x=4,
            y=72,
            width=64,
            height=60,

            sourceX = 0,
            sourceY = 2,
            sourceWidth = 64,
            sourceHeight = 64
        },
        {
            -- platform-brown128
            x=464,
            y=4,
            width=128,
            height=48,

        },
        {
            -- platform-brown256
            x=72,
            y=56,
            width=256,
            height=48,

        },
        {
            -- platform-brown64
            x=532,
            y=56,
            width=64,
            height=48,

        },
        {
            -- platform-brownbrick128
            x=332,
            y=56,
            width=128,
            height=48,

        },
        {
            -- platform-brownbrick256
            x=72,
            y=4,
            width=256,
            height=48,

        },
        {
            -- platform-brownbrick512
            x=4,
            y=136,
            width=512,
            height=48,

        },
        {
            -- platform-brownbrick64
            x=520,
            y=108,
            width=64,
            height=48,

        },
        {
            -- platform-green128
            x=596,
            y=4,
            width=128,
            height=40,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 128,
            sourceHeight = 48
        },
        {
            -- platform-green64
            x=524,
            y=160,
            width=64,
            height=40,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 64,
            sourceHeight = 48
        },
        {
            -- platform-rock128
            x=332,
            y=4,
            width=128,
            height=48,

        },
        {
            -- platform-rock256
            x=264,
            y=188,
            width=256,
            height=48,

        },
        {
            -- platform-rock64
            x=464,
            y=56,
            width=64,
            height=48,

        },
        {
            -- propellor256
            x=4,
            y=188,
            width=256,
            height=48,

        },
    },
    
    sheetContentWidth = 1024,
    sheetContentHeight = 256
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
