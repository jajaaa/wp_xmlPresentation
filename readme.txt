Archiv obsahuje:
- obr - priecinok s pouzitymi obrazkami
- prelozene html subory (presentation.html, contents.html, slide_X.html, kde X je cislo slidu)
- presentation.xml 
- presentation.xsl
- presentation.dtd
- present.css


Preklad:
- do priecinka, kde je saxon dat priecinok xdragunova s mojim riesenim 
- spustit saxon s nasledujucimi parametrami:

java  -jar saxon9.jar  -s:xdragunova\presentation.xml -xsl:xdragunova\presentation.xsl -o:xdragunova\presentation.html



