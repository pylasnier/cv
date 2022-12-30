$for(header-includes)$
$header-includes$

$endfor$
$for(include-before)$
$include-before$

$endfor$
$if(toc)$
$table-of-contents$

$endif$
$if(name)$
# $name$

$endif$
$if(email)$
$email$  
$endif$
$if(phone)$
$phone$  
$endif$
$if(website)$
[$website$](https://$website$)
$endif$
$if(address)$

$address$
$endif$

$body$
$for(include-after)$

$include-after$
$endfor$
