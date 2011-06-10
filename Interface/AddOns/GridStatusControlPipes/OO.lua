local OO = {}

local function InstantiateClass(class, ...)
    local classMT = getmetatable(class)
    
    local instance = {
        super = classMT.super,
    }    
    
    setmetatable(instance, classMT.MTTemplate)
    
    instance:init(...)
    return instance
end

function OO.NewClass(super)
    local class = {
        prototype = {},
        super = super,
    }
    
    if super then
        setmetatable(class.prototype, {
            __index = super.prototype,
        })
    end
    
    class.new = InstantiateClass;
    
    setmetatable(class, {
        MTTemplate = {
            __index = class.prototype,
        },        
    })
    
    return class
end

AnotherStupidSmallOOLibraryEspeciallyJustAndOnlyForGridStatusControlPipes_GoodEhQuestionmark = OO;