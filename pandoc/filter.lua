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
				.. (not elem.classes:includes('norule', 1) and
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
		if elem.classes:includes('widelist', 1) then
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
end

if FORMAT:match 'gfm' then
	function Header (elem)
		elem.level = elem.level + 1
		return elem
	end
	
	function Div (elem)
		if elem.classes:includes('widelist', 1) then
			return elem.content:walk
			{
				BulletList = function (listelem)
					listelem.content = listelem.content:filter (
						function (item)
							return pandoc.utils.stringify(item) ~= ''
						end)
					return listelem
				end
			}
		end
	end
end
