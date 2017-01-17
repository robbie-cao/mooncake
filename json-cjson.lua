local json = require ("cjson")

local P = function (...) end

local tbl = {
    animals = { "dog", "cat", "aardvark" },
    instruments = { "violin", "trombone", "theremin" },
    bugs = json.null,
    trees = nil
}

local str = json.encode (tbl)

P (str)


local tbl = {
    title = "Hello JSON",
    id = math.random(10000),
    arr1 = {
        123,
        "abc",
        { ["key"] = "K", ["val"] = 5678 },
        ["ext"] = { 4, 5, 7 },
    },
    arr2 = { "xxx", "yyy", "zzz" },
    arr3 = {
        a = "xxx",
        b = "yyy",
        "zzz",
    },
    bugs = json.null,
    trees = nil
}

local str = json.encode (tbl)

P (str)


local str = [[
{
    "numbers": [ 2, 3, -20.23e+2, -4 ],
    "currency": "\u20AC"
}
]]

local obj = json.decode(str)
if not obj then
    P ("Error")
else
    P ("currency", obj.currency)
    for i = 1, #obj.numbers do
        P(i, obj.numbers[i])
    end
end

local str = [[
{
    "glossary": {
        "Title": "example glossary",
        "GlossDiv": {
            "Title": "S",
            "GlossList": {
                "GlossEntry": {
                    "ID": "SGML",
                    "SortAs": "SGML",
                    "GlossTerm": "Standard Generalized Markup Language",
                    "Acronym": "SGML",
                    "Abbrev": "ISO 8879:1986",
                    "GlossDef": {
                        "Para": "A meta-markup language, used to create markup languages such as DocBook.",
                        "GlossSeeAlso": ["GML", "XML"]
                    },
                    "GlossSee": "markup"
                }
            }
        }
    }
}
]]

local obj = json.decode(str)
if not obj then
    P ("Error:")
else
    P ("glossary", obj.glossary)
    do
        inspect = require("inspect")
        P(inspect(getmetatable(obj.glossary)))
    end
    P(obj.glossary.Title)
    P(obj.glossary.GlossDiv.Title)
    P(obj.glossary.GlossDiv.GlossList.GlossEntry.ID)
    P(obj.glossary.GlossDiv.GlossList.GlossEntry.SortAs)
    P(obj.glossary.GlossDiv.GlossList.GlossEntry.GlossTerm)
    P(obj.glossary.GlossDiv.GlossList.GlossEntry.Acronym)
    P(obj.glossary.GlossDiv.GlossList.GlossEntry.Abbrev)
    P(obj.glossary.GlossDiv.GlossList.GlossEntry.GlossDef.Para)
    for i = 1, #obj.glossary.GlossDiv.GlossList.GlossEntry.GlossDef.GlossSeeAlso do
        P(obj.glossary.GlossDiv.GlossList.GlossEntry.GlossDef.GlossSeeAlso[i])
    end
    P(obj.glossary.GlossDiv.GlossList.GlossEntry.GlossSee)
end


local str = [[
{
    "menu": {
        "id": "file",
        "value": "File",
        "popup": {
            "menuitem": [
            {"value": "New", "onclick": "CreateNewDoc()"},
            {"value": "Open", "onclick": "OpenDoc()"},
            {"value": "Close", "onclick": "CloseDoc()"}
            ]
        }
    }
}
]]

local obj = json.decode(str)
if not obj then
    P ("Error:")
else
    P ("menu", obj.menu)
    do
        inspect = require("inspect")
        P(inspect(getmetatable(obj.menu)))
    end
    P(obj.menu.id)
    P(obj.menu.value)
    for i = 1, #obj.menu.popup.menuitem do
        P(obj.menu.popup.menuitem[i].value, obj.menu.popup.menuitem[i].onclick)
    end
end


local str = [[
{
    "widget": {
        "debug": "on",
        "window": {
            "title": "Sample Konfabulator Widget",
            "name": "main_window",
            "width": 500,
            "height": 500
        },
        "image": {
            "src": "Images/Sun.png",
            "name": "sun1",
            "hOffset": 250,
            "vOffset": 250,
            "alignment": "center"
        },
        "text": {
            "data": "Click Here",
            "size": 36,
            "style": "bold",
            "name": "text1",
            "hOffset": 250,
            "vOffset": 100,
            "alignment": "center",
            "onMouseUp": "sun1.opacity = (sun1.opacity / 100) * 90;"
        }
    }
}
]]

local obj = json.decode(str)
if not obj then
    P ("Error:")
else
    P ("widget", obj.widget)
    do
        inspect = require("inspect")
        P(inspect(getmetatable(obj.widget)))
    end
    P(obj.widget.debug)
    P(obj.widget.window.title, obj.widget.window.name, obj.widget.window.width, obj.widget.window.height)
    P(obj.widget.image.src, obj.widget.image.name, obj.widget.image.hOffset, obj.widget.image.vOffset, obj.widget.image.alignment)
    P(obj.widget.text.data, obj.widget.text.size, obj.widget.text.style, obj.widget.text.name, obj.widget.text.hOffset, obj.widget.text.vOffset, obj.widget.text.alignment, obj.widget.text.onMouseUp)
end
