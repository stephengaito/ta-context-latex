local M = {}

local function initXml(lexerName)
  if lexerName == 'xml' then

    snippets['xml']       = snippets['xml'] or {}
    snippets.xml['xml']   = '<?xml version="1.0" encoding="%1(UTF-8)"?>'
    snippets.xml['!']     = '<!-- %0 -->'
    --
    -- ConTeXt Interface snippets
    --
    snippets.xml['args']    = '<cd:arguments>\n\t%0\n</cd:arguments>'
    snippets.xml['=']       = '<cd:assignments n="1" list="yes" optional="yes">\n\t%0\n</cd:assignments>'
    snippets.xml['cmd']     = '<cd:command name="%1" generated="yes" file="t-%2.tex">\n\t%0\n</cd:command>'
    snippets.xml['const']   = '<cd:constant type="yes" default="yes"/>\n'
    snippets.xml['cont']    = '<cd:content n="%1" optional="%2"/>'
    snippets.xml['inherit'] = '<cd:inherit name="%1"/>\n'
    snippets.xml['intf']    = '<cd:interface xmlns:cd="http://www.pragma-ade.com/commands" name="context" language="en" version="2010.06.21">\n%0\n</cd:interface>'
    snippets.xml['kwd']     = '<cd:keywords n="1" optional="yes">\n\t%0\n</cd:keywords>'
    snippets.xml['parm']    = '<cd:parameter name="spacebefore">\n\t%0\n</cd:parameter>'
    snippets.xml['reslv']   = '<cd:resolve name="style"/>\n'
    snippets.xml['seq']     = '<cd:sequence>\n\t%0\n</cd:sequence>'
    snippets.xml['str']     = '<cd:string value="%1"?>'
    snippets.xml['var']     = '<cd:variable value="fancybreak"/>\n'
    --
    -- additional xml classes taken from existing interface files
    -- cd:word
    -- cd:triplet
    -- cd:tex
    -- cd:template
    -- cd:string
    -- cd:reference
    -- cd:nothing
    -- cd:interfacefile
    -- cd:index
    -- cd:feature
    -- cd:displaymath
    -- cd:description
    -- cd:delimiter
    -- cd:define
    -- cd:csname
    -- cd:content
    -- cd:text
    -- cd:style
    -- cd:singular
    -- cd:section
    -- cd:repeat
    -- cd:plural
    -- cd:path
    -- cd:onergument
    -- cd:number
    -- cd:name
    -- cd:matrix
    -- cd:mark
    -- cd:luafunction
    -- cd:lpath
    -- cd:list
    -- cd:last
    -- cd:language
    -- cd:key
    -- cd:formula
    -- cd:font
    -- cd:first
    -- cd:file
    -- cd:false
    -- cd:true
    -- cd:dimension
    -- cd:content
    -- cd:color
    -- cd:character
    -- cd:category
    -- cd:buffer
    -- cd:angles
    -- cd:apply
  end
end

events.connect(events.LEXER_LOADED, initXml)

return M
