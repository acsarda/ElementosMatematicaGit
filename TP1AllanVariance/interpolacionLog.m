function yConsulta=interpolacionLog(x1,y1,x2,y2,xConsulta)

A=(log10(y2)-log10(y1))/(log10(x2)-log10(x1));
B=log10(xConsulta)-log10(x1);
C=log10(y1)+A*B;
yConsulta=10^C;

end