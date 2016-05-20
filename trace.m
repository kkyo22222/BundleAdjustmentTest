function trace( x,y,oriI,newI,energy,times )
%TRACE Summary of this function goes here
%   Detailed explanation goes here

remainE= energy* sqrt(1/(newI-oriI+1))

hmap(y,x) = hmap(y,x) + remainE;
if x+1 < maxw
    trace(x+1,y,oriI,newI,remainE,times+1);
end

if x-1 >=1
    trace(x-1,y,oriI,newI,remainE,times+1);
end

if y+1 < maxh
    trace(x,y+1,oriI,newI,remainE,times+1);
end

if y-1 >=1
    trace(x,y-1,oriI,newI,remainE,times+1);
end

end

