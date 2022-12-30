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
		elseif elem.level == 2 then
			return
			{
				pandoc.RawInline('latex', '\\vspace{\\itemspace}'),
				pandoc.Para(elem.content)
			}
		end
	end

	function DefinitionList (elem)
		return
		{
			pandoc.RawInline('latex', '\\vspace{\\itemspace}'),
			elem
		}
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
		elseif elem.classes:includes('foot', 1) then
			return
			{
				pandoc.RawInline('latex', '\\vspace{2.0ex}'
				.. '\\begin{center}'),
				elem:walk
				{
					Str = function (str) return pandoc.Strong(str) end
				},
				pandoc.RawInline('latex', '\\end{center}')
			}
		end
	end
end

if FORMAT:match 'gfm' then
	function Header (elem)
		if elem.level == 1 then
			elem.level = 2
			return elem
		else 
			return pandoc.Para(elem.content)
		end
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
		elseif elem.classes:includes('foot', 1) then
			return
			{
				pandoc.HorizontalRule(),
				elem:walk
				{
					Str = function (str) return pandoc.Strong(str) end
				}
			}
		end
	end

	function DefinitionList (elem)
		for i, item in ipairs(elem.content) do
			item[1] = pandoc.Strong(item[1])
		end

		return elem
	end
end
