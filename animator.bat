echo off

rem %1 input filename without extension
rem %2 frame rate
rem %3 animate options such as palindrome, controls, autoplay, scale=1, loop, etc

rem pre-cleaning
for %%x in (aux log dvi ps pdf svg) do (if exist "%~1.%%x" del "%~1.%%x")

latex "%~1.tex"
dvips "%~1.dvi"
ps2pdf "%~1.ps"

latex  --jobname="%~1" "\def\FileName{%~1}\def\FrameRate{%2}\def\Options{%~3}\def\Border{%4}\input{wrapper}"

dvisvgm --bbox=papersize --font-format=woff --zoom=-1 --precision=3 "%~1" 

rem post-cleaning
for %%x in (aux log dvi ps) do (if exist "%~1.%%x" del "%~1.%%x")

