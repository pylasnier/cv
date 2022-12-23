if FORMAT:match 'latex' then
    function Header (elem)
		if elem.level == 1 then
			return pandoc.RawInline(
			    'latex',
				'\\begin{Large}'
				.. (function () for i, cls in ipairs(elem.classes) do
					if cls == 'norule' then
						return '' end end
					return '\n\n\\vspace{-1.5ex}'
					       .. '\\rule{\\textwidth}{0.8pt}' end)()
				.. '\\vspace{2ex}\n\n'
				.. '\\ruledheader{blue}{'
				.. pandoc.utils.stringify(elem.content)
				.. '}'
				.. '\\end{Large}')
		end
	end

	-- function DefinitionList (elem)
	-- 	return
	-- 	{
	-- 		pandoc.RawInline('latex', '\\begingroup\n'
	-- 		    .. '\\setlist{align=right}\n'
	-- 			.. '\\setlist{leftmargin=10mm}\n'
	-- 			.. '\\setlist{labelsep=5mm}\n'),
	-- 		elem,
	-- 		pandoc.RawInline('latex', '\\endgroup\n')
	-- 	}
	-- end
end
