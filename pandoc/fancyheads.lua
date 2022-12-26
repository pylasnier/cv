if FORMAT:match 'latex' then
    function Header (elem)
		if elem.level == 1 then
			return pandoc.RawInline('latex',
				'\\begin{Large}'
				-- .. (function () for i, cls in ipairs(elem.classes) do
				-- 	if cls == 'norule' then
				-- 		return '' end end
				-- 	return '\n\n\\vspace{-1.5ex}'
				-- 	       .. '\\rule{\\textwidth}{0.8pt}' end)()
				.. (elem.classes:find('norule', 1) == nil and
				       '\n\n\\vspace{-1.5ex}'
					   .. '\\rule{\\textwidth}{0.8pt}'
				   or
					   '')
				.. '\\vspace{2ex}\n\n'
				.. '\\ruledheader{cyan!50!teal}{'
				.. pandoc.utils.stringify(elem.content)
				.. '}'
				.. '\\end{Large}')
		end
	end

	function Div (elem)
		if elem.classes:find('widelist', 1) ~= nil then
			return
			{
				pandoc.RawInline('latex',
					'\\begingroup\n'
			        .. '\\begin{multicols}{3}\n'
					.. '\\setlist{label=, leftmargin=0mm}'),
                elem,
				pandoc.RawInline('latex',
			        '\\end{multicols}\n'
					.. '\\vspace{-\\parskip}'
					.. '\\endgroup')
			}
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
