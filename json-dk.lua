local json = require ("dkjson")

local P = print
if true or arg[1] == "off" then
    print = function (...)
    end
end

local tbl = {
    animals = { "dog", "cat", "aardvark" },
    instruments = { "violin", "trombone", "theremin" },
    bugs = json.null,
    trees = nil
}

local str = json.encode (tbl, { indent = true })

print (str)


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

local str = json.encode (tbl, { indent = true })

print (str)


local str = [[
{
    "numbers": [ 2, 3, -20.23e+2, -4 ],
    "currency": "\u20AC"
}
]]

local obj, pos, err = json.decode (str, 1, nil)
if err then
    print ("Error:", err)
else
    print ("currency", obj.currency)
    for i = 1, #obj.numbers do
        print(i, obj.numbers[i])
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

local obj, pos, err = json.decode (str, 1, nil)
if err then
    print ("Error:", err)
else
    print ("glossary", obj.glossary)
    do
        inspect = require("inspect")
        print(inspect(getmetatable(obj.glossary)))
    end
    print(obj.glossary.Title)
    print(obj.glossary.GlossDiv.Title)
    print(obj.glossary.GlossDiv.GlossList.GlossEntry.ID)
    print(obj.glossary.GlossDiv.GlossList.GlossEntry.SortAs)
    print(obj.glossary.GlossDiv.GlossList.GlossEntry.GlossTerm)
    print(obj.glossary.GlossDiv.GlossList.GlossEntry.Acronym)
    print(obj.glossary.GlossDiv.GlossList.GlossEntry.Abbrev)
    print(obj.glossary.GlossDiv.GlossList.GlossEntry.GlossDef.Para)
    for i = 1, #obj.glossary.GlossDiv.GlossList.GlossEntry.GlossDef.GlossSeeAlso do
        print(obj.glossary.GlossDiv.GlossList.GlossEntry.GlossDef.GlossSeeAlso[i])
    end
    print(obj.glossary.GlossDiv.GlossList.GlossEntry.GlossSee)
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

local obj, pos, err = json.decode (str, 1, nil)
if err then
    print ("Error:", err)
else
    print ("menu", obj.menu)
    do
        inspect = require("inspect")
        print(inspect(getmetatable(obj.menu)))
    end
    print(obj.menu.id)
    print(obj.menu.value)
    for i = 1, #obj.menu.popup.menuitem do
        print(obj.menu.popup.menuitem[i].value, obj.menu.popup.menuitem[i].onclick)
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

local obj, pos, err = json.decode (str, 1, nil)
if err then
    print ("Error:", err)
else
    print ("widget", obj.widget)
    do
        inspect = require("inspect")
        print(inspect(getmetatable(obj.widget)))
    end
    print(obj.widget.debug)
    print(obj.widget.window.title, obj.widget.window.name, obj.widget.window.width, obj.widget.window.height)
    print(obj.widget.image.src, obj.widget.image.name, obj.widget.image.hOffset, obj.widget.image.vOffset, obj.widget.image.alignment)
    print(obj.widget.text.data, obj.widget.text.size, obj.widget.text.style, obj.widget.text.name, obj.widget.text.hOffset, obj.widget.text.vOffset, obj.widget.text.alignment, obj.widget.text.onMouseUp)
end

print = P
